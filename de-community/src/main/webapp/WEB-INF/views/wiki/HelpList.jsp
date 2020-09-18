<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>

<head>
	<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
	<!-- Editor's Dependecy Style -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.48.4/codemirror.min.css"/>
	<!-- Editor's Style -->
	<link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />
</head>
<title>wiki 상세 뷰페이지</title>
</head>

<style>
.inputStyle{
	padding : 2%;
}

.edit_part{
display: block;
}
#right-navigation {
    float: right;
    margin-top: 2.5em;
}

</style>
<body>
  <div id="content" class="" role="main">
  		<div class="row">
 			<div class="col-md-10" data-placeholder="WikiPlaceholder-HelpCenterIntro">
				<p><br></p>
					<h2>시작하기</h2><br>
					<p>
					  DE 커뮤니티 시작하기!<br>
					  하모니카 커뮤니티에 오신것을 환영합니다. 하모니카 커뮤니티 이용에 관련된 정보를 제공합니다.
					</p>	
					<p><br>
						<a href="">※자주 묻는 질문들※ </a> <br>
					</p>

			 	<c:forEach var="list" items="${result}" varStatus="status">
					<ul>
					 	<li>
						  <svg aria-hidden="true" class="svg-icon iconTack" width="18" height="18" viewBox="0 0 18 18"><path d="M6.79 12.67l3.53 3.53a6 6 0 001.18-6.83l2.03-2.03A4 4 0 0018 5.5L12.53.03A4 4 0 0010.7 4.5L8.67 6.54a6 6 0 00-6.83 1.18l3.53 3.53-3.18 3.18-1.77 3.19 3.18-1.77 3.19-3.18z"></path></svg>     
						  <a href="/wiki/view/${list.wikino}">${list.title}</a>
						  </li>
					</ul>
				</c:forEach>		 

		<!-- 			<p><br>
						<a href="">※기타 질문들※ </a> <br>
					</p>
					<ul>
					  <li>
					  <a href="">기술지원은 무엇인가?</a></li>
					  <li>
					    <a href="">기술지원은 무엇인가?</a></li>					  	
					</ul>
		 -->			<div>
						<sec:authorize access="hasRole('ROLE_ADMIN')">
						   	<a href="/wiki/saveHelp">[작성하기]</a>
						</sec:authorize>
					</div>
				<hr>
			</div>
		</div>
	</div>
</body>
  

<!-- script 부분 -->

<script>

var editor = new toastui.Editor({
    el: document.querySelector('#editor'),
    initialEditType: 'wysiwyg',
    previewStyle: 'vertical',
    height: '500px';

});

</script>