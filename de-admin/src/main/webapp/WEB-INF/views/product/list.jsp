<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>
<body>
<form id="frm" name="frm" action="" method="post">
<input type="hidden" name="pageNo" value="${paginationInfo.currentPageNo }" />
<input type="hidden" name="brd_id" id="brd_id" value="1001" />
<div class="row" id="content">
          <div class="col-12">
            <div class="card">
              <div class="card-header">
                <h3 class="card-title">SampleList</h3>
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
                <table class="table table-hover text-nowrap" id="example2">
                  <thead>
                    <tr>
                      <th>번호</th>
                      <th>제목</th>
                      <th>성명</th>
                      <th>등록일</th>
                      <th>조회수</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:forEach var="list" items="${list}" varStatus="status">
						    <tr>
						      <th scope="row">${paginationInfo.totalRecordCount - ((paginationInfo.currentPageNo-1) * paginationInfo.recordCountPerPage + status.index) }</th>
						      <td><a href="sampleView?seq=${list.seq }">${list.titl }</a></td>
						      <td>${list.user_nm}</td>
						      <td><fmt:formatDate value="${list.reg_date}" pattern="yyyy-MM-dd" /></td>
						      <td>-</td>
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
        <div class="right mT20">
                        <button type="button" class="btn_type2" id="btnSave" onclick="location.href='sampleSave'">등록</button>
                        <button type="button" class="btn_type2" id="btnSave" onclick="location.href='/sign/logout'">로그아웃</button>
                    </div>
	</form>
</body>

<script type="text/javascript">

	function linkPage(pageNo){
		location.href = "sampleList.do?pageNo="+pageNo;
	}
		
</script>
	