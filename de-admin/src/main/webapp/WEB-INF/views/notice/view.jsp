<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>

<!-- <script src="/tui-editor/jquery/dist/jquery.js"></script> -->
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

<body>
<form id="frm" name="frm" method="post">
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
<input type="hidden" id="user_ip" name="user_ip" value="127.0.0.1"/>
<input type="hidden" id="user_addr" name="user_addr" value="테스트 주소"/>

<div class="row">
	<div id="input_div" class="col-12 " style="margin-top: .75rem;">
		<div class="callout callout-info row ">
			<div class="col-6">
				<h5>공지사항 상세페이지</h5>
			</div>
			<div class="col-6">
				<span class="float-right  "><a href="/main/index">Home</a> / 공지사항 상세페이지</span>
			</div>
		</div>
	</div>


<!-- general form elements -->
	<div class="col-12">
		<div class="card card-primary">
			
			<div class="row mb-2">
				<div class="col-sm-12">
					<h5>공지사항 상세페이지</h5>
				</div>
			</div>
			
			<div class="card-body card-primary card-outline row">
			
				<div class="col-lg-12">
					<div class="form-group">
						<label for="inputEmail3" class="col-form-label">제목</label>
						<span  class="form-control">${result.title}</span>
					 </div>
				 </div>

				<div class="col-lg-6">
					<div class="form-group">
						<label for="inputEmail3" class="col-form-label">작성자</label>
						<span  class="form-control">${result.user_id}</span>
					 </div>
				 </div>
				 
				 <div class="col-lg-6">
					 <div class="form-group">
						<label for="inputEmail3" class="col-form-label">작성일</label>
						<span  class="form-control"><fmt:formatDate value="${result.reg_date}" pattern="yyyy-MM-dd" /></span>
					 </div>
				 </div>

				<div class="col-lg-12">
					<div class="form-group">
						<label for="inputEmail3" class="col-form-label">내용</label>
						<span  class="form-control">${result.contents}</span>
					 </div>
				 </div>

				 <c:if test="${file[0].filerealname != null}">
					 <div class="col-lg-12">
						 <div class="form-group" style="margin-bottom: 0">
							<label for="inputEmail3" class="col-form-label">첨부파일</label>
							<span  class="form-control contents" style="border: 0">
								<c:forEach items="${file }" var="item" varStatus="status">
									<a href="/fileDownload?fm=${item.filemakename}&fom=${item.filerealname}" style="margin-right: 10px">
										<i class="fa fa-save"></i> ${item.filerealname}
									</a>
								</c:forEach>
							</span>
						 </div>
					 </div>
				 </c:if>
				 
			</div>
			
			<div class="card-footer cont_btn_div">
				<button type="button"  class="btn btn-primary gray"  onclick="location.href='list.ivs'"> 목록</button>
			</div>
		</div>
	</div>
	<!-- /.content-wrapper -->
</div>
</form>
</body>

<script type="text/javascript">
$(document).ready(function(){ 
	//수정하기
		$('#click_update').css('display','none');
		$('#click_update').hide();
		$('#click_update_bnt').click(function(){ 
			var state = $('#click_update').css('display'); 

			if(state == 'none'){ 
				$('#click_update').css('display','block');
			}else{ 
				$('#click_update').css('display','none');
				}
		});

	//답변하기	
	$('#inquiry_answer').css('display','none');
	
	$('#inquiry_answer_bnt').click(function(){ 
		var state = $('#inquiry_answer').css('display'); 
		if(state == 'none'){ 
			$('#inquiry_answer').css('display','block');
		}else{ 
			$('#inquiry_answer').css('display','none');
			}
	});
});

function save(){
	alert("등록버튼 클릭");
	document.frm.comments.value = editor.getHtml();
	document.frm.action = "save.proc";
	document.frm.submit();	

}

function requestToHead(){
	 var proc_stat = 3; //본사요청한 경우 

	if(confirm("본사 요청하시겠습니까?")==true){	       			
		 $.ajax({
			data : {proc_stat},
		 	url : "/inquiry/save.proc", 
		 	success :function(result){
		 		alert("본사로 요청이 완료되었습니다!");
	 			location.reload();						
	      	 	}
		 });	  	   			  		
	}
}

function cancelRequestToHead(){
	 var proc_stat = 0; //본사요청 취소한 경우 

	if(confirm("본사 요청을 취소하시겠습니까?")==true){	       			
		 $.ajax({
			data : {proc_stat},
		 	url : "/inquiry/save.proc", 
		 	success :function(result){
		 		alert("본사로 요청이 취소되었습니다!");
	 			location.reload();						
	      	 	}
		 });	  	   			  		
	}
}


var tmp = 0;
function updateComment(){
	alert("수정 버튼 클릭");
	tmp = 1;
	 var title = $("#title_up").val();
	 var comments = $("#comments_up").val();
	 var proc_stat = $("#proc_stat_up").val();
	 var title = $("#title_up").val();

	comments = editor.getHtml();
	 
	if(confirm("수정하시겠습니까?")==true){	       			
	 $.ajax({
		data : {title, comments, proc_stat},
	 	url : "/inquiry/update.proc", 
	 	success :function(result){
	 		alert("수정이 완료되었습니다!");
 			location.reload();						
      	 	}
	 });
  	   			  			 			
   }
}


$("#cancel").click(function(){
	$("#inquiry_answer").css("display","none");
})

$("#update_cancel").click(function(){
	$("#click_update").css("display","none");
})

function deleteComment(){
	var title = $("#commentList.title").val();
	var proc_stat = 0;
	if(confirm("삭제하시겠습니까?")==true){	       			
		 $.ajax({
			data : {title, proc_stat},
		 	url : "/inquiry/delete.proc", 
		 	success :function(result){
	 			location.reload();						
		 		
	      	 	}
		 });
	}
}
</script>
</html>