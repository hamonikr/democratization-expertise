<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>
<body>
<form id="frm" name="frm" action="" method="post">
<input type="hidden" name="pageNo" value="${paginationInfo.currentPageNo }" />
<input type="hidden" name="seq" id="seq" value="" />
<!-- 스프링 시큐리티 form에 추가 해줘야함. -->
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
<div class="row" id="content">
	<div id="input_div" class="col-12 " style="margin-top: .75rem;">
		<div class="callout callout-info row ">
			<div class="col-6">
				<h5>공지사항</h5>
			</div>
			<div class="col-6">
				<span class="float-right  "><a href="/main/index">Home</a> / 공지사항</span>
			</div>
		</div>
	</div>
	
	<section class="col-12 content-header" style="padding: 2px .5rem; margin-top: 34px;">
		<div class="container-fluid">
			<div class="row mb-2">
				<div class="col-sm-4">
					<h5>공지사항</h5>
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
		</div>
	</section>


          <div class="col-12">
            <div class="card">
              <%-- <p><strong>총 <span class="total"><c:out value="${paginationInfo.totalRecordCount}"/></span>건중, 현재페이지 <i class="min">${paginationInfo.currentPageNo}</i>/<i class="max">${paginationInfo.totalPageCount}</i></strong></p> --%>
              <!-- /.card-header -->
              <div class="card-body table-responsive p-0">
                <table class="table table-hover text-nowrap" id="example2">
                  <thead>
                    <tr>
                      <th>번호</th>
                      <th>제목</th>
                      <th>작성자</th>
                      <th>등록일</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:forEach var="list" items="${list}" varStatus="status">
						    <tr>
						      <td scope="row">${paginationInfo.totalRecordCount - ((paginationInfo.currentPageNo-1) * paginationInfo.recordCountPerPage + status.index) }</td>
						      <td><a href="#" onclick="view('${list.seq }')">${list.title }</a></td>
						      <td>${list.user_id}</td>
						      <td><fmt:formatDate value="${list.reg_date}" pattern="yyyy-MM-dd" /></td>		     
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
				<!-- <div class="col-6 cont_btn_div tbl_list">
					<button type="button" onclick="location.href='save.ivs'" class="btn btn-primary purple">등록</button>
				</div> -->
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

	function view(seq){
		document.getElementById("seq").value=seq;
		document.frm.action = "view.ivs";
		document.frm.submit();
	}
</script>