<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<!-- ckeditor js -->
<script type="text/javascript" src="/ckeditor/ckeditor.js"></script>

<title>wiki domain</title>
</head>
<style>
.inputStyle{
	padding : 2%;
}
</style>
  <body >
 		<form  class="inputStyle">
 		<!-- 카테고리 드랍다운리스트 -->
 		<div class="row">
 			
 		</div>
 		<hr>
 		<!-- 제목 -->
 		<div class="row">
 			<input type="text" id="title">
 		</div>
 		<hr>
		<div class="">
          <textarea name="editor1" id="editor1" rows="10" cols="80">
				글작성부
           </textarea>
        </div> 
          <script>             
              CKEDITOR.replace( 'editor1' );
          </script>
          <hr>
      	<!-- 버튼 -->
      	<div>
      		<ul>
      			<li><button type="submit" class="btn btn-flat" id="submit_btn" name="submit_btn">작성하기</button></li>
      			<li><button type="button" class="btn btn-flat" id="cancel_btn" name="cancel_btn">취소하기</button></li>
      		</ul>
      	</div>
        </form>
       
    </body>
    
      

</html>