<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>

<!-- tui editor-->
<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
<!-- Editor's Dependecy Style -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.48.4/codemirror.min.css"/>
<!-- Editor's Style -->
<link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />
<style>
.tab-body{
	background-color: #fff;
}

button {
  background:none;
  border:0;
  outline:0;
  cursor:pointer;
}
.tab_menu_container {
  display:flex;
}
.tab_menu_btn {
  width:80px;
  height:40px;
  transition:0.3s all;
}
.tab_menu_btn.on {
  border-top:2px solid #007bff;
  font-weight:700;
  color:#007bff;
}
.tab_menu_btn:hover {
  color:#007bff;
}
.tab_box {
  display:none;
  padding:20px;
}
.tab_box.on {
  display:block;
}
</style>

<div class="content-center">

	<h2>Stacked Q&amp;A</h2>
	<div class="section-info">
		각 메뉴 섹션 상단에 카피문구 넣어주세요. 2~3줄 나올수 있으면 예뻐요.<br> 문구가 나옵니다. 개발시 당신이 겪는 어려움에 대해 자유롭게 질문을 하고 답변을 받으세요. 그리고 그 지식을 커뮤니티의 회원들과 함께 공유해주세요. 모바일버전에서는 display:none.<br>
	</div>


</div>	
	<section class="content" style="padding: 2px 12px 6px 19px;">
	<form id="frm" name="frm" method="post">
		<!-- 스프링 시큐리티 form에 추가 해줘야함. -->
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>				
		<div class="col-12">       
          	
            <div class="card-primary card-outline card-outline-tabs" style="border-top: 0px solid #007bff;">             
              <div class="card-header p-0 border-bottom-0">
                  <ul class="nav nav-tabs" id="custom-tabs-three-tab" role="tablist">
                  <li class="nav-item">
                    <a class="nav-link active" id="question" data-toggle="pill"
                     href="#custom-tabs-four-home" role="tab" aria-controls="custom-tabs-four-home"
                      aria-selected="true">질문</a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link" id="tag" data-toggle="pill"
                     href="#custom-tabs-four-profile" role="tab" aria-controls="custom-tabs-four-profile" 
                     aria-selected="false">태그</a>
                  </li>
             
                   <li class="nav-item">
                    <a class="nav-link" id="wiki" data-toggle="pill" 
                    href="#custom-tabs-four-messages" role="tab" aria-controls="custom-tabs-four-messages"
                     aria-selected="false">위키</a>
                  </li>   
                </ul>
              </div>
              <div class="card-body" style="width:auto;">
                <div class="tab-content" id="custom-tabs-four-tabContent">
                  <!-- 읽기 tab -->
                  <div class="tab-pane fade show active" id="custom-tabs-four-home" role="tabpanel" aria-labelledby="custom-tabs-four-home-tab">
						<c:forEach var="list" items="${list}" varStatus="stat">
						<c:if test="${list.status eq 'Q' }">
										<div class="info-box">

											<div class="row col-11">
												<div class="col-9">
													<div class="info-box-content">
														<span class="info-box-text"><a href="/questions/view/${list.seq }">${list.title }</a></span>
<%-- 														<span class="info-box-number"> ${fn:substring(list.contents, 0, 50)} --%>
<%-- 														<c:if test="${fn:length(list.contents) > 49}"> ... </c:if> --%>
<!-- 														</span>  -->
													</div>
												</div>
											</div>
										</div>
										</c:if>
									</c:forEach>
				     </div>
			      	
			      	<!-- 편집 tab -->               
                  <div class="tab-pane fade" id="custom-tabs-four-profile" role="tabpanel" aria-labelledby="custom-tabs-four-profile-tab">
          				<c:forEach var="list" items="${list}" varStatus="stat">
          				<c:if test="${list.status eq 'T' }">
										<div class="info-box">
											<div class="row col-11">
												<div class="col-9">
													<div class="info-box-content">
														<span class="info-box-text"><a href="/wiki/view/${list.seq }">${list.title }</a></span>
														<span class="info-box-number"> ${fn:substring(list.contents, 0, 50)}
														<c:if test="${fn:length(list.contents) > 49}"> ... </c:if>
														</span> 
													</div>
												</div>
											</div>
										</div>
										</c:if>
									</c:forEach>
                  	</div>

                 	<!-- 히스토리 tab -->
                  <div class="tab-pane fade" id="custom-tabs-four-messages" role="tabpanel" aria-labelledby="custom-tabs-four-messages-tab">
          			    <c:forEach var="list" items="${list}" varStatus="stat">
          			    <c:if test="${list.status eq 'H' }">
										<div class="info-box">

											<div class="row col-11">
												<div class="col-9">
													<div class="info-box-content">
														<span class="info-box-text"><a href="/wiki/view/${list.seq }">${list.title }</a></span>
														<span class="info-box-number"> ${fn:substring(list.contents, 0, 50)}
														<c:if test="${fn:length(list.contents) > 49}"> ... </c:if>
														</span> 
													</div>
												</div>
											</div>
										</div>
										</c:if>
									</c:forEach>
                  </div>
                </div>
              </div>
				</div>
							
			</div>
			
	</form>
