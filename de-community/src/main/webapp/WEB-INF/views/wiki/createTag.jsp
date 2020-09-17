<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>
<!-- 
<script src="/plugins/bootstrap-switch/js/bootstrap-switch.min.js"></script>
<script src='/tui-editor/markdown-it/dist/markdown-it.js'></script>
<script src="/tui-editor/to-mark/dist/to-mark.js"></script>
<script src="/tui-editor/tui-code-snippet/dist/tui-code-snippet.js"></script>
<script src="/tui-editor/codemirror/lib/codemirror.js"></script>
<script src="/tui-editor/highlightjs/highlight.pack.js"></script>
<script src="/tui-editor/squire-rte/build/squire-raw.js"></script>
<script src="/tui-editor/tui-editor/dist/tui-editor-Editor.js"></script>
 -->
 
<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.48.4/codemirror.min.css"/>
<link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />
 
 <!-- Select2 -->
<link rel="stylesheet" href="/plugins/select2/css/select2.min.css">
<link rel="stylesheet" href="/plugins/select2-bootstrap4-theme/select2-bootstrap4.min.css">

<style>

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
									<div class="form-group">
										<label for="contents">
											설명<span class="important">*</span>
										</label>
										<input type="hidden" name="contents" id="contents" value="">
										<div class="code-html">
											<div id="editor"></div>
										</div>
										<script class="code-js">
					                      var editor = new toastui.Editor( {
					                      el : document.querySelector( '#editor' ),
					                      initialEditType : 'wysiwyg',
					                      previewStyle : 'vertical',
					                      height : '600px'
					                      } );
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
      $( "input[data-bootstrap-switch]" ).each( function() {
        $( this ).bootstrapSwitch( 'state', $( this ).prop( 'checked' ) );
      } );
      

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