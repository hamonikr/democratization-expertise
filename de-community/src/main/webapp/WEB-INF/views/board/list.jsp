<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>

<div class="content-center">
<form id="frm" name="frm" action="list" method="post">
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
<input type="hidden" name="pageNo" value="${paginationInfo.currentPageNo }" />

	<h2>${boardinfo.boardname }</h2>
	<div class="section-info">
		개방형 os를 다운로드 해보세요<br/> 향상된 퍼포먼스를 느낄 수 있습니다.<br>
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
			<li class="person">
				<img src="/img/noprofile.png"  width="63px" height="63px">
				
				<span class="name">${list.userid}</span> 
			</li>
			
		
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

