<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<script type="text/javascript" src="/ckeditor/ckeditor.js"></script>
<!-- <script src="https://cdn.ckeditor.com/4.14.1/full/ckeditor.js"></script>
 -->

<title>wiki domain</title>
</head>
<style>
.inputStyle{
	padding : 2%;
}
</style>
  <body>
 		<form>
 			<div class="inputStyle">
            <textarea name="editor1" id="editor1" rows="10" cols="80">
 					글작성부
             </textarea>
          </div> 
            <script>
                // Replace the <textarea id="editor1"> with a CKEditor 4
                // instance, using default configuration.
                CKEDITOR.replace( 'editor1' );
            </script>
        </form>
    </body>
    
      

</html>