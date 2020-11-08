<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>

<div class="content-center">
<form id="frm" name="frm" action="list" method="post">
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
<input type="hidden" name="pageNo" value="${paginationInfo.currentPageNo }" />

	<h2>${boardinfo.boardname }</h2>
	<div class="section-info">
		각 메뉴 섹션 상단에 카피문구 넣어주세요. 2~3줄 나올수 있으면 예뻐요.<br> 문구가 나옵니다. 개발시 당신이 겪는 어려움에 대해 자유롭게 질문을 하고 답변을 받으세요. 그리고 그 지식을 커뮤니티의 회원들과 함께 공유해주세요. 모바일버전에서는 display:none.<br>
	</div>


	<div class="list-left">
		<div class="pagenum">현재페이지 ${paginationInfo.currentPageNo}/${paginationInfo.totalPageCount} (총 <c:out value="${paginationInfo.totalRecordCount}" />건)</div>									
	</div>

	<div class="list-right">
		<!-- <div class="board-search inblock mR10 mT10">
			<button type="button">
				<i class="mdi mdi-magnify"></i>
			</button>
		</div> -->
		<div class="inblock">
		<c:if test="${boardinfo.writeauth eq 'user' }">
			<button type="button" class="btn-blue"  id="btnSave" onclick="location.href='save'">등록하기</button>
			</c:if>
		</div>
	</div>




	<div class="con-box">
		<c:forEach var="list" items="${list}" varStatus="stat">
		
		<ul class="qna-list">
			<%-- <li class="person">
				<c:if test="${list.users.userprofileimg != null}">
					<img src="/upload/users/${list.users.userprofileimg}" width="63px" height="63px">
				</c:if>
				<c:if test="${list.users.userprofileimg == null and list.users.picture == null}" >
					<img src="/img/noprofile.png"  width="63px" height="63px">
				</c:if>
				<c:if test="${list.users.picture != null and list.users.userprofileimg == null}">
					<img alt="profile" src="${list.users.picture}" id="profileImg" class="img" width="63px" height="63px"><br/>
				</c:if>
				
				<span class="name"><a href="/users/activity/${list.users.userno}">${list.users.username}</a></span> 
				개발<br>
				<span class="reputation"></span> 
				<span class="voting"><img src="../img/level_gold.png" alt="" > 25</span>
			</li> --%>
			
		
			<li class="question">
				<p><fmt:formatDate value="${list.registerdate}" pattern="yyyy-MM-dd HH:mm" /></p> 
				<span class="ques-title"> <a href="view/${list.boardno }">${list.title }</a></span> 
				${fn:substring(list.contents, 0, 50)}<c:if test="${fn:length(list.contents) > 49}"> ... </c:if>
														
				<%-- <span class="ques-tag">
					<c:forEach var="tagName2" items="${tag }" varStatus="status">
						<c:forEach var="tagName1" items="${tagList }" varStatus="status">
							<c:if test="${tagName1.wikino == tagName2}"><a href="/wiki/view/${tagName1.wikino }">${tagName1.title}</a></c:if>
						</c:forEach>
					</c:forEach>
				</span> --%>
			</li>
			<li class="subinfo">
				<%-- <span><i class="mdi mdi-message-processing"></i> ${list.commentcnt }</span>  --%>
				<%-- <span><i class="mdi mdi-eye-outline"></i>${list.readcnt }</span>  --%>
				<%-- <span class="up" onclick="fnLike('${list.questionno}','${list.userno}','Q','${stat.count }','${list.vote.likes }')"><i class="mdi mdi-arrow-up" id="like${stat.count }" >${list.vote.likes }</i></span>
				<span class="down" onclick="fnDisLike('${list.questionno}','${list.userno}','Q','${stat.count }','${list.vote.dislikes }')"><i class="mdi mdi-arrow-down" id="dislike${stat.count }">${list.vote.dislikes }</i></span> --%></li>
		</ul>
		</c:forEach>

		

	</div>

	<!-- page number -->
	<jsp:include page="/WEB-INF/views/include/paging.jsp" />
</form>
</div>
<!-- //end 중앙컨텐츠 -->


<script type="text/javascript">


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

