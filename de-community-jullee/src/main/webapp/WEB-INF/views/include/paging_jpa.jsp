<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>
					<ul class="pagination justify-content-left m-0 col-6">
						<c:if test="${not paging.first}">
							<li><a href="/sample/list?page=${paging.number}">이전</a></li>
						</c:if>
						<c:forEach begin="1" end="${paging.totalPages}" var="idx">
							<li><a href="/sample/list?page=${idx}">${idx}</a></li>
						</c:forEach>
						<c:if test="${not paging.last && paging.totalPages > 0}">
							<li><a href="/sample/list?page=${paging.number + 2}">다음</a></li>
						</c:if>
					</ul>
