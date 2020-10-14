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
<body>
	<form id="frm" name="frm" method="post">
		<!-- 스프링 시큐리티 form에 추가 해줘야함. -->
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		<input type="hidden" name="wikino" id="wikino" value="${result.wikino}"/>					
		<div class="col-12">       
          	
            <div class="card-primary card-outline card-outline-tabs" style="border-top: 0px solid #007bff;">             
              <div class="card-header p-0 border-bottom-0">
              		<br>
              		<div align="right">
              			<a href="/wiki/getStart">[목록으로 되돌아가기]</a>
              		</div>
                  <ul class="nav nav-tabs" id="custom-tabs-three-tab" role="tablist">
                  <li class="nav-item">
                    <a class="nav-link active" id="" data-toggle="pill"
                     href="#custom-tabs-four-home" role="tab" aria-controls="custom-tabs-four-home"
                      aria-selected="true">읽기</a>
                  </li>
                  <c:if test="${empty history_view.title}">
                  <li class="nav-item">
                    <a class="nav-link" id="" data-toggle="pill"
                     href="#custom-tabs-four-profile" role="tab" aria-controls="custom-tabs-four-profile" 
                     aria-selected="false">편집</a>
                  </li>
             
                   <li class="nav-item">
                    <a class="nav-link" id="edit-tab" data-toggle="pill" 
                    href="#custom-tabs-four-messages" role="tab" aria-controls="custom-tabs-four-messages"
                     aria-selected="false">히스토리</a>
                  </li>
                  </c:if>     
                </ul>
              </div>
              <div class="card-body" style="width:auto;">
                <div class="tab-content" id="custom-tabs-four-tabContent">
                <c:choose>
                	<c:when test="${empty history_view.title}" >
                  <!-- 읽기 tab -->
                  <div class="tab-pane fade show active" id="custom-tabs-four-home" role="tabpanel" aria-labelledby="custom-tabs-four-home-tab">
						<div class="card-header">
							<h3 class="card-title"><span >${result.title}</span><br>
							</h3>
						</div>
					  <div class="form-group">
								<label for="contents" class="col-form-label"></label> <span>${result.contents}</span> 
						</div>
				     </div>
				     </c:when>
				     <c:otherwise>
				     <div class="tab-pane fade show active" id="custom-tabs-four-home" role="tabpanel" aria-labelledby="custom-tabs-four-home-tab">
						<div class="card-header">
							<h3 class="card-title"><span >${history_view.title}</span><br>
							</h3>
						</div>
					  <div class="form-group">
								<label for="contents" class="col-form-label"></label> <span>${history_view.contents}</span> 
						</div>
				     </div>	
				     </c:otherwise>
				     </c:choose>
			      	<!-- 편집 tab -->               
                  <div class="tab-pane fade" id="custom-tabs-four-profile" role="tabpanel" aria-labelledby="custom-tabs-four-profile-tab">
          				<div align="right">
          					<a class="" id="btnUpdate">[수정하기]</a>
          					<a class="" id="btnDelete">[삭제하기]</a>
          					
          				</div>
          				<div class="card-header">
						<c:choose>
						<c:when test="${result.section == 'h'}">
							<h4><input class="form-control" type="text" name="title" value="${result.title}"></h4>
						</c:when>
						<c:otherwise>
						<input type="hidden" name="title" value="${result.title}">
							<h3><span>${result.title}</span></h3>
						</c:otherwise>
						</c:choose>	
						</div>	
						<br>
          				<input type="hidden" name="contents" id="contents" value="">
							<div class="code-html">
								<div id="editSection">
									${result.contents}
								</div>
							</div>
							<script class="code-js">
			                      var editor = new toastui.Editor( {
			                      el : document.querySelector( '#editSection' ),
			                      initialEditType : 'wysiwyg',
			                      //	initialEditType: 'markdown',
			                      previewStyle : 'vertical',
			                      height : '700px'
			                      } );
		                  </script>	
                  	</div>

                 	<!-- 히스토리 tab -->
                  <div class="tab-pane fade" id="custom-tabs-four-messages" role="tabpanel" aria-labelledby="custom-tabs-four-messages-tab">
          			    <div class="card-header">
							<h3 class="card-title"><span class="">[${result.title}] 의 히스토리</span>
							</h3>
						</div>
						<div><br>
							<c:forEach var="list" items="${history}" varStatus="status">
								<ul>
									<li>
									  <a href="/wiki/edit/${list.seq}">${list.title} </a>
									  <fmt:formatDate value="${list.updatedate}" pattern="yyyy-MM-dd HH:mm:ss" />
									  ${list.username}
									</li>
								</ul>
							</c:forEach>
						</div>	
                  </div>
                </div>
              </div>
				</div>
							
			</div>
			
	</form>

<script type="text/javascript">

$(function() {
	$("#btnUpdate").on("click", fnUpdate);
	$("#btnDelete").on("click", fnDelete);
});

function fnUpdate() {
	document.frm.action = "/wiki/edit.proc";
	document.frm.contents.value = editor.getHtml();
	document.frm.submit();
}

function fnDelete() {
	document.frm.action = "/wiki/delete.proc";
	document.frm.submit();
}



</script>
</body>
</html>