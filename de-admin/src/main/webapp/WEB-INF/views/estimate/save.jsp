<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<link rel="stylesheet" href="/tui-editor/tui-editor/dist/tui-editor-contents.css"> 
<link rel="stylesheet" href="/tui-editor/codemirror/lib/codemirror.css">
<link rel="stylesheet" href="/tui-editor/highlightjs/styles/github.css">

<!-- jquery-validation -->
<script src="/plugins/jquery-validation/jquery.validate.min.js"></script>
<script src="/plugins/jquery-validation/additional-methods.min.js"></script>

<body>

<form id="frm" name="frm" method="post">
<c:if test="${result ne null }">
<input type="hidden" name="bizcd" id="bizcd" value="${result.bizcd}" />
<input type="hidden" name="seq" id="seq" value="${result.seq}" />
</c:if>
<c:if test="${result eq null }">
<input type="hidden" name="bizcd" id="bizcd" value="${userSession.bizcd}" />
</c:if>
<!-- 스프링 시큐리티 form에 추가 해줘야함. -->
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
<div class="row">

	<div id="input_div" class="col-12 " style="margin-top: .75rem;">
		<div class="callout callout-info row ">
			<div class="col-6">
				<h5>견적요청</h5>
			</div>
			<div class="col-6">
				<span class="float-right  "><a href="/main/index">Home</a> / 비즈니스 / 견적요청</span>
			</div>
		</div>
	</div>
	

<!-- general form elements -->
	<div class="col-12">
            <div class="card card-primary">
            	
            	<div class="row mb-2">
					<div class="col-sm-12">
						<h5>견적요청</h5>
					</div>
				</div>
            	
                <div class="card-body card-primary card-outline row">
                
                	<div class="col-lg-12">
	                  <div class="form-group">
	                    <label for="subject">제목 <span class="important">*</span></label>
	                    <input type="text" class="form-control" id="subject" name="subject" placeholder="제목을 입력해주세요." value="${result.subject}" />
	                  </div>
                  </div>
	                  
				<div class="col-lg-4">
	                  <div class="form-group">
	                    <label for="price">요청가격(원) <span class="important">*</span></label>
	                    <input type="text" name="price" id="price" class="form-control" placeholder="가격을 입력해주세요." value="${result.price}" <c:if test="${result.consent eq 1 }">disabled</c:if>/> 
	                  </div>
                  </div>
	                  
				<div class="col-lg-4">
	                  <div class="form-group">
	                    <label for="writer_id">ID</label>
	                    <c:if test="${result ne null }">
	                          <input type="text" class="form-control" name="writer_id" id="writer_id" value="${result.writer_id}" readonly />
	                          </c:if>
							 <c:if test="${result eq null }">
	                          <input type="text" class="form-control" name="writer_id" id="writer_id" value="${userSession.username}"  readonly />
	                          </c:if>
	                  </div>
                  </div>
	                  
				<div class="col-lg-4">
	                  <div class="form-group">
	                    <label for="writer_name">이름</label>
								<c:if test="${result ne null }">
								<input type="text" name="writer_name" id="writer_name" class="form-control" value="${result.writer_name}"  readonly />
								</c:if>
								<c:if test="${result eq null }">
								<input type="text" name="writer_name" id="writer_name" class="form-control" value="${userSession.user_nm}"  readonly/>
								</c:if>
	                  </div>
                  </div>
	                  
				<div class="col-lg-12">
	                  <div class="form-group">
	                    <label for="content">내용 <span class="important">*</span></label>
	                     <input type="hidden" name="content" id="content" value="">
							<div class="code-html">
								<div id="editSection">${result.content }</div> 
				            </div>
				            <script class="code-js">
				                var editor = new tui.Editor({
				                    el: document.querySelector('#editSection'),
				                    initialEditType: 'wysiwyg',
	//			                    initialEditType: 'markdown',
				                    previewStyle: 'vertical',
				                    height: '400px'
				                });
				            </script>
	                  </div>
                  </div>
	                  
	                  
	                  <!-- <div class="form-group">
	                    <label for="exampleInputFile">File input</label>
	                    <div class="input-group">
	                      <div class="custom-file">
	                        <input type="file" class="custom-file-input" id="exampleInputFile">
	                        <label class="custom-file-label" for="exampleInputFile">Choose file</label>
	                      </div>
	                      <div class="input-group-append">
	                        <span class="input-group-text" id="">Upload</span>
	                      </div>
	                    </div>
	                  </div> -->
	                  <!-- <div class="form-check">
	                    <input type="checkbox" class="form-check-input" id="exampleCheck1">
	                    <label class="form-check-label" for="exampleCheck1">Check me out</label>
	                  </div> -->
	                </div>
           
				<div class="card-footer cont_btn_div">
					<c:choose> 
						<c:when test="${result.writer_id == null}"> 
							<button type="submit" name="btnSubmit" class="btn btn-primary purple" value="c"> 등록</button>
						</c:when>
						<c:otherwise>
							<button type="submit" name="btnSubmit" class="btn btn-primary purple" value="u"> 수정</button>
							<button type="button" id="btnDelete" class="btn btn-primary red"> 삭제</button>
						</c:otherwise>
					</c:choose>
					<button type="button" class="btn btn-primary gray" onclick="location.href='list.ivs'"> 목록</button>
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
    $("#btnDelete").on("click",fnDelete);

     $.validator.setDefaults({
	    submitHandler: function () {
		   var vv = $("input[name=btnSubmit]").val();
	    	document.frm.content.value = editor.getHtml();
	    	if(vv == "c")
	    		document.frm.action = "save.proc";
	    	else if(vv == "u")
	    		document.frm.action = "update.proc";
	    	document.frm.submit();
	    }
	  }); 
    $('#frm').validate({
	    rules: {
	    	subject: {
		        required: true
		      },
	    	price: {
		        required: true,
		        number: true
		      },
	    	content: {
		        required: true
		      }
	    },
	    messages: {
	    	subject: {
		        required: "제목을 입력 해주세요."
		      },
	    	price: {
		        required: "가격을 입력 해주세요.",
		        number: "숫자만 입력 가능합니다."
		      },
	    	content: {
		        required: "내용을 입력 해주세요."
		      }
	    },
	    errorElement: 'span',
	    errorPlacement: function (error, element) {
	      error.addClass('invalid-feedback');
	      element.closest('.form-group').append(error);
	    },
	    highlight: function (element, errorClass, validClass) {
	      $(element).addClass('is-invalid');
	    },
	    unhighlight: function (element, errorClass, validClass) {
	      $(element).removeClass('is-invalid');
	    }
	  });
});

function fnSave() {
	document.frm.content.value = editor.getHtml();
	document.frm.action = "save.proc";
	document.frm.submit();
}

function fnUpdate() {
	document.frm.content.value = editor.getHtml();
	document.frm.action = "update.proc";
	document.frm.submit();
}

function fnDelete() {
	document.frm.action = "delete.proc";
	document.frm.submit();
}
</script>
</body>
</html>