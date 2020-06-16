<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>
<style>
label {margin-left:10px;}
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
<section class="content">
<section class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1>계약서 상세</h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active">계약서 상세</li>
            </ol>
          </div>
        </div>
      </div><!-- /.container-fluid -->
    </section>
<!-- general form elements -->
              <div class="card card-secondary">
              <div class="card-header">
                <h3 class="card-title">계약주요 사항</h3>
              </div>
              <div class="card-body">
              <div class="row">
              <div class="col-md-6">
                  <div class="form-group">
                    <label for="contract">계약명</label>
                    <div class="form-control">
                    <c:out value="${result.contract}"/>
                    </div>
                  </div>
                  <!-- Date range -->
                <div class="form-group">
                  <label for="contract_period">계약기간</label>
                  <div class="form-control">
                  <c:out value="${result.contract_period}"/>
                  </div>
                </div>
                <!-- /.form group -->
                  </div>
                  <div class="col-md-6">
                  	<div class="form-group">
                    <label for="contract_amount">총금액</label>
                    <c:set value="${result.contract_amount}" var="contract_amount" />
                    <div id="contract_amount" class="form-control"></div>
                  </div>
                  <div class="form-group">
                  <label for="contract_date">계약체결일</label>
                  <div class="form-control">
                  	<c:out value="${result.contract_date}"/>
                  	</div>
                    <%-- <fmt:formatDate value="${result.contract_date}" pattern="yyyy-MM-dd" /> --%>
                </div>
                </div>
              </div>
            </div>
          </div>
            <div class="card card-secondary">
              <div class="card-header">
                <h3 class="card-title">계약당사자</h3>
              </div>
              <div class="card-body">
              <div class="row">
              <div class="col-md-6">
                  <div class="form-group">
                    <label for="demand_name">수요자 상호</label>
                    <div class="form-control">
                    <c:out value="${result.demand_name}"/>
                    </div>
                  </div>
                  <div class="form-group">
                    <label for="demand_addr">주소</label>
                    <div class="form-control">
                    <c:out value="${result.demand_addr}"/>
                    </div>
                  </div>
                  <div class="form-group">
                    <label for="demand_bizno">사업자번호</label>
                    <div class="form-control">
                    <c:out value="${result.demand_bizno}"/>
                    </div>
                  </div>
                  <div class="form-group">
                    <label for="demand_cxfc">대표이사</label>
                    <div class="form-control">
                    <c:out value="${result.demand_cxfc}"/>
                    </div>
                  </div>
                  </div>
                  <div class="col-md-6">
                  	<div class="form-group">
                    <label for="supply_name">공급자 상호</label>
                    <div class="form-control">
                    <c:out value="${result.supply_name}"/>
                    </div>
                  </div>
                  <div class="form-group">
                    <label for="supply_addr">주소</label>
                    <div class="form-control">
                    <c:out value="${result.supply_addr}"/>
                    </div>
                  </div>
                  <div class="form-group">
                    <label for="supply_bizno">사업자번호</label>
                    <div class="form-control">
                    <c:out value="${result.supply_bizno}"/>
                    </div>
                  </div>
                  <div class="form-group">
                    <label for="supply_cxfc">대표이사</label>
                    <div class="form-control">
                    <c:out value="${result.supply_cxfc}"/>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="card card-secondary">
              <div class="card-header">
                <h3 class="card-title">계약품목</h3>
              </div>
              <div class="card-body">
              <div class="row">
              <div class="col-md-6">
                  <div class="form-group">
                    <label for="product_section">아이템코드</label>
                    <div class="form-control">
                    <c:out value="${result.product_section}"/>
                    </div>
                  </div>
                  <div class="form-group">
                    <label for="product_name">품명</label>
                    <div class="form-control">
                    <c:out value="${result.product_name}"/>
                    </div>
                  </div>
                  <div class="form-group">
                    <label for="sale_qy">수량</label>
                    <c:set value="${result.sale_qy}" var="sale_qy" />
                    <div id="sale_qy" class="form-control"></div>
                  </div>
                  </div>
                  <div class="col-md-6">
                  	<div class="form-group">
                    <label for="price">단가</label>
                    <c:set value="${result.price}" var="price" />
                    <div id="price" class="form-control"></div>
                  </div>
                  <div class="form-group">
                    <label for="contract_amount">금액</label>
                    <c:set value="${result.price * result.sale_qy}" var="total_price" />
                    <div id="total_price" class="form-control"></div>
                  </div>
                  <div class="form-group">
                  <label>납품일</label>
                  <div class="form-control">
                  	<c:out value="${result.offer_date}"/>
                  	</div>
                    <%-- <fmt:formatDate value="${result.offer_date}" pattern="yyyy-MM-dd" /> --%>
                </div>
                </div>
              </div>
            </div>
          </div>
                  <div class="card-body">
                  <div class="form-group">
                    <label for="contract_cnd">계약조건</label>
                                        <div class="code-html">
						                <div id="editSection">${result.contract_cnd }</div> 
						            </div>
                  </div>
                </div>
                  <div class="card-body">
                  <div class="form-group">
                    <label for="special_contract">특약사항</label>
                                        <div class="code-html">
						                <div id="editSection2">${result.special_contract }</div> 
						            </div>
                  </div>
                </div>
                <div class="card-body">
                  <div class="form-group">
                    <label for="filename">계약서 첨부</label>
					<c:forEach items="${file }" var="item" varStatus="status">
	          	<a href="/fileDownload?fm=${item.filemakename}&fom=${item.filerealname}">${item.filerealname}</a>
	          	</c:forEach>
                  </div>
                </div>
                </section>
    </form>
    <div class="card-footer">
    	 <c:if test="${result.consent eq 1 and result.request eq 0}">
    	 <button type="button" id="btnContract" class="btn btn-primary">계약서 상세 등록</button>
    	 </c:if>
    	 <c:if test="${result.consent eq 0 and result.request eq 0}">
       <button type="button" id="btnUpdate" class="btn btn-primary"> 수정</button>
       <button type="button" id="btnRequest" class="btn btn-primary">승인요청</button>
       </c:if>
       <c:if test="${result.request eq 1 and result.consent eq 0}">
    	 <button type="button" id="btnRequest" class="btn btn-primary">승인요청취소</button>
    	 </c:if>
       <button type="button" class="btn btn-primary" onclick="location.href='list.ivs'"> 목록</button>
   </div>
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