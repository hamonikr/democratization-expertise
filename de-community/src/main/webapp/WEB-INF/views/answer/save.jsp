<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>

<script src="/plugins/bootstrap-switch/js/bootstrap-switch.min.js"></script>
<!-- Select2 -->
<script src="/plugins/select2/js/select2.full.min.js"></script>
<link rel="stylesheet" href="/tui-editor/tui-editor/dist/tui-editor.css">
<link rel="stylesheet" href="/tui-editor/tui-editor/dist/tui-editor-contents.css">
<link rel="stylesheet" href="/tui-editor/codemirror/lib/codemirror.css">
<link rel="stylesheet" href="/tui-editor/highlightjs/styles/github.css">
<!-- Select2 -->
<link rel="stylesheet" href="/plugins/select2/css/select2.min.css">
<link rel="stylesheet" href="/plugins/select2-bootstrap4-theme/select2-bootstrap4.min.css">
<!-- tuideditor -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.48.4/codemirror.min.css" />
<link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />
<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
<script src="https://uicdn.toast.com/editor-plugin-color-syntax/latest/toastui-editor-plugin-color-syntax.js"></script>
<style>
<!--
.select2-container--default .select2-selection--multiple .select2-selection__choice
	{
	background-color: #007bff;
	border: 1px solid #aaa;
	border-radius: 4px;
	cursor: default;
	float: left;
	margin-right: 5px;
	margin-top: 5px;
	padding: 0 5px;
}

.select2-container--default.select2-container--focus .select2-selection--multiple
	{
	height: 40px;
}
-->
</style>



<div class="content-center">
	<h2>Stacked Q&amp;A</h2>
	<div class="section-info">
		<span class="bold">질문 작성 가이드 :</span> 커뮤니티는 특정한 코딩, 알고리즘 또는 언어 문제에 대해 당신을 돕기 위함입니다. 의견 기반 질문을 피해주세요.<br> 1. 문제를 요약하세요. (목표에 대한 세부 정보 포함, 예상 결과 및 실제 결과 설명, 오류 메시지 포함)<br> 2. 시도해 본 내용을
		설명하세요.<br> 3. 일부 코드 표시<br>
	</div>


	<form id="frm" name="frm" method="post">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		<input type="hidden" name="answerno" value="${result.answerno}" /> 

		<div class="con-box">
			<div class="form-list">
				<span>내용 <font class="red">*</font></span>
				<div class="de-editro">
					<input type="hidden" name="contents" id="contents" value="">
					<div class="code-html">
						<div id="editSection">${result.contents }</div>
					</div>
					<script class="code-js">
			            var editor = new toastui.Editor( {
			            el : document.querySelector( '#editSection' ),
			            initialEditType : 'wysiwyg',
			            //			                    initialEditType: 'markdown',
			            previewStyle : 'vertical',
			            height : '400px'
			            } );
			          </script>
				</div>

			</div>
		</div>


		<div class="mT30 txt-center">
			<button type="submit" name="btnSubmit" class="btn-blue">수정</button>
			<button type="button" class="btn-gray" onclick="location.href='/questions/list'">목록</button>
		</div>




	</form>


</div>


<script type="text/javascript">
 $( function() {

    //저장 버튼
    //$("#btnSave").on("click",fnSave);	
    //$("#btnUpdate").on("click",fnUpdate);

    $.validator.setDefaults( {
      submitHandler : function() {
        document.frm.contents.value = editor.getHtml();
        document.frm.action = "/answers/edit.proc";
        document.frm.submit();
      }
    } );
    $( '#frm' ).validate( {
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


</script>













