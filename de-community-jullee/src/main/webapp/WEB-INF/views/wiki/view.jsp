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
</style>
<body>
	<form id="frm" name="frm" method="post">
		<!-- 스프링 시큐리티 form에 추가 해줘야함. -->
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			<!-- Content Header (Page header) -->
				
					<div class="card-footer cont_btn_div">
						<a href="/wiki/edit/${result.wikino}" >[수정]</a>
						<a href="/wiki/Help">[목록]</a>
					</div>
				
					
		<div class="col-12">
            <div class="card-primary card-outline card-outline-tabs">             
              <div class="card-header p-0 border-bottom-0">
                <ul class="nav nav-tabs" id="custom-tabs-three-tab" role="tablist">
                  <li class="nav-item">
                    <a class="nav-link active" id="custom-tabs-three-tab-read" data-toggle="pill"
                     href="#custom-tabs-four-home" role="tab" aria-controls="custom-tabs-four-home"
                      aria-selected="true">읽기</a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link" id="custom-tabs-four-profile-tab" data-toggle="pill"
                     href="#custom-tabs-four-profile" role="tab" aria-controls="custom-tabs-four-profile" 
                     aria-selected="false">편집</a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link" id="custom-tabs-four-messages-tab" data-toggle="pill" 
                    href="#custom-tabs-four-messages" role="tab" aria-controls="custom-tabs-four-messages"
                     aria-selected="false">히스토리</a>
                  </li>
                  
                </ul>
              </div>
              <div class="card-body" style="width:auto;">
                <div class="tab-content" id="custom-tabs-four-tabContent">
                  <div class="tab-pane fade show active" id="custom-tabs-four-home" role="tabpanel" aria-labelledby="custom-tabs-four-home-tab">
						<div class="card-header">
							<h3 class="card-title"><span class="">${result.title}</span>
							</h3>
						</div>
					  <div class="form-group">
								<label for="contents" class="col-form-label"></label> <span class="form-control contents">${result.contents}</span>
						</div>

				     </div>
                                   
                  <div class="tab-pane fade" id="custom-tabs-four-profile" role="tabpanel" aria-labelledby="custom-tabs-four-profile-tab">
          				<input type="hidden" name="contents" id="contents" value="">
							<div class="code-html">
								<div id="editSection">${result.contents}</div>
							</div>
							<script class="code-js">
			                      var editor = new tui.Editor( {
			                      el : document.querySelector( '#editSection' ),
			                      initialEditType : 'wysiwyg',
			                      //	initialEditType: 'markdown',
			                      previewStyle : 'vertical',
			                      height : '400px'
			                      } );
		                  </script>	
                  	</div>
                  <div class="tab-pane fade" id="custom-tabs-four-messages" role="tabpanel" aria-labelledby="custom-tabs-four-messages-tab">
          					
          				aaa
                  </div>
                </div>
              </div>
				</div>
			</div>
			
	</form>

	<script type="text/javascript">

	    
		$(function() {
			//승인 버튼
			$("#btnConsent").on("click", fnSave);
			$("#btnUpdate").on("click", fnUpdate);
			
		});

		function fnUpdate() {
			document.frm.action = "save.proc";
			document.frm.submit();
		}
	</script>
</body>
</html>