<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>



<div class="content-center">
	<form id="frm" name="frm" method="post">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
<%-- 	<input type="hidden" name="boardno" value="${result.boardno}" /> --%>
		<h2>
		<c:if test="${gubun == 'm'}">
		How to AskOS
		</c:if>
		<c:if test="${gubun == 'h'}">
		자주하는 질문들...
		</c:if>
		<c:if test="${gubun == 'w'}">
		Wiki...
		</c:if>
		
		
		
		</h2>

		<div class="con-box">
			<div class="form-view">

				<!-- 질문내용 -->
				<div class="view-title">${result.title}</div>

				<ul class="qna-list">
					<li class="person">
						<img src="/img/noprofile.png">
						<span class="name"></span> 
						<span class="reputation"></span> 
						<span class="voting"></span>
					</li>
					<li class="question">
						<p>
							<fmt:formatDate value="${result.registerdate}" pattern="yyyy-MM-dd HH:mm" />
						</p> 
						<code>
							<p>${result.contents }</p>
						</code> 
					</li>
				</ul>



			</div>
		</div>

	</form>
	
	<div class="list-right">
		<button type="button" class="btn-blue" onclick="location.href='/wiki/Help/${gubun}'" >목록으로</button>
	</div>
	
</div>





