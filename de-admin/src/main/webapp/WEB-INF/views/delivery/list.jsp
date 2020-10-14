<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>

<style>
.card.bg-light { 
	box-shadow: 0 0 3px rgba(0,0,0,.25);
	overflow: hidden; 
}
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
	font-size: 12px; 
	margin: 0;
	padding: 5px 15px;
}
</style>

<body>
<form id="frm" name="frm" action="" method="post">
<input type="hidden" name="pageNo" value="${paginationInfo.currentPageNo }" />
<input type="hidden" name="seq" id="seq" value="" />
<input type="hidden" name="business_code" id="business_code" value="" />
<input type="hidden" name="bizcd" id="bizcd" value="" />
<input type="hidden" name="demand_name" id="demand_name" value="" />
<!-- 스프링 시큐리티 form에 추가 해줘야함. -->
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>


<div class="row">

	<div id="input_div" class="col-12 " style="margin-top: .75rem;">
		<div class="callout callout-info row ">
			<div class="col-6">
				<h5>납품관리 현황</h5>
			</div>
			<div class="col-6">
				<span class="float-right  "><a href="/main/index">Home</a> / 비즈니스 / 납품관리 현황</span>
			</div>
		</div>
	</div>
	

<!-- general form elements -->
	<div class="col-12">
		<div class="card card-primary">
			
			<div class="row mb-2">
				<div class="col-sm-12">
					<h5>납품관리 현황</h5>
				</div>
			</div>
			
			<div class="card-body card-primary card-outline row">
			
				<c:forEach var="list" items="${list}" varStatus="status">
					
					<div class="col-lg-4">
		              <div class="card bg-light">
		                <div class="card-header text-muted border-bottom-0">
		                  ${ list.contract }
		                </div>
		                <div class="card-body mt-0 p-3 pl-4 pr-4">
		                  <div class="row">
		                  	
		                  	<%-- <div class="col-12">
		                  		<h2 class="lead"><b>${list.business_code}</b></h2>
		                  	</div> --%>
		                  	
		                    <div class="col-12">
		                      <ul class="ml-4 mb-0 fa-ul text-muted">
		                        <li class="small mb-2"><span class="fa-li"></span> <b>상품명 : </b>${list.product_name}</li>
		                        <li class="small mb-2"><span class="fa-li"></span> <b>계약번호 : </b>${list.business_code}</li>
		                        <li class="small mb-2"><span class="fa-li"></span> <b>라이센스 : </b>${list.sale_qy} 개 <a href="#" onclick="fnExcel('${list.business_code}','${list.demand_name}')" ><i class="fa fa-save"></i></a></li>
		                        <li class="small"><span class="fa-li"></span> <b>납품일시 : </b>${list.offer_date}</li>
		                      </ul>
		                    </div>
		                    
		                    <!-- 
		                    <div class="col-5 text-center">
		                    	<img src="../../dist/img/user1-128x128.jpg" alt="" class="img-circle img-fluid">
		                    </div>
		                    -->
		                  </div>
		                </div>
		                
		                <div class="card-footer cont_btn_div">
							<button type="button" onclick="view('${list.seq}');" class="btn btn-sm btn-primary purple">계약서 보기</button>
							<button type="button" onclick="license('${list.business_code}','${list.bizcd}');" class="btn btn-sm btn-primary purple">라이센스 보기</button>
		                </div>
		                
		              </div>
		            </div>
					
				</c:forEach>
			</div>
			
			<div class="card-footer row">
				<!-- page number -->
				<ul class="pagination justify-content-left m-0 col-12">
					<ui:pagination paginationInfo = "${paginationInfo}" type="text" jsFunction="linkPage"/>
				</ul>
			</div>
		</div>
	</div>
</div>
</form>
</body>

<script type="text/javascript">
$(function() {
	//엑셀다운로드 버튼
    $("#btnExcel").click(fnExcel);
});

	function linkPage(pageNo){
		location.href = "list.ivs?pageNo="+pageNo;
	}

	function view(seq){
		document.getElementById("seq").value=seq;
		document.frm.action = "/contract/view.ivs";
		document.frm.submit();
	}
	
	function license(x,y){
		document.getElementById("business_code").value=x;
		document.getElementById("bizcd").value=y;
		document.frm.action = "/lcns/view.ivs";
		document.frm.submit();
	}
	//엑셀다운로드
	function fnExcel(x,z){
		document.frm.business_code.value=x;
		document.frm.demand_name.value=z;
		document.frm.action = "excel.proc";
		document.frm.submit();
	}
</script>