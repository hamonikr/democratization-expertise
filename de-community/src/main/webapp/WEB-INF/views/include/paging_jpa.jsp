<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>

<div class="page-num">
	<div class="inner">
		<c:if test="${not paging.first}">
			<a href="list?pageNo=${paging.number}"><i class="mdi mdi-chevron-left"></i></a>
		</c:if> 
		<c:forEach begin="1" end="${paging.totalPages}" var="idx">
			<a href="list?pageNo=${idx}">${idx}</a>
		</c:forEach>
		 <c:if test="${not paging.last && paging.totalPages > 0}">
			<a href="list?pageNo=${paging.number + 2}"><i class="mdi mdi-chevron-right"></i></a>
		</c:if>
	</div>
</div>