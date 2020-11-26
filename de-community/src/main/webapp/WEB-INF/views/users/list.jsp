<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>


<style>
.buttonStyle {
  border: 0;
  border-radius: 0.25rem;
  background: #1E88E5;
  color: white;
  font-size: 1rem;
  line-height: 1.2;
  white-space: nowrap;
  text-decoration: none;
  padding: 0.25rem 0.5rem;
  margin: 0.25rem;
  cursor: pointer;
}
button[type=submit] {
    width: 4em;  height: 2em;
    cursor:pointer;
    background-color: Transparent;
    background-repeat:no-repeat;
    border: none;
}
</style>

<div class="content-center">
	<h2>커뮤니티 사람들</h2>
	<div class="section-info">
		커뮤니티에 활동하는 유저의 목록은 다음과 같습니다.
	</div>


	<form id="frm" name="frm" method="post" action="/users/list">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> <input type="hidden" name="page" value="${paginationInfo.currentPageNo }" />

		<div class="list-left">
			<div class="pagenum">현재페이지 1/10 (총 50건)</div>
			<ul class="sort-align">
				<li><button type="submit" name="sort" class="" value="1">평판순</button></li>
				<li><button type="submit" class="" name="sort" class="sort" value="2">투표많은순</li>
			</ul>

		</div>
		<div class="list-right">
			<div class="board-search inblock mR10 mT10">
				<input type="text" name="searchtext" value="${vo.searchtext }" placeholder="Search">
				<button type="submit">
					<i class="mdi mdi-magnify"></i>
				</button>
			</div>
		</div>

		<div class="con-box">
			<ul class="company-user">
			<c:forEach var="list" items="${data}" varStatus="status">
				<li>
                  <a href="/users/activity/${list.userno}">
                  <c:if test="${list.userprofileimg != null and list.userprofileimg != ''}">
						<img src="/upload/users/${list.userprofileimg}">
					</c:if> 
					<c:if test="${list.userprofileimg == null and list.picture == null}">
						<img class="profileImg">
					</c:if>
					<c:if test="${list.userprofileimg == null and list.picture != null}">
						<img src="${list.picture}">
					</c:if>
                  </a>
                  <span class="name"><a href="/users/activity/${list.userno}"> ${list.username}</a></span>
                  <span class="reputation">${list.score.score }</span>
                </li>
			</c:forEach>
			</ul>
			
			<!-- 게시물이 없을 경우 -->
			<c:if test="${empty data}">
				<div class="col-12">
					<p class="nodata">사용자 데이터가 없습니다.</p>
				</div>
			</c:if>
		</div>

		<!-- page number -->
		<jsp:include page="/WEB-INF/views/include/paging.jsp" />
		
	</form>
</div>





<script type="text/javascript">
$(function() {	
	//랜덤 이미지 생성
    var objImg=document.getElementsByClassName("profileImg");
    $.each (objImg, function (index) {
    	var imgNum=Math.round(Math.random()*8)+1;
    	objImg[index].src = "/img/profile_0"+imgNum+".png";
	});	
});
function linkPage(pageNo){
	location.href = "users/list?page="+pageNo;
}
</script>