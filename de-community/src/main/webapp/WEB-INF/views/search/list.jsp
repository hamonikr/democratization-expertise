<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>
<!-- tuideditor -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.48.4/codemirror.min.css" />
<link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />
<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
<script src="https://uicdn.toast.com/editor-plugin-color-syntax/latest/toastui-editor-plugin-color-syntax.js"></script>



<style>
/* .profile-info .graph2 {
    border: 1px solid #e3ebf4;
    border-radius: 3px;
    /* padding: 15px;
    /* width: 50%;
    height: 220px;
    margin-right: 20px;
} */
.nav-tabs .nav-link.active {
	font-weight: 500;
    background: #2d096a;
    color: #fff;
    border: 1px solid #2d096a;
    border-radius: 20px;
}

.nav-tabs .nav-link {
    border-radius: 20px;
}
.nav-tabs {
    border-bottom: 0;
}
</style>	

<div class="content-center">

	<h2>Stacked Q&amp;A</h2>

	<ul class="nav nav-tabs" id="custom-tabs-three-tab" role="tablist">
		<li class="nav-item">
			<a class="nav-link active" id="custom-tabs-three-home-tab" data-toggle="pill" href="#custom-tabs-three-home" role="tab" aria-controls="custom-tabs-three-home" aria-selected="true">질문&답변</a>
		</li>
		<li class="nav-item">
			<a class="nav-link" id="custom-tabs-three-profile-tab" data-toggle="pill" href="#custom-tabs-three-profile" role="tab" aria-controls="custom-tabs-three-profile" aria-selected="false">태그(Tags)</a>
		</li>
		<li class="nav-item">
		   	<a class="nav-link" id="custom-tabs-three-members-tab" data-toggle="pill" href="#custom-tabs-three-members" role="tab" aria-controls="custom-tabs-three-members" aria-selected="false">위키(Wiki)</a>
		</li>
	</ul>
	
	
          	
	<div class="tab-content" id="custom-tabs-three-tabContent">
              
    <!-- 읽기 tab -->
    	<div class="tab-pane fade show active con-box" id="custom-tabs-three-home" role="tabpanel" aria-labelledby="custom-tabs-three-home-tab">
			<div class="mytitle">Stack Q&A<span class="more"></span></div>
		    	<c:forEach var="list" items="${list}" varStatus="stat">
					<c:if test="${list.status eq 'Q' }">
		            <ul class="qna-list">
						<li class="question">
							<span class="ques-title"> <a href="/questions/view/${list.seq }">${list.title }</a></span>
							<div id="ques-text" >
							${fn:substring(list.contents, 0, 300)}<c:if test="${fn:length(list.contents) gt 301}"> ... </c:if>
							</div> 
							<script class="code-js">
								var editor = new toastui.Editor.factory( {
				                el : document.querySelector( '#ques-text' ),
				                initialEditType : 'wysiwyg',
				                previewStyle : 'vertical',
				                height : '400px',
				                width: '200px',
				                viewer : true
				                } );
							</script>
						</li>
					</ul>
					</c:if>
				</c:forEach>
		</div>
	
			      	
		<!--tag -->               
	    <div class="tab-pane fade con-box" id="custom-tabs-three-profile" role="tabpanel" aria-labelledby="custom-tabs-three-profile-tab">
	    	<div class="mytitle">Tags <span class="more"></span></div>
		    	<c:forEach var="list" items="${list}" varStatus="stat">
					<c:if test="${list.status eq 'T' }">
		            <ul class="qna-list">
						<li class="question">
							<span class="ques-title"> <a href="/wiki/view/${list.seq }/t">${list.title }</a></span>
							<div id="tags-text" >
							${fn:substring(list.contents, 0, 300)}<c:if test="${fn:length(list.contents) gt 301}"> ... </c:if>
							</div> 
							<script class="code-js">
								var editor = new toastui.Editor.factory( {
				                el : document.querySelector( '#tags-text' ),
				                initialEditType : 'wysiwyg',
				                previewStyle : 'vertical',
				                height : '400px',
				                width: '200px',
				                viewer : true
				                } );
							</script>
						</li>
					</ul>
					</c:if>
				</c:forEach>
				
		</div>

        <!-- 히스토리 tab -->
        <div class="tab-pane fade con-box" id="custom-tabs-three-members" role="tabpanel" aria-labelledby="custom-tabs-three-members-tab">
        	<div class="mytitle">Wikis <span class="more"></span></div>
		    	<c:forEach var="list" items="${list}" varStatus="stat">
					<c:if test="${list.status eq 'H' }">
		            <ul class="qna-list">
						<li class="question">
							<span class="ques-title"> <a href="/wiki/view/${list.seq }/w">${list.title }</a></span>
							<div id="wikis-text" >
							${fn:substring(list.contents, 0, 300)}<c:if test="${fn:length(list.contents) gt 301}"> ... </c:if>
							</div> 
							<script class="code-js">
								var editor = new toastui.Editor.factory( {
				                el : document.querySelector( '#wikis-text' ),
				                initialEditType : 'wysiwyg',
				                previewStyle : 'vertical',
				                height : '400px',
				                width: '200px',
				                viewer : true
				                } );
							</script>
						</li>
					</ul>
					</c:if>
				</c:forEach>
		</div>
	</div>
							
			
	
</div>
