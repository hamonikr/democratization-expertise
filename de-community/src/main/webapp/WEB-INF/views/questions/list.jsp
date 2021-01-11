<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>
<!-- tuideditor -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.48.4/codemirror.min.css" />
<link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />
<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
<script src="https://uicdn.toast.com/editor-plugin-color-syntax/latest/toastui-editor-plugin-color-syntax.js"></script>


<style>

.ellipsis {
display: -webkit-box;
width: 100%; 
height: 10%;
-webkit-line-clamp: 10;
-webkit-box-orient: vertical;
overflow: hidden; 
text-overflow: ellipsis; 

word-wrap: break-word; 
line-height: 1.2; 

pointer-events: none;
cursor: default;
text-decoration:none ;
font-size: small;
color: rgb(0,0,0);
}

</style>
<div class="content-center">
<form id="frm" name="frm" action="list" method="post">
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
<input type="hidden" name="pageNo" value="${paginationInfo.currentPageNo }" />

	<h2>질문과 답변</h2>
	<div class="section-info">
		자유롭게 사용하고 있는 개방형 OS에서 발생하는 문제에 대해 질문해 주세요.<br/> 
		답변을 통해 알고 있는 지식과 경험으로 어려움을 겪는 사람들을 도와주고 좋은 명성을 쌓으세요. <br>
	</div>

	<div class="list-left">
		<div class="pagenum">현재페이지 ${paginationInfo.currentPageNo}/${paginationInfo.totalPageCount} (총 <c:out value="${paginationInfo.totalRecordCount}" />건)</div>
		<ul class="sort-align">
			<li><button type="submit"  name="sort" class="sort" value="1">신규등록</button></li>
			<li><button type="submit" class="current" name="sort" class="sort" value="2">답변없는순</button></li>
			<li><button type="submit"  name="sort" class="sort" value="3">좋아요 많은 순</button></li>
		</ul>
<!-- 		<button type="submit" class="btn btn-outline-primary float-right" name="sort" class="sort" value="3">좋아요 많은 순</button> -->
													
	</div>

	<div class="list-right">
		<div class="board-search inblock mR10 mT10">
			<input type="text" name="searchtext" value="${vo.searchtext }" placeholder="Search">
			<button type="submit">
				<i class="mdi mdi-magnify"></i>
			</button>
		</div>
		<div class="inblock">
			<button type="button" class="btn-blue"  id="btnSave" onclick="location.href='save'">질문하기</button>
		</div>
	</div>




	<div class="con-box">
		<c:forEach var="list" items="${list}" varStatus="stat">
		<c:set var="tag" value="${fn:split(list.tagno,',')}" />
		
		<ul class="qna-list">
			<li class="person">
				<c:if test="${list.users.userprofileimg != null and list.users.userprofileimg != ''}">
					<img src="/upload/users/${list.users.userprofileimg}" width="63px" height="63px">
				</c:if>
			<%-- 	<c:if test="${(list.users.userprofileimg == null or list.users.userprofileimg == '') 
				and (list.users.picture == null or list.users.picture == '')}" >
					<img class="profileImg" width="63px" height="63px">
				</c:if> --%>
				<c:if test="${list.users.picture != null and list.users.userprofileimg == null}">
					<img alt="profile" src="${list.users.picture}" id="profileImg" class="img" width="63px" height="63px"><br/>
				</c:if>
				
				<span class="name"><a href="/users/activity/${list.users.userno}">${list.users.username}</a></span> 
				<span class="reputation">${list.scores}</span> 
				<span class="voting"><img src="../img/level_gold.png" alt="" > </span>
			</li>
			
		
			<li class="question">
				<p><fmt:formatDate value="${list.registerdate}" pattern="yyyy-MM-dd HH:mm" /></p> 
				<span class="ques-title"> <a href="view/${list.questionno }">${list.title }</a></span> 
				<span class="ques-text">
					<div id="ques-text" class="ellipsis">
<%-- 					${fn:split(list.contents, '<img')[1]} --%>
						${fn:substring(list.contents, 0, 150)}<c:if test="${fn:length(list.contents) gt 151}"> ... </c:if>
					</div> 
					<script class="code-js">
						var editor = new toastui.Editor.factory( {
		                el : document.querySelector( '#ques-text' ),
		                initialEditType : 'wysiwyg',
		                previewStyle : 'vertical',
		                height : '400px',
		                width: '200px',
		                viewer : true
		                } );
			            </script>
 				</span>												
				<span class="ques-tag">
					<c:forEach var="tagName2" items="${tag }" varStatus="status">
						<c:forEach var="tagName1" items="${tagList }" varStatus="status">
							<c:if test="${tagName1.wikino == tagName2}"><a href="/wiki/view/${tagName1.wikino }/t">${tagName1.title}</a></c:if>
						</c:forEach>
					</c:forEach>
				</span>
			</li>
			<li class="subinfo">
				<span><i class="mdi mdi-message-processing"></i> ${list.commentcnt }</span> 
				<span><i class="mdi mdi-eye-outline"></i>${list.readcnt }</span> 
				<span class="up" onclick="fnLike('${list.questionno}','${list.userno}','Q','${stat.count }','${list.vote.likes }')"><i class="mdi mdi-arrow-up" id="like${stat.count }" >${list.vote.likes }</i></span>
				<span class="down" onclick="fnDisLike('${list.questionno}','${list.userno}','Q','${stat.count }','${list.vote.dislikes }')"><i class="mdi mdi-arrow-down" id="dislike${stat.count }">${list.vote.dislikes }</i></span></li>
		</ul>
		</c:forEach>

		

	</div>

	<!-- page number -->
	<jsp:include page="/WEB-INF/views/include/paging.jsp" />
</form>
</div>
<!-- //end 중앙컨텐츠 -->


<script type="text/javascript">

/* $(function() {	
	//랜덤 이미지 생성
    var objImg=document.getElementsByClassName("profileImg");
    $.each (objImg, function (index) {
    	var imgNum=Math.round(Math.random()*8)+1;
    	objImg[index].src = "/img/profile_0"+imgNum+".png";
	});	
}); */


function linkPage(pageNo){
	location.href = "list.do?pageNo="+pageNo;
}

function fnLike(p,su,s,i,l){
	var like = l;
	console.log("like==="+like);
	$.ajax({ 
		//type: "POST", 
		contentType: "application/json", 
		url: "/vote/like", 
		data: {pno : p, section : s, userno : su , likes : 1}, 
		//dataType: 'json', 
		success: function (data) { 
			console.log(data);
			if (data == "FAIL"){
				alert("이미 투표하셨습니다.");
				/* $(".like").each(function(index, item){ 
					alert($(".like").eq(index).attr('value'));
				}) */
				}else if(data == "LOGIN"){
					alert("로그인이 필요한 기능입니다.");
					location.href = "/login";
					}else{
					alert("투표하였습니다.");
					++l;
					$("#like"+i).text(l);
				}
			}, 
			error: function (e) { 
				alert("fail"); 
			} 
			});

	}
function fnDisLike(p,su,s,i,l){

	$.ajax({ 
		//type: "POST", 
		contentType: "application/json", 
		url: "/vote/dislike", 
		data: {pno : p, section : s, userno : su , dislikes : 1}, 
		//dataType: 'json', 
		success: function (data) { 
			console.log(data);
			if (data == "FAIL"){
				alert("이미 투표하셨습니다.");
				}else if(data == "LOGIN"){
					alert("로그인이 필요한 기능입니다.");
					location.href = "/login";
					}else{
					alert("투표하였습니다.");
					++l;
					$("#dislike"+i).text(l);
					}
			}, 
			error: function (e) { 
				alert("fail"); 
			} 
			});

	}
	
</script>

