<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>
 <style>
 .maincontent > .container-fluid > .row { padding-top: 1.5em }
.maincontent .col-lg-4,
.maincontent .col-lg-8,
.maincontent .col-md-12 { 
	padding-right: 15px;
	padding-left: 15px;
}
.maincontent .card {
	background: #fff;
	box-shadow: 0 0 10px rgba(0,0,0,.25);
	margin-bottom: 2rem;
}
.maincontent .card-header { padding: .5rem 1rem 0rem 1rem }
.maincontent .card-header a {
	color: #BDBDBD;
	float: right;
	font-size: 25px;
	font-weight: bold;
	margin-top: -8px;
	transform: rotate(-90deg);
}

.maincontent .card-body { 
	background-color: rgba(0,0,0,0);
	border-top: 0;
}

.maincontent .card-body .list-unstyled { 
	margin: 0;
	padding: 1rem 1rem 0 1rem;
}
.maincontent .card-body .list-unstyled .dash_card_text1,
.maincontent .card-body .list-unstyled .dash_card_text2 {
	display: inline-block;
	overflow: hidden;
	text-decoration: none;
	text-overflow: ellipsis;
	white-space: nowrap;
	width: 70%;
}
.maincontent .card-body .list-unstyled .dash_card_text2 { width: 90% }
.maincontent .card-body .list-unstyled .dash_card_status { float: right }
.maincontent .card-body .list-unstyled .nodata { 
	display: block;
	text-align: center; 
}

.maincontent .card-body .col-6:first-child { border-right: 1px solid #DDD }
.maincontent .card-body .col-6 .list-unstyled { margin: 0 }
.card-body.p-0.row .col-6 { margin-bottom: .5em!important }
</style>

<body>
    <!-- Main content -->
    <div class="content maincontent">
      <div class="container-fluid">
        <div class="row">
			<div class="col-lg-12">
	            <div class="card">
	              <div class="card-header border-0">
	                <div class="d-flex justify-content-between">
	                  <h3 class="card-title">공지사항</h3>
	                  <a href="/notice/list.ivs">...</a>
	                </div>
	              </div>
	              <div class="card-body p-0 row">
	              	<div class="col-6">
		              	<ul class="list-unstyled">
		                  <c:forEach items="${notice }" var="item" varStatus="status">
			                  <c:if test="${ status.count < 4 }">
			                  	<li>
									<a href="#" class="dash_card_text1">${item.title }</a>
									<!-- <span class="dash_card_status">${item.consent }</span> -->
								</li>
			                  </c:if>
		                  </c:forEach>
		                  <c:if test="${empty estimate}"> <!-- 게시물이 없을 경우 -->
							<li><p class="nodata">결과가 없습니다.</p></li>
							</c:if>
						</ul>
	              	</div>
	              	
	              	<div class="col-6">
		              	<ul class="list-unstyled">
		                  <c:forEach items="${notice }" var="item" varStatus="status">
		                  	<c:if test="${ status.count > 3 }">
			                  	<li>
									<a href="#" class="dash_card_text1">${item.title }</a>
								</li>
							</c:if>
		                  </c:forEach>
		                  <c:if test="${empty estimate}"> <!-- 게시물이 없을 경우 -->
							<li><p class="nodata">결과가 없습니다.</p></li>
							</c:if>
						</ul>
	              	</div>
	              </div>
	            </div>
			</div>
		
          <div class="col-lg-4">
            <div class="card">
              <div class="card-header border-0">
                <div class="d-flex justify-content-between">
                  <h3 class="card-title">견적요청</h3>
                  <a href="/estimate/list.ivs">...</a>
                </div>
              </div>
              <div class="card-body p-0">
              	<ul class="list-unstyled">
                  <c:forEach items="${estimate }" var="item" varStatus="status">
                  	<li>
						<span class="dash_card_text1">- ${item.subject }</span>
						<span class="dash_card_status">${item.consent }</span>
					</li>
                  </c:forEach>
                  <c:if test="${empty estimate}"> <!-- 게시물이 없을 경우 -->
					<li><p class="nodata">결과가 없습니다.</p></li>
					</c:if>
				</ul>
              </div>
            </div>
		</div>


		<div class="col-lg-4">
            <div class="card">
              <div class="card-header border-0">
                <div class="d-flex justify-content-between">
                  <h3 class="card-title">판매계획관리</h3>
                  <a href="/saleplan/list.ivs">...</a>
                </div>
              </div>
              <div class="card-body p-0">
                <ul class="list-unstyled">
                  <c:forEach items="${saleplan }" var="item" varStatus="status">
                    <li>
					<span class="dash_card_text1">- ${item.subject }</span>
					<span class="dash_card_status">${item.consent }</span>
                  </li>
                  </c:forEach>
                  <c:if test="${empty saleplan}"> <!-- 게시물이 없을 경우 -->
					<li><p class="nodata">결과가 없습니다.</li>
					</c:if>
				</ul>
              </div>
            </div>
		</div>


		<div class="col-lg-4">
            <div class="card">
              <div class="card-header border-0">
              <div class="d-flex justify-content-between">
                  <h3 class="card-title">계약서 관리</h3>
                  <a href="/contract/list.ivs">...</a>
                </div>
              </div>
              <div class="card-body p-0">
              	<ul class="list-unstyled">
                  <c:forEach items="${contract }" var="item" varStatus="status">
                  	<li>
					<span class="dash_card_text1">- ${item.contract }</span>
                    <span class="dash_card_status">${item.consent }</span>
					</li>
                  </c:forEach>
                  <c:if test="${empty contract}"> <!-- 게시물이 없을 경우 -->
					<li><p class="nodata">결과가 없습니다.</p></li>
					</c:if>
				</ul>
              </div>
            </div>
          </div>
          
		<div class="col-lg-4">
            <div class="card">
              <div class="card-header border-0">
              <div class="d-flex justify-content-between">
                <h3 class="card-title">납품관리</h3>
                <a href="/delivery/list.ivs">...</a>
                </div>
              </div>
              <div class="card-body p-0">
              	<ul class="list-unstyled">
              		<c:forEach items="${delivery }" var="item" varStatus="status">
              			<li>
							<span class="dash_card_text2">- ${item.demandName }</span>
							<span class="dash_card_status">
								<a href="#" onclick="fnExcel('${item.businessCode}','${item.demandName}')" ><i class="fa fa-save"></i></a>
							</span>
						</li>
                	</c:forEach>
               	</ul>
              </div>
            </div>
          </div>

		<div class="col-lg-8">
            <div class="card">
              <div class="card-header border-0">
				<div class="d-flex justify-content-between">
                	<h3 class="card-title">기술문의</h3>
                	<a href="/inquiry/list.ivs">...</a>
                </div>
              </div>
              <div class="card-body p-0">
              	<ul class="list-unstyled">
              		<c:forEach items="${inquiry }" var="item" varStatus="status">
                    	<li>
							<span class="dash_card_text2">- ${item.subject }</span>	
						</li>
                	</c:forEach>
                </ul>
              </div>
            </div>
          </div>

        </div>
        <!-- /.row -->
      </div>
      <!-- /.container-fluid -->
    </div>
    <!-- /.content -->
    <form id="frm" name="frm" action="" method="post">
		<input type="hidden" name="pageNo" value="${paginationInfo.currentPageNo }" />
		<input type="hidden" name="seq" id="seq" value="" />
		<input type="hidden" name="business_code" id="business_code" value="" />
		<input type="hidden" name="demand_name" id="demand_name" value="" />
		<!-- 스프링 시큐리티 form에 추가 해줘야함. -->
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	 </form>

<!-- OPTIONAL SCRIPTS -->
<!-- 
<script src="/plugins/chart.js/Chart.min.js"></script>
<script src="/dist/js/pages/dashboard3.js"></script>
-->
<script type="text/javascript">
$(function() {
	//엑셀다운로드 버튼
    $("#btnExcel").click(fnExcel);	
});

	function view(seq){
		document.getElementById("seq").value=seq;
		document.frm.action = "/contract/view.ivs";
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
</body>