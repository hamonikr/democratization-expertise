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
/* .select2-container--default .select2-selection--multiple .select2-selection__choice { */
/*     background-color: #007bff; */
/*     border: 1px solid #aaa; */
/*     border-radius: 4px; */
/*     cursor: default; */
/*     float: left; */
/*     margin-right: 5px; */
/*     margin-top: 5px; */
/*     padding: 0 5px; */
/* } */

/* .select2-container--default.select2-container--focus .select2-selection--multiple { */
/*     height: 40px; */
/* } */

</style>
<body>

<div class="content-center">
	<h2>Wiki 작성하기</h2>
	<form id="frm" name="frm" method="post">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		<input type="hidden" id="section" name="section" value="w" />		
			
			
		<div class="con-box">
			<div class="form-list">
				<span>이름 <font class="red">*</font></span>
				<div id="form-group">
                <input type="text" id="title" name="title" value="${result.title}" placeholder="태그 이름을 입력하세요" class="input-type1">
				</div>
                <span>설명 <font class="red">*</font></span>
                <div class="de-editro" >
                	<div id="form-group">
                  <input type="hidden" name="contents" id="contents" value="" >
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
					                      height : '400px',
					                      plugins: [colorSyntax],
					                      placeholder: '설명을 입력해주세요.',
					                      color:''
					                      });
					                    </script>
					 </div> 
                </div>
			</div>
		</div>
		
		<div class="mT30 txt-center">
			<c:choose>
				<c:when test="${empty result.wikino}">
					<button type="submit" name="btnSubmit" class="btn-blue" value="c">등록</button>
				</c:when>
				<c:otherwise>
					<button type="submit" name="btnSubmit" class="btn-blue" value="u">수정</button>
					<button type="button" id="btnDelete" class="btn-blue">삭제</button>
				</c:otherwise>
			</c:choose>
			<button type="button" class="btn-gray" onclick="location.href='/wiki/getStart'">목록</button>
<!-- 			<button type="button" class="btn-gray" onclick="location.href='/wiki/getStart'">목록</button> -->
		</div>
		
	</form>   
</div>

				

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
        var contents = editor.getHtml();

        if(contents.length !=0 ){
	        document.frm.action = "/wiki/save.proc";
	        document.frm.contents.value = contents;
	        document.frm.submit();
        } else{
				alert("내용을 입력해주세요");
            }
        
      }

    
  </script>
</body>
</html>