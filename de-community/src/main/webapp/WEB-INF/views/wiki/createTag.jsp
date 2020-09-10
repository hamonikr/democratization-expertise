<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<head>
	<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
	<!-- Editor's Dependecy Style -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.48.4/codemirror.min.css"/>
	<!-- Editor's Style -->
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
       <div class="form-group inputStyle">
			<div id= "editor">
			</div>
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



var editor = new toastui.Editor({
    el: document.querySelector('#editor'),
    initialEditType: 'wysiwyg',
    previewStyle: 'vertical',
    height: '500px';

});

</script>