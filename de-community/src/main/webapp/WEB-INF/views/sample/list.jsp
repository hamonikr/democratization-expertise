<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>
<body>
<form id="frm" name="frm" action="" method="post">
<!-- 스프링 시큐리티 form에 추가 해줘야함. -->
<%-- <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/> --%>
<div class="row" id="content">
	<!-- <div class="col-12 nav_title">
		Home > 견적요청 리스트
	</div> -->
          <div class="col-12">
            <div class="card">
              <div class="card-header">
                <h3 class="card-title">sample List</h3>
                <div class="card-tools">
                  <div class="input-group input-group-sm" style="width: 150px;">
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
                <table class="table table-hover text-nowrap" id="example2">
                  <thead>
                    <tr>
                      <th>번호</th>
                      <th>제목</th>
                      <th>아이디</th>
                      <th>작성자</th>
                      <th>등록일</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:forEach var="list" items="${data}" varStatus="status">
						    <tr>
						      <td scope="row">${paging.totalElements - ((paging.number -1) * paging.size + status.index) }</td>
						      <td><a href="/sample/view/${list.seq}">${list.title }</a></td>
						      <td>${list.userId}</td>
						      <td>${list.userName}</td>
						      <td><fmt:formatDate value="${list.registerDate}" pattern="yyyy-MM-dd" /></td>
						      <td>
						      </td>
						    </tr>
						</c:forEach>
						<c:if test="${empty data}"> <!-- 게시물이 없을 경우 -->
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
					<%@ include file="/WEB-INF/views/include/paging.jsp" %>
				
				<div class="col-6 cont_btn_div tbl_list">
					<button type="button" onclick="location.href='save'" class="btn btn-primary purple">등록</button>
				</div>
              </div>
              
            </div>
            <!-- /.card -->
          </div>
          
        </div>
	</form>
</body>

<script type="text/javascript">

	function linkPage(pageNo){
		location.href = "list.ivs?pageNo="+pageNo;
	}
</script>