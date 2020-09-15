<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>
					<ul class="pagination justify-content-left m-0 col-6">
						 <c:if test="${paginationInfo.currentPageNo ne paginationInfo.firstPageNo}">
							<li><a href="list?pageNo=${paginationInfo.currentPageNo - 1}">이전</a></li>
						</c:if> 
						<c:forEach begin="1" end="${paginationInfo.totalPageCount}" var="pageNo">
							<li><a href="list?pageNo=${pageNo}">${pageNo}</a></li>
						</c:forEach>
						 <c:if test="${(paginationInfo.currentPageNo ne paginationInfo.lastPageNo && paginationInfo.totalPageCount > 0)}">
							<li><a href="list?pageNo=${paginationInfo.currentPageNo + 1}">다음</a></li>
						</c:if>
					</ul>
