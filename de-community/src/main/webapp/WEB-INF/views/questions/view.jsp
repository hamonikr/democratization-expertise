<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>
<link rel="stylesheet" href="/plugins/summernote/summernote-bs4.css">
<style> 
.rcorners1 {
  border-radius: 25px;
  background: #9c7df2;
  padding: 10px; 
  width: 100%;
  height: 100%;  
  color: white;
}

.rcorners2 {
  border-radius: 25px;
  border: 2px solid #9a80eb;
  padding: 20px; 
  width: 200px;
  height: 150px;  
}

</style>
<link rel="stylesheet" href="/tui-editor/tui-editor/dist/tui-editor.css">
<link rel="stylesheet" href="/tui-editor/tui-editor/dist/tui-editor-contents.css">
<script src="/plugins/bootstrap-switch/js/bootstrap-switch.min.js"></script>
<script src='/tui-editor/markdown-it/dist/markdown-it.js'></script>
<script src="/tui-editor/to-mark/dist/to-mark.js"></script>
<script src="/tui-editor/tui-code-snippet/dist/tui-code-snippet.js"></script>
<script src="/tui-editor/codemirror/lib/codemirror.js"></script>
<script src="/tui-editor/highlightjs/highlight.pack.js"></script>
<script src="/tui-editor/squire-rte/build/squire-raw.js"></script>
<script src="/tui-editor/tui-editor/dist/tui-editor-Editor.js"></script>
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
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			<input type="hidden" name="questionno" value="${result.questionno}" /> 

			<div class="container-fluid">
				<div class="row">
					<div class="col-12">
						<div class="invoice p-3 mb-3">
							<div class="row">
								<div class="col-1 rcorners2">
									<span class="font-weight-bold"> 
										<a href="#" onclick="fnLike('${result.questionno}','${result.userno}','Q','${result.vote.likes }')"> 
										<i class="far fa-thumbs-up mr-1"></i>Up </a>
										<font id="like">${result.vote.likes }</font>
									</span> 
									
									<hr> 
									
									<span class="font-weight-bold"> 
										<a href="#"  onclick="fnDisLike('${result.questionno}','${result.userno}','Q','${result.vote.dislikes }')"> 
											<i class="far fa-thumbs-down mr-1"></i> Down </a> 
										<font id="dislike">${result.vote.dislikes }</font>
									</span>
								</div>
								
								<div style="width:10px"></div>
								
								<div class="col-10">
									<div class="post">
										<div class="user-block" style="border-bottom: thick double #32a1ce;">
											<span class="username" style="margin-left: 0px;"> <a href="#">${result.title}</a></span> 
											<span class="description" style="margin-left: 0px;">
												<fmt:formatDate value="${result.registerdate}" pattern="yyyy-MM-dd" />
												<font class="float-right">조회수 : ${result.readcnt} </font>
											</span>
										</div>
										<code><p>${result.contents }</p></code>
										<p>
										<c:set var="tag" value="${fn:split(result.tagno,',')}" />
											<font class="link-black text-sm rcorners1"> Tags : 
											<c:forEach var="tagName2" items="${tag }" varStatus="status">
												<c:forEach var="tagName1" items="${tagList }" varStatus="status">
													<c:if test="${tagName1.wikino == tagName2}"><a href="/wiki/view/${tagName1.wikino }">${tagName1.title}</a></c:if>
												</c:forEach>
											</c:forEach>
											</font> 
											<span class="float-right "> 
											<a href = "/users/activity/${result.userno}">
												<c:if test="${result.users.userprofileimg != null}">
													<img src="/upload/users/${result.users.userprofileimg}">
												</c:if>
												<c:if test="${result.users.userprofileimg == null and result.users.picture == null}">
													<img src="/img/noprofile.png">
												</c:if>
												<c:if test="${result.users.picture != null and result.users.userprofileimg == null}">
													<img alt="profile" src="${result.users.picture}" id="profileImg" class="img" width="63px" height="63px"><br/>
												</c:if>
												</a>
												<a href="/users/activity/${result.userno}" class="link-black text-sm"> ${result.users.username}</a>
											</span>
										</p>
									</div>
								</div>
								
							</div>
							
							<div class="card-footer cont_btn_div">
								<c:if test="${(result.editauth eq 1 or result.userno eq user.userno)}">
									<a href="/questions/edit/${result.questionno}" class="btn btn-primary purple">수정</a>
								</c:if>
								<button type="button" class="btn btn-primary gray" onclick="location.href='/questions/list'">목록</button>
							</div>
							
							<div class="row p-3 col-12" style="border-bottom: thick double #32a1ce;"></div>
							
							<div class="row">
								<c:forEach var="list" items="${answerList}" varStatus="stat">
								<div class="col-10">
								답변내용:${list.contents } <br/>
								등록자:${list.users.username } <br/>
								등록일:<fmt:formatDate value="${list.registerdate}" pattern="yyyy-MM-dd" /><br/>
								<c:if test="${(list.users.userno eq user.userno)}">
									<a href="#" class="btn btn-primary purple">수정</a>
								</c:if>
								</div>
								</c:forEach>
								<div class="mb-3">
								<input type="hidden" name="contents" id="contents" value="">
										<div class="code-html">
											<div id="editSection"></div>
										</div>
										<script class="code-js">
					                      var editor = new tui.Editor( {
					                      el : document.querySelector( '#editSection' ),
					                      initialEditType : 'wysiwyg',
					                      //			                    initialEditType: 'markdown',
					                      previewStyle : 'vertical',
					                      height : '400px'
					                      } );
					                    </script>
              					</div>
							</div>
							<button id="btnAnswer" class="btn btn-primary purple">답변등록</button>
						</div>
					</div>
				</div>
			</div>
		</form>
	</section>

	<script type="text/javascript">
    $( function() {
      //승인 버튼
      $( "#btnAnswer" ).on( "click", fnAnswer );
      //$( "#btnUpdate" ).on( "click", fnUpdate );
      //$( "#btnSale" ).on( "click", fnSale );
    } );

    function fnAnswer() {
      document.frm.contents.value = editor.getHtml();
      document.frm.action = "/answers/save.proc";
      document.frm.submit();
    }

    function fnLike(p, su, s, l) {
      var like = l;
      console.log( "like===" + like );
      $.ajax( {
      //type: "POST", 
      contentType : "application/json",
      url : "/vote/like",
      data : {
      pno : p,
      section : s,
      userno : su,
      likes : 1
      },
      //dataType: 'json', 
      success : function(data) {
        console.log( data );
        if (data == "FAIL") {
          alert( "이미 투표하셨습니다." );
          /* $(".like").each(function(index, item){ 
          	alert($(".like").eq(index).attr('value'));
          }) */
        } else if (data == "LOGIN") {
          alert( "로그인 후 투표해주세요." );
          location.href = "/login";
        } else {
          alert( "투표하였습니다." );
          ++l;
          $( "#like" ).html( l );
        }
      },
      error : function(e) {
        alert( "fail" );
      }
      } );

    }
    function fnDisLike(p, su, s, l) {

      $.ajax( {
      //type: "POST", 
      contentType : "application/json",
      url : "/vote/dislike",
      data : {
      pno : p,
      section : s,
      userno : su,
      dislikes : 1
      },
      //dataType: 'json', 
      success : function(data) {
        console.log( data );
        if (data == "FAIL") {
          alert( "이미 투표하셨습니다." );
        } else if (data == "LOGIN") {
            alert( "로그인 후 투표해주세요." );
            location.href = "/login";
        } else {
          alert( "투표하였습니다." );
          ++l;
          $( "#dislike" ).html( l );
        }
      },
      error : function(e) {
        alert( "fail" );
      }
      } );

    }
  </script>
</body>
</html>