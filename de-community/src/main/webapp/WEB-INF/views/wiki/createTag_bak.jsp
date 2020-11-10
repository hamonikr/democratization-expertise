<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>
 
<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
<script src="https://uicdn.toast.com/editor-plugin-color-syntax/latest/toastui-editor-plugin-color-syntax.js"></script>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.48.4/codemirror.min.css"/>
<link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />
 <!-- Select2 -->
<link rel="stylesheet" href="/plugins/select2/css/select2.min.css">
<link rel="stylesheet" href="/plugins/select2-bootstrap4-theme/select2-bootstrap4.min.css">
<link rel="stylesheet" href="https://uicdn.toast.com/tui-color-picker/latest/tui-color-picker.min.css"/>

<style>
.select2-container--default .select2-selection--multiple .select2-selection__choice {
    background-color: #007bff;
    border: 1px solid #aaa;
    border-radius: 4px;
    cursor: default;
    float: left;
    margin-right: 5px;
    margin-top: 5px;
    padding: 0 5px;
}

.select2-container--default.select2-container--focus .select2-selection--multiple {
    height: 40px;
}

</style>
<body>

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
		<form id="frm" name="frm" method="post">
			<!-- 스프링 시큐리티 form에 추가 해줘야함. -->
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			<input type="hidden" name="section" value="t" />			
			<div class="container-fluid">
				<div class="row">
					<div class="col-12">
						<div class="callout callout-info" >
							<h5>[Tags] 작성하기</h5>
						</div>

						<div class="invoice p-3 mb-3" style="border-left: 5px solid #117a8b;">

							<!-- Table row -->
							<div class="row">
								<div class="card-body card-primary card-outline">
									<div class="form-group">
										<label for="subject">
											[Tag] 이름<span class="important">*</span>
										</label>
										
										<input type="text" class="form-control" id="title" name="title" placeholder="태그 이름을 입력해주세요." value="${result.title}" />
									</div>
									
							<%-- 		<div class="form-group" style="color:black;">
										<label for="Tag">태그</label>
										<select class="select2" multiple="multiple" name="tagno" id="tagno" data-placeholder="" style="width: 100%; background-color: #8056d6;">
											<c:forEach var="item" items="${tagList}" varStatus="status">
												<option value="${item.wikino}">${item.title}</option>
											</c:forEach>
										</select>
									</div>
									 --%>
									<div class="form-group">
										<label for="contents">
											설명<span class="important">*</span>
										</label>
										<input type="hidden" name="contents" id="contents" value="">
										<div class="code-html">
											<div id="editor"></div>
										</div>
										<script class="code-js">
											 const { Editor } = toastui;
											// const { color-syntax } = Editor.plugins;
   											 const { colorSyntax } = Editor.plugin;
											 
					                      var editor = new Editor({
					                      el : document.querySelector( '#editor' ),
					                      initialEditType : 'wysiwyg',
					                      previewStyle : 'vertical',
					                      height : '600px',
					                      plugins: [colorSyntax],
					                      placeholder: '설명을 입력해주세요.',
					                      color:''
					                      });
					                    </script>
									</div>
									

								</div>
							</div>
							
							<div class="card-footer cont_btn_div">
								<c:choose>
									<c:when test="${empty result.wikino}">
										<button type="submit" name="btnSubmit" class="btn btn-primary purple" value="c">등록</button>
									</c:when>
									<c:otherwise>
										<button type="submit" name="btnSubmit" class="btn btn-primary purple" value="u">수정</button>
										<button type="button" id="btnDelete" class="btn btn-primary red">삭제</button>
									</c:otherwise>
								</c:choose>
								<button type="button" class="btn btn-primary gray" onclick="location.href='/wiki/getStart'">목록</button>
							</div>
				
						</div>
					</div>
				</div>
			</div>
		</form>
	</section>

	<script type="text/javascript">
    $( function() {
       $.validator.setDefaults( {
        submitHandler : function() {
        		fnSave();
            }
      } );

       $( '#frm' ).validate( {
      rules : {
      title : {
        required : true
      },
      contents : {
        required : true
      	}
      },
      messages : {
      title : {
        required : "제목을 입력 해주세요."
      },contents : {
        required : "내용을 입력 해주세요."
      	}
      },
      errorElement : 'span',
      errorPlacement : function(error, element) {
        error.addClass( 'invalid-feedback' );
        element.closest( '.form-group' ).append( error );
      },
      highlight : function(element, errorClass, validClass) {
        $( element ).addClass( 'is-invalid' );
      },
      unhighlight : function(element, errorClass, validClass) {
        $( element ).removeClass( 'is-invalid' );
      }
      } );

    } );

    function fnSave() {
        document.frm.action = "/wiki/save.proc";
        document.frm.contents.value = editor.getHtml();
        document.frm.submit();
        
      }

    
  </script>
</body>
</html>