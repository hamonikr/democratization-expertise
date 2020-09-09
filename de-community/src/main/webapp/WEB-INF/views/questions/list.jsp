<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>
<body>
<form id="frm" name="frm" method="post">
<!-- 스프링 시큐리티 form에 추가 해줘야함. -->
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
<input type="hidden" name="pageNo" value="${paginationInfo.currentPageNo }" />
<div class="row" id="content">
          <div class="col-12">
            <div class="card">
              <div class="card-header">
                <h3 class="card-title">모든 질문들</h3>
                <div class="card-tools">
                  <div class="input-group input-group-sm" style="width: 150px;">
                    <input type="text" name="searchtext" class="form-control float-right" value="${vo.searchtext }" placeholder="Search">
                    <div class="input-group-append">
                      <button type="submit" class="btn btn-default"><i class="fas fa-search"></i></button>
                    </div>
                  </div>
                </div>
              </div>
              <p><strong>총 <span class="total"><c:out value="${paginationInfo.totalRecordCount}"/></span>건중, 현재페이지 <i class="min">${paginationInfo.currentPageNo}</i>/<i class="max">${paginationInfo.totalPageCount}</i></strong></p>
              <!-- /.card-header -->
              <button type="submit" name="sort" class="sort" value="1">신규등록</button>
              <button type="submit" name="sort" class="sort" value="2">답변없는순</button>
              <button type="submit" name="sort" class="sort" value="3">좋아요 많은 순</button>
              <div class="card-body table-responsive p-0">
                <table class="table table-hover text-nowrap" id="example2">
                  <thead>
                    <tr>
                      <th>번호</th>
                      <th>제목</th>
                      <th>내용</th>
                      <th>답변</th>
                      <th>투표</th>
                      <th>태그</th>
                      <th>성명</th>
                      <th>등록일</th>
                      <th>조회수</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:forEach var="list" items="${list}" varStatus="status">
						    <c:set var="tag" value="${fn:split(list.tagno,',')}" />
						    <tr>
						      <th scope="row">${paginationInfo.totalRecordCount - ((paginationInfo.currentPageNo-1) * paginationInfo.recordCountPerPage + status.index) }</th>
						      <td><a href="view/${list.questionno }">${list.title }</a></td>
						      <td>${list.contents}</td>
						      <td>-</td>
						      <td><a href="#" onclick="fnLike('${list.questionno}','${list.userno}','Q','${status.count }','${list.vote.likes }')">like</a><div id="like${status.count }" value="${list.vote.likes }">${list.vote.likes }</div>
						      <a href="#" onclick="fnDisLike('${list.questionno}','${list.userno}','Q')">dislike</a><div id="dislike${status.count }" value="${list.vote.dislikes }">${list.vote.dislikes }</div></td>
						      <td>
						      <c:forEach var="tagName1" items="${tagList }" varStatus="status">
						      <c:forEach var="tagName2" items="${tag }" varStatus="status">
						      <c:if test="${tagName1.tagno == tagName2}">${tagName1.title}</c:if>
						      </c:forEach> 
						      </c:forEach>
						      </td>
						      <td>${list.users.username}</td>
						      <td><fmt:formatDate value="${list.registerdate}" pattern="yyyy-MM-dd" /></td>
						      <td>${list.readcnt}</td>
						    </tr>
						</c:forEach>
						<c:if test="${empty list}"> <!-- 게시물이 없을 경우 -->
					<tr>
						<td colspan="5"><p class="nodata">결과가 없습니다.</p></td>
					</tr>
					</c:if>
                  </tbody>
                </table>
              </div>
              <!-- /.card-body -->
            </div>
            <!-- page number -->
                    <ui:pagination paginationInfo = "${paginationInfo}" type="text" jsFunction="linkPage"/>
            <!-- /.card -->
          </div>
        </div>
        <div class="right mT20">
                        <button type="button" class="btn_type2" id="btnSave" onclick="location.href='save'">등록</button>
                    </div>
	</form>
</body>

<script type="text/javascript">

$(function() {
	//저장 버튼
    //$(".sort").on("click",fnSort);	
    //$("#btnUpdate").on("click",fnUpdate);	
});

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
						alert("로그인 후 투표해주세요.");
						location.href = "/";
						}else{
						alert("투표하였습니다.");
						++l;
						$("#like"+i).html(l);
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
					}else{
						alert("투표하였습니다.");
						++l;
						$("#dislike"+i).html(l);
						}
				}, 
				error: function (e) { 
					alert("fail"); 
				} 
				});

		}
		
</script>
	