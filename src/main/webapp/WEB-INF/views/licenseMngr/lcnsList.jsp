<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>
<body>
<form id="frm" name="frm" action="" method="post">
<input type="hidden" name="pageNo" value="${paginationInfo.currentPageNo }" />
<input type="hidden" name="seq" id="seq" value="" />
<!-- 스프링 시큐리티 form에 추가 해줘야함. -->
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
<section class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1>라이센스 관리</h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active">라이센스 관리</li>
            </ol>
          </div>
        </div>
      </div><!-- /.container-fluid -->
    </section>
    <section class="content">
      <div class="container-fluid">
<div class="row">
          <div class="col-12">
            <div class="card">
              <div class="card-header">
                <h3 class="card-title"></h3>
                <div class="card-tools">
                  <div class="input-group input-group-sm" style="width: 150px;">
                    <input type="text" name="table_search" class="form-control float-right" placeholder="Search">
                    <div class="input-group-append">
                      <button type="submit" class="btn btn-default"><i class="fas fa-search"></i></button>
                    </div>
                  </div>
                </div>
              </div>
              <p><strong>총 <span class="total"><c:out value="${paginationInfo.totalRecordCount}"/></span>건중, 현재페이지 <i class="min">${paginationInfo.currentPageNo}</i>/<i class="max">${paginationInfo.totalPageCount}</i></strong></p>
              <!-- /.card-header -->
              <div class="card-body table-responsive p-0">
                <table class="table table-hover text-nowrap">
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
						      <td>-</td>
						      <td>-</td>
						      <td><%-- <fmt:formatDate value="${list.reg_date}" pattern="yyyy-MM-dd" /> --%></td>
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
            </div>
            <!-- page number -->
                    <ui:pagination paginationInfo = "${paginationInfo}" type="text" jsFunction="linkPage"/>
            <!-- /.card -->
          </div>
        </div>
        <div class="card-footer">
                    <button type="button" onclick="location.href='save.ivs'" class="btn btn-primary"> 등록</button>
        </div>
      </div>
    </section>
	</form>
</body>

<script type="text/javascript">

	function linkPage(pageNo){
		location.href = "list.ivs?pageNo="+pageNo;
	}

	function view(seq){
		document.getElementById("seq").value=seq;
		document.frm.action = "view.ivs";
		document.frm.submit();
	}
		
</script>
	