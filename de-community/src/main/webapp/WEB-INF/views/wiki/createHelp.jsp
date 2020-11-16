<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>
 
<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.48.4/codemirror.min.css"/>
<link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />
 
 <!-- Select2 -->
<link rel="stylesheet" href="/plugins/select2/css/select2.min.css">
<link rel="stylesheet" href="/plugins/select2-bootstrap4-theme/select2-bootstrap4.min.css">




<div class="content-center">
            <h2>자주하는 질문 작성하기</h2>
           
<form id="frm" name="frm" method="post">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />              
           <div class="con-box">
              <div class="form-list">
                <span>이름 <font class="red">*</font></span>
                <input type="text" name="title" id="title" placeholder="제목을 입력하세요" class="input-type1" value="${result.title}">

                <span>설명 <font class="red">*</font></span>
                <div class="de-editro">
                  여기에 에디터를 적용해주세요. 높이 400px 으로 적용
                  <input type="hidden" name="contents" id="contents" value="">
					<div class="code-html">
						<div id="editor"></div>
					</div>
					<script class="code-js">
                      var editor = new toastui.Editor( {
                      el : document.querySelector( '#editor' ),
                      initialEditType : 'wysiwyg',
                      previewStyle : 'vertical',
                      height : '400px'
                      } );
                    </script>
                </div>

              </div>
            </div><!-- //con-box -->

            <div class="mT30 txt-center">
              <input type="hidden" id="section" name="section" value="${gubun }">
				<c:choose>
					<c:when test="${empty result}">
						<button type="submit" name="btnSubmit" class="btn-blue" value="c">등록</button>
					</c:when>
					<c:otherwise>
						<button type="submit" name="btnSubmit" class="btn-blue" value="u">수정</button>
						<button type="button" id="btnDelete" class=" btn-warning">삭제</button>
					</c:otherwise>
				</c:choose>
				<button type="button" class="btn-gray" onclick="location.href='/wiki/Help/${gubun}'">목록</button>
				
            </div>
</form>
</div>












		

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
