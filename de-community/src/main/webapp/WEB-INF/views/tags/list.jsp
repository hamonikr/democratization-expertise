<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>

<!-- tui editor-->
<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.48.4/codemirror.min.css"/>
<link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />

<style>

.ellipsis {
display: -webkit-box;
width: 300px; 
height: 208px;

-webkit-line-clamp: 10;
-webkit-box-orient: vertical;
overflow: hidden; 
text-overflow: ellipsis; 

word-wrap: break-word; 
line-height: 1.2; 

pointer-events: none;
cursor: default;
text-decoration:none ;
font-size: small;
color: rgb(0,0,0);
}

</style>
<div class="content-center">
	<form id="frm" name="frm" method="post">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> <input type="hidden" name="pageNo" value="${paginationInfo.currentPageNo }" />

		<c:forEach var="list" items="${result}" varStatus="status">
			<div class="">
				<div >
					<h3 >
						<a href="/wiki/view/${list.wikino}">${list.title}</a>
					</h3>

					<div >
						<p style="font-size: 9px">
							<a href="/questions/list">${list.relatedcnt}</a> 개의 질문들
						</p>
					</div>
					<div class="card-body col-12 ellipsis">
						<div>${list.contents}</div>
					</div>
				</div>
			</div>
		</c:forEach>


	</form>
</div>




