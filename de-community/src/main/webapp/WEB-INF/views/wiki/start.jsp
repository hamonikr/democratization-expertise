<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>
<link rel="stylesheet" href="/dist/css/adminlte.min.css">

<!-- tui editor-->
<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
<!-- Editor's Dependecy Style -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.48.4/codemirror.min.css"/>
<!-- Editor's Style -->
<link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />

<style>
.ellipsis {
overflow: hidden; 
text-overflow: ellipsis; 
word-wrap: break-word; 
display: -webkit-box;
-webkit-line-clamp: 8;
-webkit-box-orient: vertical;

line-height: 1.2; 
height: 3.6em; 
font-size: small;

}

.ellipsis_in{
width: 500px; 
white-space: nowrap;
overflow: hidden;
text-overflow: ellipsis;
text-transform: uppercase;
font-size: medium;
}
</style>



<div class="content-center">
	<h2>DE-위키</h2>
	<div class="section-info">
      활동적인 유저의 공헌 목록은 다음과 같습니다.<br> 커뮤니티에 지식을 제공하여 더 많은 사람들이 성장할 수 있도록 합니다.
    </div>
     
    <div class="list-right">
    	<div class="inblock">
        	<button type="button" class="btn-blue"  id="btnSave" onclick="location.href='/wiki/saveTag'"> Tag 작성하기</button>
		</div>
	</div>
    
    
	<div class="con-box">
		<div class="mywrit" style="height: 220px;">
        	<div class="mytitle">
            	자주하는 질문들<span class="more"><a href="/wiki/Help/h">+더보기</a></span>
			</div>
            <ul>
            	<c:forEach var="list" items="${result}" varStatus="status">
		 			<li><a href="/wiki/view/${list.wikino}">${list.title}</a></li>
				</c:forEach>
			</ul>
		</div>
			
		<div class="mywrit other" style="height: 220px;">
        	<div class="mytitle">
            	How to DE-Community<span class="more"><a href="/wiki/Help/m">+더보기</a></span>
			</div>
            <ul>
            	<c:forEach var="list" items="${menual_result}" varStatus="status">
		 			<li><a href="/wiki/view/${list.wikino}">${list.title}</a></li>
				</c:forEach>
			</ul>
		</div>
                
		<!-- <div class="mywrit">
        	<div class="mytitle">
            	평판 &amp; 관리자<span class="more"><a href="#">+더보기</a></span>
			</div>
			<ul>
				<li><a href="#">제목이 나옵니다. 제목이 나옵니다.</a></li>
			</ul>
		</div>
		
		<div class="mywrit other">
			<div class="mytitle">
				계정<span class="more"><a href="#">+더보기</a></span>
			</div>
            <ul>
            	<li><a href="#">제목이 나옵니다. 제목이 나옵니다.</a></li>
			</ul>
		</div> -->
	
		<!--     <div class="list-right"> -->
<!--     	<div class="inblock"> -->
<!--         	<button type="button" class="btn-blue">작성하기</button> -->
<!-- 		</div> -->
<!-- 	</div> -->


		<ul class="tag-con mT40">
		    
			<c:forEach var="list" items="${tagsResult}" varStatus="status">
			<li>
		    	<div class="tag-title">
					<em><a href="/wiki/view/${list.wikino}">${list.title}</a></em>
					<div class="qna">
						<font class="bold"><a href="/questions/list">${list.relatedcnt}</a></font>개의 질문들
					</div>
				</div>
				${list.contents}
				<div class="space">space</div>
			</li>
			
	<!-- 						<div class="card-body col-12 ellipsis" style="height: 100px;"> -->
	<!-- 						</div> -->
				</c:forEach>
				
				
	    </ul>
	</div>
               
</div>





	

						
						


	
	

			


