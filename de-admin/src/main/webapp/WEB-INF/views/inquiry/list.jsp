<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>
<body>
	<form id="frm" name="frm" action="" method="post">
		<input type="hidden" name="pageNo" value="${paginationInfo.currentPageNo }" /> <input type="hidden" name="seq" id="seq" value="" />
		<!-- 스프링 시큐리티 form에 추가 해줘야함. -->
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

		<div class="row" id="content">

			<div id="input_div" class="col-12 " style="margin-top: .75rem;">
				<div class="callout callout-info row ">
					<div class="col-6">
						<h5>기술문의</h5>
					</div>
					<div class="col-6">
						<span class="float-right  "><a href="/main/index">Home</a> / 기술문의</span>
					</div>
				</div>
			</div>

			
			<div class="col-12">
				<div class="card">
					
					<div class="row mb-2">
						<div class="col-sm-4">
							<h5>기술문의</h5>
						</div>
						<div class="col-sm-8">
							<div class="input-group input-group-sm float-right" style="width: 150px;">
								<input type="text" name="table_search" class="form-control float-right" placeholder="Search">
								<div class="input-group-append">
									<button type="submit" class="btn btn-default">
										<i class="fas fa-search"></i>
									</button>
								</div>
							</div>
						</div> 
					</div>

					<!-- /.card-header -->
					<div class="card-body table-responsive p-0">
						<table class="table table-hover text-nowrap" id="example2">
							<colgroup>
								<col width="5%"/>
								<col width="30%"/>
								<col width="30%"/>
								<col width="10%"/>
								<col width="10%"/>
								<col width="10%"/>
								<col width="5%"/>
							</colgroup>
							<thead>
								<tr>
									<th>번호</th>
									<th>제목</th>
									<th>내용</th>
									<th>수요자</th>
									<th>작성자</th>
									<th>등록일</th>
									<th>처리상태</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="list" items="${list}" varStatus="status">
									<tr>
										<th scope="row">	<a href="#" onclick="view('${list.seq}')">${paginationInfo.totalRecordCount - ((paginationInfo.currentPageNo-1) * paginationInfo.recordCountPerPage + status.index) }</a></th>
										<td>
											<a href="#" onclick="view('${list.seq}')">${list.subject}</a>
										</td>
										<td>${list.contents}</td>
										<td>${list.demand_name}</td>
										<td>${list.ts_user}</td>
										<td>
											<fmt:formatDate value="${list.reg_date}" pattern="yyyy-MM-dd" />
										</td>
										<td>
											<%--    ${list.proc_stat} --%>
											<c:if test="${list.proc_stat eq 0}">
         							접수
         						</c:if>
											<c:if test="${list.proc_stat eq 1}">
         							처리중
         						</c:if>
											<c:if test="${list.proc_stat eq 3}">
         							본사요청
         						</c:if>
											<c:if test="${list.proc_stat eq 2}">
         							완료
         						</c:if>
										</td>
									</tr>
								</c:forEach>
								<c:if test="${empty list}">
									<!-- 게시물이 없을 경우 -->
									<tr>
										<td colspan="5">
											<p class="nodata">결과가 없습니다.</p>
										</td>
									</tr>
								</c:if>
							</tbody>
						</table>
					</div>
					<!-- /.card-body -->
					
					<div class="card-footer row">
						<!-- page number -->
						<ul class="pagination justify-content-left m-0 col-6">
							<ui:pagination paginationInfo="${paginationInfo}" type="text" jsFunction="linkPage" />
						</ul>
					</div>
				</div>

				<!-- /.card -->
			</div>
		</div>
	</form>
</body>

<script type="text/javascript">
  function linkPage(pageNo) {
    location.href = "list.ivs?pageNo=" + pageNo;
  }

  function view(seq) {
    document.getElementById("seq").value = seq;
    document.frm.action = "view.ivs";
    document.frm.submit();
  }
</script>
