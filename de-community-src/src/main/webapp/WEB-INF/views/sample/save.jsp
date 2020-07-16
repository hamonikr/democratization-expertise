<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>

<script src="/tui-editor/jquery/dist/jquery.js"></script>
<script src='/tui-editor/markdown-it/dist/markdown-it.js'></script>
<script src="/tui-editor/to-mark/dist/to-mark.js"></script>
<script src="/tui-editor/tui-code-snippet/dist/tui-code-snippet.js"></script>
<script src="/tui-editor/codemirror/lib/codemirror.js"></script>
<script src="/tui-editor/highlightjs/highlight.pack.js"></script>
<script src="/tui-editor/squire-rte/build/squire-raw.js"></script>
<script src="/tui-editor/tui-editor/dist/tui-editor-Editor.js"></script>
<link rel="stylesheet" href="/tui-editor/tui-editor/dist/tui-editor.css">
<link rel="stylesheet"
	href="/tui-editor/tui-editor/dist/tui-editor-contents.css">
<link rel="stylesheet" href="/tui-editor/codemirror/lib/codemirror.css">
<link rel="stylesheet" href="/tui-editor/highlightjs/styles/github.css">

<!-- jquery-validation -->
<script src="/plugins/jquery-validation/jquery.validate.min.js"></script>
<script src="/plugins/jquery-validation/additional-methods.min.js"></script>

<body>

	<form id="frm" name="frm" method="post">
		<!-- 스프링 시큐리티 form에 추가 해줘야함. -->
		<%-- <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/> --%>
		<input type="hidden" name="userId" value="testID" /> 
		<input type="hidden" name="userName" value="testName" />
		<input type="hidden" name="seq" value="${result.seq }" />
		<div class="row">
			<!-- general form elements -->
			<div class="col-12">
				<div class="card card-primary">
					<div class="card-header">
						<h3 class="card-title">sample save</h3>
					</div>
					<!-- /.card-header -->
					<div class="card-body card-primary card-outline">
						<div class="form-group">
							<label for="subject">Title <span class="important">*</span></label>
							<input type="text" class="form-control" id="title" name="title"
								placeholder="제목을 입력해주세요." value="${result.title}" />
						</div>
						<div class="form-group">
							<label for="contents">body<span class="important">*</span></label>
							<input type="hidden" name="contents" id="contents" value="">
							<div class="code-html">
								<div id="editSection">${result.contents }</div>
							</div>
							<script class="code-js">
								var editor = new tui.Editor(
										{
											el : document
													.querySelector('#editSection'),
											initialEditType : 'wysiwyg',
											//			                    initialEditType: 'markdown',
											previewStyle : 'vertical',
											height : '400px'
										});
							</script>
						</div>
						<div class="form-group">
							<label for="Tag">Tag</label>
							<%-- <input type="text" name="tag" id="tag" class="form-control" placeholder="ex)" value="${result.tag}"/> --%>
						</div>
					</div>

					<div class="card-footer cont_btn_div">
						<c:choose>
							<c:when test="${empty result.userId}">
								<button type="submit" name="btnSubmit"
									class="btn btn-primary purple" value="c">등록</button>
							</c:when>
							<c:otherwise>
								<button type="submit" name="btnSubmit"
									class="btn btn-primary purple" value="u">수정</button>
								<button type="button" id="btnDelete" class="btn btn-primary red">
									삭제</button>
							</c:otherwise>
						</c:choose>
						<button type="button" class="btn btn-primary gray"
							onclick="location.href='/sample/list'">목록</button>
					</div>
				</div>
			</div>
		</div>
	</form>
	<script type="text/javascript">
		$(function() {
			//저장 버튼
			//$("#btnSave").on("click",fnSave);	
			//$("#btnUpdate").on("click",fnUpdate);
			$("#btnDelete").on("click", fnDelete);

			$.validator.setDefaults({
				submitHandler : function() {
					var vv = $("input[name=btnSubmit]").val();
					document.frm.contents.value = editor.getHtml();
					if (vv == "c")
						document.frm.action = "/sample/save.proc";
					else if (vv == "u")
						document.frm.action = "/sample/save.proc";
					document.frm.submit();
				}
			});
			$('#frm').validate({
				rules : {
					title : {
						required : true
					},
					tag : {
						required : true
					},
					contents : {
						required : true
					}
				},
				messages : {
					title : {
						required : "제목을 입력 해주세요."
					},
					tag : {
						required : "가격을 입력 해주세요.",
						number : "숫자만 입력 가능합니다."
					},
					contents : {
						required : "내용을 입력 해주세요."
					}
				},
				errorElement : 'span',
				errorPlacement : function(error, element) {
					error.addClass('invalid-feedback');
					element.closest('.form-group').append(error);
				},
				highlight : function(element, errorClass, validClass) {
					$(element).addClass('is-invalid');
				},
				unhighlight : function(element, errorClass, validClass) {
					$(element).removeClass('is-invalid');
				}
			});
		});

		/* function fnSave() {
		 document.frm.contents.value = editor.getHtml();
		 document.frm.action = "/sample/save.proc";
		 document.frm.submit();
		 }

		 function fnUpdate() {
		 document.frm.content.value = editor.getHtml();
		 document.frm.action = "update.proc";
		 document.frm.submit();
		 } */

		function fnDelete() {
			document.frm.action = "delete.proc";
			document.frm.submit();
		}
	</script>
</body>
</html>