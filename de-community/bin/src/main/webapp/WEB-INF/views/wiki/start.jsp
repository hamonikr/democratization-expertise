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
/* height: 200px; 
width: 300px; 
text-align: left; 
 */
overflow: hidden; 
text-overflow: ellipsis; 
word-wrap: break-word; 
display: -webkit-box;
-webkit-line-clamp: 10;
-webkit-box-orient: vertical;

line-height: 1.2; 
height: 3.6em; 

}
</style>
 <body >


<section class="content-header">
	<div class="container-fluid">
		<div class="row mb-2">
			<div class="col-sm-6">
				<h1></h1>
			</div>
		</div>
	</div>
	<!-- /.container-fluid -->
</section>

	
<section class="content" style="padding: 2px 12px 6px 19px;">

	<div class="container-fluid">

		<div class="row">

			<div class="col-12">
				<div class="callout callout-info">
					<h5>Wiki</h5>


					<div class="card-header" style="border-bottom: 0px;">
						<div class="card-tools float-left col-10">
							<div class="input-group input-group ">하모니카 커뮤니티에 오신것을 환영합니다. 하모니카 커뮤니티 이용에 관련된 정보를 제공합니다.</div>
						</div>
<!-- 						<div class="col-2 float-right"> -->
<!-- 							<button type="button" class="btn btn-outline-primary float-right" id="btnSave" onclick="location.href='/wiki/saveTag'">+ Tag 생성</button> -->
<!-- 						</div> -->
					</div>
				</div>

				<div class="invoice p-3 mb-3" style="border-left: 5px solid #117a8b;">
					<div class="row">
						<div class="col-md-6">
							<div class="card card-outline card-primary col-12">
								<div class="card-header col-12">
									<h5>※자주 묻는 질문들※<span class="float-right" style="font-size: 17px;"><a href="/wiki/Help/h">[더보기]</a></span></h5>
<!-- 									<div class="card-tools"> -->
<!-- 									 	<p style="font-size:9px;"></p> -->
<!-- 									 </div> -->
								</div>
								<div class="card-body col-12 ellipsis" style="height: 208px;">
		 							<c:forEach var="list" items="${result}" varStatus="status">
										<ul>
					 						<li><a href="/wiki/view/${list.wikino}">${list.title}</a></li>
					 					</ul>
									</c:forEach>
								</div>
							</div>
						</div>
						
						<div class="col-md-6">
							<div class="card card-outline card-primary col-12">
								<div class="card-header col-12">
<!-- 									<h3 class="card-title">※자주 묻는 질문들※</h3> -->
									<h5>※How to DE-Community...※<span class="float-right" style="font-size: 17px;"><a href="/wiki/Help/m">[더보기]</a></span></h5>
								</div>
								<div class="card-body col-12 ellipsis" style="height: 208px;">
		 							<c:forEach var="list" items="${menual_result}" varStatus="status">
										<ul>
					 						<li><a href="/wiki/view/${list.wikino}">${list.title}</a></li>
					 					</ul>
									</c:forEach>
								</div>
							</div>
						</div>
						
					</div>
				</div>
			</div>
		</div>

	<div class="row">

					<div class="col-12">
						<div class="callout callout-info">
							<h5>Tags</h5>


							<div class="card-header" style="border-bottom: 0px;">
								<div class="card-tools float-left col-10">
									<div class="input-group input-group ">활동적인 유저의 공헌 목록은 다음과 같습니다.<br> 커뮤니티에 지식을 제공하여 더 많은 사람들이 성장할 수 있도록 합니다.</div>
								</div>
								<div class="col-2 float-right">
									<button type="button" class="btn btn-outline-primary float-right" id="btnSave" onclick="location.href='/wiki/saveTag'">+ Tag 생성</button>
								</div>
							</div>
						</div>

						<div class="invoice p-3 mb-3" style="border-left: 5px solid #117a8b;">
							<div class="row">
				 		
				 			<c:forEach var="list" items="${tagsResult}" varStatus="status">
								<div class="col-md-3">
									<div class="card card-outline card-primary col-12">
										<div class="card-header col-12">
											<h3 class="card-title">
												<a href="/wiki/view/${list.wikino}">${list.title}</a>
											</h3>
											
											<div class="card-tools">
											 	<p style="font-size:9px;"><a href="/questions/list">${list.relatedcnt}</a> 개의 질문들</p>
											 </div>
										</div>
										<div class="card-body col-12 ellipsis" style="height: 116px;">${list.contents}</div>
									</div>
								</div>
							</c:forEach>
							
							</div>
						</div>
					</div>
				</div>
				
				
	</div>
	
	
	

			
</section>


<%--   <!-- start of contents  -->   
    <div id="content" class="" role="main">
 	
 		<div class="row" data-placeholder="WikiPlaceholder-HelpCenterIntro">
 		<div class="col">		
 			<p><br></p>
					<h2>Tags</h2>	
			<p><br></p>
		</div>
		</div>
		<div class="row">
			<div class="col-md-3">
			<hr>
				<c:forEach var="list" items="${tags}" varStatus="status">
					<ul>
					 	<li>
						  <svg aria-hidden="true" class="svg-icon iconTack" width="18" height="18" viewBox="0 0 18 18">
						  <path d="M6.79 12.67l3.53 3.53a6 6 0 001.18-6.83l2.03-2.03A4 4 0 0018 5.5L12.53.03A4 4 0 0010.7 4.5L8.67 6.54a6 6 0 00-6.83 1.18l3.53 3.53-3.18 3.18-1.77 3.19 3.18-1.77 3.19-3.18z"></path></svg>     
						  <a href="/wiki/view/${list.wikino}">${list.title}</a>
						  </li>
					</ul>
				</c:forEach>		 
			  
			</div>

 		 <div>    
     </div>
 	</div>
    	<a href="/wiki/saveTag">[Tag 작성하기]</a>
  </div>   --%>

</body>



</html>