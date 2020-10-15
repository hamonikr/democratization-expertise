<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>

<body>
<form id="frm" name="frm" method="post">
<input type="hidden" name="seq" value="${result.seq }" />
<input type="hidden" name="consent" value="${result.consent }" />
<input type="hidden" name="request" value="${result.request }" />
<input type="hidden" name="business_code" value="${result.business_code }" />
<input type="hidden" name="bizcd" value="${result.bizcd }" />
<input type="hidden" name="writer_id" value="${result.writer_id }" />
<input type="hidden" name="writer_name" value="${result.writer_name }" />
<input type="hidden" name="price" value="${result.price }" />
<input type="hidden" name="sale_qy" value="${result.sale_qy }" />
<input type="hidden" name="product_section" value="${result.product_section }" />
<input type="hidden" name="instt_name" value="${result.instt_name }" />

<!-- 스프링 시큐리티 form에 추가 해줘야함. -->
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

<div class="row">

<div id="input_div" class="col-12 " style="margin-top: .75rem;">
		<div class="callout callout-info row ">
			<div class="col-6">
				<h5>판매계획서 상세</h5>
			</div>
			<div class="col-6">
				<span class="float-right  "><a href="/main/index">Home</a> / 비즈니스 / 판매계획서 상세</span>
			</div>
		</div>
	</div>
	

    <!-- Content Header (Page header) -->
   	<div class="col-12">
		<div class="card card-primary">
			
			<div class="row mb-2">
				<div class="col-sm-12">
					<h5>판매계획서 상세</h5>
				</div>
			</div>
			
			<div class="card-body card-primary card-outline row">

				<div class="col-lg-12">
					<div class="form-group">
						<label for="inputEmail3" class="col-form-label">제목</label>
						<span  class="form-control">${result.subject}</span>
					 </div>
				 </div>
				
				<div class="col-lg-3">
					<div class="form-group">
						<label for="inputEmail3" class="col-form-label">기관명</label>
						<span  class="form-control">${result.instt_name}</span>
					 </div>
				 </div>
				
				<div class="col-lg-3">
					<div class="form-group">
						<label for="inputEmail3" class="col-form-label">소비자 가격</label>
						<span  class="form-control">${result.price} 원</span>
					 </div>
				 </div>
				
				<div class="col-lg-3">
					<div class="form-group">
						<label for="inputEmail3" class="col-form-label">판매수량</label>
						<span  class="form-control">${result.sale_qy} 대</span>
					 </div>
				 </div>
				
				<div class="col-lg-3">
					<div class="form-group">
						<label for="inputEmail3" class="col-form-label">할인요율</label>
						<span  class="form-control">${result.discount} %</span>
					 </div>
				 </div>
				
				<div class="col-lg-6">
					<div class="form-group">
						<label for="inputEmail3" class="col-form-label">제품분류</label>
						<span  class="form-control">${product.subject}</span>
					 </div>
				 </div>
				
				<div class="col-lg-6">
					<div class="form-group">
						<label for="inputEmail3" class="col-form-label">기관분류</label>
						<span  class="form-control">
							<c:if test="${result.instt_section eq 'public'}">공공기관</c:if>
							<c:if test="${result.instt_section eq 'private'}">민간기업</c:if>
						</span>
					 </div>
				 </div>
				
				<div class="col-lg-12">
					<div class="form-group">
						<label for="inputEmail3" class="col-form-label">상세내용</label>
						<span  class="form-control contents">${result.content}</span>
					 </div>
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
				<c:if test="${result.consent eq 1 and result.request eq 1}">
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
	document.frm.seq.value="";
	document.frm.action = "/contract/save.ivs";
	document.frm.submit();
}
</script>
</body>
</html>