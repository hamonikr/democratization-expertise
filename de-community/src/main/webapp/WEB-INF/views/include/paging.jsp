<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>

<div class="page-num">
	<div class="inner">
		<c:if test="${paginationInfo.currentPageNo ne paginationInfo.firstPageNo}">
			<a href="list?pageNo=${paginationInfo.currentPageNo - 1}&sort=${vo.sort}&searchtext=${vo.searchtext}"><i class="mdi mdi-chevron-left"></i></a>
		</c:if> 
		<c:forEach begin="${paginationInfo.firstPageNoOnPageList}" end="${paginationInfo.lastPageNoOnPageList}" var="pageNo">
			<a href="list?pageNo=${pageNo}&sort=${vo.sort}&searchtext=${vo.searchtext}">${pageNo}</a>
		</c:forEach>
		 <c:if test="${(paginationInfo.currentPageNo ne paginationInfo.lastPageNo && paginationInfo.totalPageCount > 0)}">
			<a href="list?pageNo=${paginationInfo.currentPageNo + 1}&sort=${vo.sort}&searchtext=${vo.searchtext}"><i class="mdi mdi-chevron-right"></i></a>
		</c:if>
	</div>
</div>