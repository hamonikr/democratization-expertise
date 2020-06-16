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
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> <input type="hidden" id="user_ip" name="user_ip" value="127.0.0.1" /> <input type="hidden" id="user_addr"
			name="user_addr" value="테스트 주소"
		/>

		<div class="row">

			<div id="input_div" class="col-12 " style="margin-top: .75rem;">
				<div class="callout callout-info row ">
					<div class="col-6">
						<h5>기술문의</h5>
					</div>
					<div class="col-6">
						<span class="float-right  "><a href="/main/index">Home</a> / 기술문의</span>
					</div>
				</div>
			</div>

			<!-- general form elements -->
			<div class="col-12">
				<div class="card card-primary">
					<section class="col-12 content-header" style="padding: 2px .5rem; margin-top: 34px;">
						<div class="container-fluid">
							<div class="row mb-2">
								<div class="">
									<h5>기술지원 문의 내용</h5>
								</div>
							</div>
						</div>
					</section>

					<div class="card-body card-primary card-outline row">

						<div class="col-lg-6">
							<div class="form-group">
								<label for="inputEmail3" class="col-form-label">공급자</label>
								<span class="form-control">${result.supply_name}</span>
							</div>
						</div>

						<div class="col-lg-6">
							<div class="form-group">
								<label for="inputEmail3" class="col-form-label">수요자</label>
								<span class="form-control">${result.demand_name}</span>
							</div>
						</div>
	
						<div class="col-lg-6">
							<div class="form-group">
								<label for="inputEmail3" class="col-form-label">작성자</label>
								<span class="form-control">${result.ts_user}</span>
							</div>
						</div>
	
						<div class="col-lg-6">
							<div class="form-group">
								<label for="inputEmail3" class="col-form-label">작성일</label>
								<span class="form-control"><fmt:formatDate value="${result.reg_date}" pattern="yyyy-MM-dd" /></span>
							</div>
						</div>

						<div class="col-lg-12">
							<div class="form-group">
								<label for="inputEmail3" class="col-form-label">내용</label>
								<span class="form-control contents">${result.contents}</span>
							</div>
						</div>

					</div>

					<div class="card-footer cont_btn_div">
						<button type="button" class="btn btn-primary gray" onclick="location.href='list.ivs#'">목록</button>

						<c:if test="${commentList == null}">
							<c:if test="${result.proc_stat ne '3'}">
								<button type="button" class="btn btn-primary purple" name="inquiry_answer_bnt" id="inquiry_answer_bnt">답변하기</button>
								<button type="button" class="btn btn-primary purple" id="request" onClick="requestToHead()">본사요청</button>
							</c:if>
							<c:if test="${result.proc_stat eq '3'}">
								<button type="button" class="btn btn-primary purple" name="inquiry_answer_bnt" id="inquiry_answer_bnt" disabled="disabled">답변하기</button>
								<button type="button" class="btn btn-primary red" id="canel_request" onClick="cancelRequestToHead()">본사요청 취소</button>
							</c:if>
						</c:if>
					</div>
				</div>
			</div>


			<!-- 답글 작성부분  -->
			<section id="inquiry_answer_head" class="content-header" style="padding: 2px .5rem;margin-top: 34px;  display: none">
				<div class="container-fluid">
					<div class="row mb-2">
						<div class="col-sm-12">
							<h5>답변 내용</h5>
						</div>
					</div>
				</div>
			</section>

			<div class="col-12">
				<div class="card card-primary" id="inquiry_answer" style="display: none">

					<div class="card-body card-primary card-outline row">

						<div class="col-lg-8">
							<div class="form-group">
								<label for="inputEmail3" class="col-form-label">제목</label>
								<input type="text" class="form-control" name="title" id="title">
							</div>
						</div>
	
						<div class="col-lg-4">
							<div class="form-group">
								<label for="inputEmail3" class="col-form-label">처리 상태</label>
								<select name="proc_stat" id="proc_stat" class="form-control">
									<option value="1">처리중</option>
									<option value="2">완료</option>
								</select>
							</div>
						</div>

						<div class="col-lg-12">
							<div class="form-group">
								<label for="inputEmail3" class="col-form-label">내용</label>
								<input type="hidden" name="comments" id="comments" value="">
								<div id="answer_section"></div>
								<script class="code-js">
									var editor = new tui.Editor({
										el: document.querySelector('#answer_section'),
										initialEditType: 'wysiwyg',
										previewStyle: 'vertical',
										height: '400px'
									});
								</script>
							</div>
						</div>
					</div>


					<div class="card-footer cont_btn_div">
						<button type="submit" class="btn btn-primary purple" id="ans_save" onClick="save()">등록</button>
						<button type="button" class="btn btn-primary gray" id="cancel">취소</button>
					</div>
				</div>
			</div>


			<!-- 답변 내용 -->
			<c:if test="${commentList != null}">
				<section class="content-header" style="padding: 2px .5rem;margin-top: 34px;">
					<div class="container-fluid">
						<div class="row mb-2">
							<div class="col-sm-12">
								<h5>답변 내용</h5>
							</div>
						</div>
					</div>
				</section>
				
				<div class="col-12">
					<div class="card-body p-0" style="display: block;">
						<div id="ansView">
							<div class="card card-primary">
								<div class="card-body card-primary card-outline row">
								
									<div class="col-lg-8">
										<div class="form-group">
											<label for="inputEmail3" class="col-form-label">제목</label>
											<span class="form-control">${commentList.title}</span>
										</div>
									</div>
										
									<div class="col-lg-4">
										<div class="form-group">
											<label for="inputEmail3" class="col-form-label">작성일</label>
											<span class="form-control"><fmt:formatDate value="${commentList.reg_date}" pattern="yyyy-MM-dd" /></span>
										</div>
									</div>
										
									<div class="col-lg-12">
										<div class="form-group">
											<label for="inputEmail3" class="col-form-label">내용</label>
											<span class="form-control contents">${commentList.comments}</span>
										</div>
									</div>
								</div>
								<div class="card-footer cont_btn_div">
									<button type="button" class="btn btn-primary purple" id="click_update_bnt">수정</button>
									<button type="button" class="btn btn-primary red" onClick="deleteComment();">삭제</button>
								</div>
							</div>
						</div>


						<!-- 답변 수정  -->
						<div id="ansMod">
							<div class="card card-primary" id="click_update" style="display: none">
								<div class="card-body card-primary card-outline">
									<div class="form-group">
										<label for="inputEmail3" class="col-form-label">제목</label>
										<input type="text" class="form-control form-control-sm" name="title_up" id="title_up" value="${commentList.title}">
									</div>

									<div class="form-group">
										<label for="inputEmail3" class="col-form-label">처리 상태</label>
										<select name="proc_stat_up" id="proc_stat_up" value="${commentList.proc_stat}" class="form-control form-control-sm">
											<option value="1" <c:if test="${commentList.proc_stat eq '1' }"> selected </c:if>>처리중</option>
											<option value="2" <c:if test="${commentList.proc_stat eq '2' }"> selected </c:if>>완료</option>
										</select>
									</div>

									<div class="form-group">
										<label for="inputEmail3" class="col-form-label">내용</label>
										<input type="hidden" name="comments_up" id="comments_up" value="${commentList.comments}">
										<div id="answer_section_up">${commentList.comments}</div>
										<script class="code-js">
										var editor = new tui.Editor({
											el: document.querySelector('#answer_section_up'),
											initialEditType: 'wysiwyg',
											previewStyle: 'vertical',
											height: '400px'
										});
									</script>
									</div>
								</div>
								<div class="card-footer cont_btn_div">
									<button type="button" class="btn btn-primary purple" onClick="updateComment();">수정</button>
									<button type="button" class="btn btn-primary gray" id="updateCancel">취소</button>
<!-- 										<button type="button" class="btn btn-primary gray" id="cancel">취소</button> -->
								</div>
							</div>
						</div>
						<!-- 답변 수정  -->

					</div>
				</div>
			</c:if>
		</div>
	</form>
</body>

<script type="text/javascript">
$(document).ready(function(){ 
	//수정하기
		$('#click_update_bnt').click(function(){ 
			var state = $('#click_update').css('display'); 
			if(state == 'none'){
			  $('#ansView').hide();
				$('#click_update').css('display','block');
			}else{
				$('#click_update').css('display','none');
			}
		});
		$('#updateCancel').click(function(){ 
			$('#click_update').css('display','none');
			$('#ansView').show();
		});
		

	$('#inquiry_answer_bnt').click(function(){ 
		var state = $('#inquiry_answer').css('display'); 
		if(state == 'none'){ 
			$('#inquiry_answer').css('display','block');
			$('#inquiry_answer_head').css('display','block');
		}else{ 
			$('#inquiry_answer').css('display','none');
			$('#inquiry_answer_head').css('display','none');
		}
	});
});

function save(){
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
	$("#inquiry_answer_head").css("display","none");
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