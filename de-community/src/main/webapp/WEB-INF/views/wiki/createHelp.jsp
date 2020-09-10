<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<head>
	<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.48.4/codemirror.min.css"/>
	<link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" /> 	
 </head>
<title>wiki 작성하기 페이지</title>
</head>

<style>
.inputStyle{
	padding : 2%;
}

.edit_part{
display: block;
}

#mw-panel {
    font-size: inherit;
    position: absolute;
    top: 160px;
    padding-top: 1em;
    width: 10em;
    left: 0;
}
</style>
<body>
<form id="frm" name="frm">
	<input type="hidden" name="section" id="section" value="helps">
	   <div class="form-group inputStyle">	
			<!-- title -->	
			<div class="title">
				<label for="contents">질문 제목<span class="important">*</span></label>
				<input type="text" id="title">
			</div>
			<!-- contents -->
			<div class="content">
				<div class="form-group">
					<label for="contents">답변 내용<span class="important">*</span></label>
					<input type="hidden" name="contents" id="contents" value="">
					<div class="code-html">
						<div id="editSection"></div>
					</div>
					<script class="code-js">
						var editor = new toastui.Editor(
								{
									el : document.querySelector('#editSection'),
									initialEditType : 'wysiwyg',
									previewStyle : 'vertical',
									height : '500px'
								});
					</script>
				</div>
			</div>
			<!-- end contents  -->
		        <br>
		        <!-- 버튼부 -->
			 <div>
			 	<input type="button" id="create_btn" name="create_btn" value="생성하기">
			 	<input type="button" id="cancel_btn" name="cancel_btn" value="취소하기" onclick="location.href='/wiki/getStart';">	 	
			 </div>
        </div>
	
   </form>
</body>
  

<!-- script 부분 -->

<script>



</script>