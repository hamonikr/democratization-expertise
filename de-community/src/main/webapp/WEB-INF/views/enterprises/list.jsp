<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>


<div class="content-center">
	<h2>커뮤니티 참여기업</h2>
	
	<div class="section-info">
		커뮤니티에 활동하는 참여기업의 목록은 다음과 같습니다.
     </div>
     
     
	<form id="frm" name="frm" method="post" action="/enterprises/list">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> <input type="hidden" name="page" value="${paginationInfo.currentPageNo }" />


 

		<div class="list-left">
			<div class="pagenum">
				현재페이지 ${paging.number+1}/${paging.totalPages} (총 <c:out value="${paging.totalElements}" /> 건)
			</div>
<!-- 			<ul class="sort-align"> -->
<!-- 				<li><button type="submit" name="sort" class="sort" value="registerdate">신규등록</button></li> -->
<!-- 				<li><button type="submit" class="current" name="sort" class="sort" value="2">답변없는순</li> -->
<!-- 				<li><button type="submit" name="sort" class="sort" value="3">좋아요 많은 순</button></li> -->
<!-- 			</ul> -->
		</div>

		<div class="list-right">
			<div class="board-search inblock mR10 mT10">
				<input type="text" name="searchtext"  id="searchtext" value="${vo.searchtext }" placeholder="Search">
				<button type="button">
					<i class="mdi mdi-magnify"></i>
				</button>
			</div>
		</div>



		<div class="con-box">
			<ul class="company-user">
				<c:forEach var="list" items="${data}" varStatus="status">
				<li>
                  <a href="/enterprises/activity/${list.enterpriseno}">
	                  <c:if test="${list.enterpriseimg != null and list.enterpriseimg != ''}">
						<img src="/upload/enterprises/${list.enterpriseimg}">
					</c:if>
					<c:if test="${list.enterpriseimg == null and list.enterpriseimg == ''}">
						<img src="/img/noprofile.png">
					</c:if>
                  </a>
                  <span class="name"><a href="/enterprises/activity/${list.enterpriseno}">${list.enterprisename}</a></span>
<%--                   <span class="reputation">${list.enterpriseno }</span> --%>
                  <span class="tag">활동지역 : ${list.enterprisearea }</span>
                </li>
				</c:forEach>
			</ul>

			<!-- 게시물이 없을 경우 -->
			<c:if test="${empty data}">
				<div class="col-12">
					<p class="nodata">사용자 데이터가 없습니다.</p>
				</div>
			</c:if>
		</div>

		<!-- page number -->
		<jsp:include page="/WEB-INF/views/include/paging_jpa.jsp" />

	</form>
</div>

<script type="text/javascript">
function linkPage(pageNo){
	location.href = "enterprises/list?page="+pageNo;
}
</script>

