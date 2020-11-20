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
	<h2>태그(Tags)</h2>
	<div class="section-info">
		태그는 질문을 유사한 다른 질문으로 분류하는 키워드 또는 레이블입니다. <br>
       	올바른 태그를 사용하면 다른 사람이 사용자의 질문을 쉽게 찾아 답변할 수 있습니다.
	</div>
	
<!-- 	<div class="list-left"> !!개발영역 -->
<!-- 		<div class="pagenum">현재페이지 1/10 (총 50건)</div> -->
<!--        	<ul class="sort-align"> -->
<!--        		<li><a href="#" class="current">인기순</a></li> -->
<!--          	<li><a href="#">이름순</a></li> -->
<!--          	<li><a href="#">새로운순</a></li> -->
<!-- 		</ul> -->
<!-- 	</div> -->
    
    <div class="list-right">
    	<div class="board-search inblock mR10 mT10">
    		<input type="text" name="" id="" placeholder="!!개발영역">
<!--     		<input type="text" name="" id="" placeholder="Search"> -->
    		<button type="button"><i class="mdi mdi-magnify"></i> </button>
		</div>
		<div class="inblock">
			<button type="button" class="btn-blue" id="btnSave" onclick="location.href='/tags/save'">Tag 생성</button>
		</div>
	</div>
	 
	
	<form id="frm" name="frm" method="post">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
		<input type="hidden" name="pageNo" value="${paginationInfo.currentPageNo }" />
		<input type="hidden" name="message" id ="message" value="${message}" />		
      <div class="con-box">
			<ul class="tag-con">
				<c:forEach var="list" items="${result}" varStatus="status">
					<li>
						<div class="tag-title">
							<%-- <em><a href="/wiki/view/${list.wikino}">${list.title}</a></em> --%>
							<em><a href="/tags/view/${list.wikino}">${list.title}</a></em>
		                   	<div class="qna"><font class="bold"><a href="/questions/list">${list.relatedcnt}</a> </font>개의 질문들</div>
						</div>
						${list.contents}
						<div class="space">space</div>
					</li>
					
				</c:forEach>
				
				
			</ul>
		</div>
	</form>
	<!-- page number -->
	<jsp:include page="/WEB-INF/views/include/paging.jsp" />
</div>
<script type="text/javascript">
$(function(){
    var responseMessage = $('#message').val();
    
    if(responseMessage != ""){
        alert(responseMessage)
    }
});

    
  </script>

