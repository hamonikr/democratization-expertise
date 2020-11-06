<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>


<div class="content-center">

	<form id="frm" name="frm" method="post">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> <input type="hidden" name="page" value="${paginationInfo.currentPageNo }" />

		<h2>Stacked Q&amp;A</h2>
		<div class="section-info">
			각 메뉴 섹션 상단에 카피문구 넣어주세요. 2~3줄 나올수 있으면 예뻐요.<br> 문구가 나옵니다. 개발시 당신이 겪는 어려움에 대해 자유롭게 질문을 하고 답변을 받으세요. 그리고 그 지식을 커뮤니티의 회원들과 함께 공유해주세요. 모바일버전에서는 display:none.<br>
		</div>



		<div class="list-left">
			<div class="pagenum">
				현재페이지 ${paging.number+1}/${paging.totalPages} (총 <c:out value="${paging.totalElements}" /> 건)
			</div>
			<ul class="sort-align">
				<li><button type="submit" name="sort" class="sort" value="1">신규등록</button></li>
				<li><button type="submit" class="current" name="sort" class="sort" value="2">답변없는순</li>
				<li><button type="submit" name="sort" class="sort" value="3">좋아요 많은 순</button></li>
			</ul>
		</div>

		<div class="list-right">
			<div class="board-search inblock mR10 mT10">
				<input type="text" name="searchtext" value="${vo.searchtext }" placeholder="Search">
				<button type="button">
					<i class="mdi mdi-magnify"></i>
				</button>
			</div>
			<div class="inblock">
				<button type="button" class="btn-blue" id="btnSave" onclick="location.href='save'">질문하기</button>
			</div>
		</div>



		<div class="con-box">
			<ul class="qna-list">
				<c:forEach var="list" items="${data}" varStatus="status">
					<li class="person">
							<c:if test="${list.enterpriseimg != null}">
								<img src="/upload/enterprises/${list.enterpriseimg}">
							</c:if>
							<c:if test="${list.enterpriseimg == null}">
								<img src="/img/noprofile.png">
							</c:if>
					</li>
					<li class="question" style="width: 200px;"><span class="ques-title"><a href='/enterprises/activity/${list.enterpriseno}'>${list.enterprisename}</a></span>
						<p>${list.enterpriseno }</p></li>
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

