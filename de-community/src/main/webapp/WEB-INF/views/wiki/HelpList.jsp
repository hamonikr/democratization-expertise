<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>

<div class="content-center">
	<h2>
		<c:if test="${gubun eq 'h'}">
			자주하는 질문들...
		</c:if>
		<c:if test="${gubun == 'm'}">
			How to AskOS...
		</c:if>
		<c:if test="${gubun == 'w'}">
			Wiki List...
		</c:if>
	</h2>
	
	<div class="list-right">
		<button type="button" class="btn-blue" onclick="location.href='/wiki/getStart'" >목록으로</button>
       	<button type="button" class="btn-blue" onclick="location.href='/wiki/saveHelp/${gubun}'">(관리자권한일경우에만)작성하기</button>
	</div>
	
	<div class="con-box">
		<ul class="wiki-list">
        <c:forEach var="list" items="${result}" varStatus="status">
			<li>
				<a href="/wiki/helpview/${list.wikino}/${gubun}">
					${fn:substring(list.title, 0, 90)}<c:if test="${fn:length(list.title) gt 91}"> ... </c:if>
				</a>
			</li>
		</c:forEach>
		</ul>
	</div>
	
    <jsp:include page="/WEB-INF/views/include/paging.jsp" />
    
</div>


		
