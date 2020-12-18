<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>
<!-- <link rel="stylesheet" href="/plugins/summernote/summernote-bs4.css"> -->

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



<div class="content-center">
	<form id="frm" name="frm" method="post">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
	<input type="hidden" name="boardno" value="${result.boardno}" />

		<div class="con-box">
			<div class="form-view">

				<!-- 질문내용 -->
				<div class="view-title">${result.title}</div>

				<ul class="qna-list">
					<li class="person">
						<img src="/img/noprofile.png">
						<span class="name">${result.userid}</span> 
						<span class="reputation"></span> 
						<span class="voting"></span>
					</li>
					<li class="question">
						<p>
							<fmt:formatDate value="${result.registerdate}" pattern="yyyy-MM-dd HH:mm" />
						</p> 
						<div>
						
						<c:if test="${result.youtube ne null and result.youtube ne ''}">
						<br><br>
							<iframe width="580" height="450" src="https://www.youtube.com/embed/${result.youtube}" 	frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen>
							</iframe>	
						</c:if>
						</div>
						<code>
								<br><p>${result.contents}</p>
						</code> 
							<%-- <span class="ques-tag"> 
							<c:set var="tag" value="${fn:split(result.tagno,',')}" /> 
							<c:forEach var="tagName2" items="${tag }" varStatus="status">
								<c:forEach var="tagName1" items="${tagList }" varStatus="status">
									<c:if test="${tagName1.wikino == tagName2}">
										<a href="/wiki/view/${tagName1.wikino }">${tagName1.title}</a>
									</c:if>
								</c:forEach>
							</c:forEach>
						</span> --%>
					</li>
					<%-- <li class="subinfo">
						<span><i class="mdi mdi-message-processing"></i> ${result.commentcnt }</span> 
						<span><i class="mdi mdi-eye-outline"></i> ${result.readcnt} </span> 
						<span class="up" onclick="fnLike('${result.boardno}','${result.userno}','Q','${result.vote.likes }')">
							<i class="mdi mdi-arrow-up" id="like">${result.vote.likes }</i>
						</span> 
						<span class="down" onclick="fnDisLike('${result.boardno}','${result.userno}','Q','${result.vote.dislikes }')">
							<i class="mdi mdi-arrow-down" id="dislike">${result.vote.dislikes }</i>
						</span>
					</li> --%>
				</ul>



				<%-- <div class="view-replay">
					<!-- 답변등록   -->
					<c:if test="${historyCnt > 0}">
						${historyCnt }
						<c:forEach var="his" items="${history}" varStatus="stat"> ${his.title } </c:forEach>
					</c:if>


					<div class="write-reply">
						<span class="bold">답변</span>
						<div class="de-editro">
							<input type="hidden" name="contents" id="contents" value="">
							<div class="code-html">
								<div id="editSection"></div>
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
						<div class="mT30 txt-center">
							<button type="button" class="btn-blue" id="btnAnswer">답변 등록</button>
						</div>
					</div>

					<!-- 답변 목록 -->
					<div class="txt12 mB20 mT20">총 ${result.commentcnt }개의 답변이있습니다.</div>

					<c:forEach var="list" items="${answerList}" varStatus="stat">
						<c:if test="${result.firstuserno eq userSession.userno and answerSelectedCount < 1}">
							<a href="/answers/selected/${list.answerno}" class="btn btn-primary purple">채택</a>
						</c:if>


						<ul class="qna-list">
							<li class="person">
								<img src="/img/sample_profile3.png" alt="">
								<span class="name">${list.users.username }</span> 
								<span class="reputation">${list.scores }</span> 
								<span class="voting"><img src="/img/level_gold.png" alt=""> voting</span>
							</li>
							<li class="question">
								<p>
									답변일: <fmt:formatDate value="${list.registerdate}" pattern="yyyy-MM-dd HH:mm" />
								</p> 
								${list.contents }
							</li>
							<li class="subinfo">
								<span class="up" onclick="fnLike('${list.answerno}','${list.userno}','A','${list.vote.likes }','${stat.count }')">
									<i class="mdi mdi-arrow-up" id="like${stat.count }">${list.vote.likes }</i>
								</span> 
								<span class="down" onclick="fnDisLike('${list.answerno}','${list.userno}','A','${list.vote.dislikes }','${stat.count }')">
									<i class="mdi mdi-arrow-down" id="dislike${stat.count }">${list.vote.dislikes }</i>
								</span> 
								<span> 
									<c:if test="${list.selected eq 1 }">채택된 답변</c:if> 퍼블 채택!
								</span> 
								<c:if test="${(list.users.userno eq user.userno)}">
									<span><a href="#" class="btn btn-primary purple">수정</a></span>
								</c:if> 
								<span>퍼블 수정</span></li>
						</ul>
					</c:forEach>

				</div> --%>
			</div>
		</div>
		<%-- <div class="mT30 txt-center">

			<c:if test="${((result.editauth eq 1) or (result.firstuserno eq user.userno))}">
				<button type="button" onclick="location.href='/questions/edit/${result.boardno}'" class="btn-gray">수정</button>
			</c:if>
			<c:if test="${((result.editauth eq 0) and (result.firstuserno eq user.userno) and fn:length(answerList) eq 0)}">
				<button type="button" onclick="location.href='/questions/delete/${result.boardno}'" class="btn-gray">삭제</button>
			</c:if>
			<button type="button" class="btn-gray" onclick="location.href='/questions/list'">목록</button>

		</div> --%>

	</form>
</div>






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

    function fnLike(p, su, s, l, i) {
      var like = l;
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
          if(s == 'Q'){
          	$( "#like" ).html( l );
          } else{
        	$( "#like"+i ).text( l );
          }
        }
      },
      error : function(e) {
        alert( "fail" );
      }
      } );

    }
  function fnDisLike(p, su, s, l, i) {

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
          if(s == 'Q'){
          	$( "#dislike" ).html( l );
          }else{
        	  $( "#dislike"+i ).text( l );
          }
        if (s == 'Q') {
          $( "#dislike" ).html( l );
        } else {
          $( "#dislike" + i ).text( l );
        }
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