<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>
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
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> <input type="hidden" name="pageNo" value="${paginationInfo.currentPageNo }" />
			<div class="container-fluid">
				<div class="row">
					<div class="col-12">
						<div class="callout callout-info">
							<h5>
								<i class="fas fa-info"></i> 모든 질문들:
							</h5>



							<div class="card-header" style="border-bottom: 0px;">
								<div class="card-tools float-left col-8">
									<div class="input-group input-group col-8">
										<!--  style="width: 650px;" -->
										<input type="text" name="searchtext" class="form-control float-left" value="${vo.searchtext }" placeholder="Search">
										<div class="input-group-append">
											<button type="submit" class="btn btn-default">
												<i class="fas fa-search"></i>
											</button>
										</div>
									</div>
								</div>
								<div class="float-right">
									<button type="button" class="btn btn-primary float-right" id="btnSave" onclick="location.href='save'">등록</button>
								</div>
							</div>
						</div>

						<div class="invoice p-3 mb-3">

							<!-- Table row -->
							<div class="row">
								<div class=" table-responsive">

									<table class="table table-striped">
										<tbody>
											<tr>
												<td>
													<strong>총 <span class="total"><c:out value="${paginationInfo.totalRecordCount}" /></span>건중, 현재페이지 <i class="min">${paginationInfo.currentPageNo}</i>/<i class="max">${paginationInfo.totalPageCount}</i></strong>
													<button type="submit" class="btn btn-primary float-right" name="sort" class="sort" value="1">신규등록</button>
													<button type="submit" class="btn btn-primary float-right" name="sort" class="sort" value="2">답변없는순</button>
													<button type="submit" class="btn btn-primary float-right" name="sort" class="sort" value="3">좋아요 많은 순</button>
												</td>
											</tr>
										</tbody>
									</table>
									
									<c:forEach var="list" items="${list}" varStatus="status">
										<c:set var="tag" value="${fn:split(list.tagno,',')}" />
										<div class="info-box">
											<div class="">
												<span class="info-box-icon bg-info elevation-1" style="height: 80px;"><i class="fas fa-cog"></i></span>${list.users.username}
											</div>
											<div class="row col-12">
												<div class="col-8">
													<div class="info-box-content">
														<span class="info-box-text"><a href="view/${list.questionno }">${list.title }</a></span>
														<span class="info-box-number"> ${list.contents}<!--  <small>%</small> --></span> 
														<span class="info-box-text">
															<c:forEach var="tagName1" items="${tagList }" varStatus="status">
																<c:forEach var="tagName2" items="${tag }" varStatus="status">
																	<c:if test="${tagName1.tagno == tagName2}">${tagName1.title}</c:if>
																</c:forEach>
															</c:forEach>
														</span>
													</div>
												</div>
												<div class="col-2">
													<span class="font-weight-bold"> 
													<a href="#" onclick="fnLike('${list.questionno}','${list.userno}','Q','${status.count }','${list.vote.likes }')">
														<i class="ion ion-android-arrow-up text-success"></i> 
													</a>
													<font id="like${status.count }" value="${list.vote.likes }">${list.vote.likes }</font></span> 
													
													<br> 
													<span class="font-weight-bold">
													<a href="#" onclick="fnDisLike('${list.questionno}','${list.userno}','Q')">
														<i class="ion ion-android-arrow-down text-success"></i>
													</a> 
													<font id="dislike${status.count }" value="${list.vote.dislikes }">${list.vote.dislikes }</font>
													</span>
													<br>
													<fmt:formatDate value="${list.registerdate}" pattern="yyyy-MM-dd" />
												</div>
												<div class="col-2">
													<span class="info-box-icon bg-info elevation-1" style="height: 80px;">답변</span>
												</div>
											</div>
										</div>
									</c:forEach>


									





									
									<table class="table table-striped">
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
													<td>
														<a href="view/${list.questionno }">${list.title }</a>
													</td>
													<td>${list.contents}</td>
													<td>-</td>
													<td>
														<a href="#" onclick="fnLike('${list.questionno}','${list.userno}','Q','${status.count }','${list.vote.likes }')">like</a>
														<div id="like${status.count }" value="${list.vote.likes }">${list.vote.likes }</div>
														<a href="#" onclick="fnDisLike('${list.questionno}','${list.userno}','Q')">dislike</a>
														<div id="dislike${status.count }" value="${list.vote.dislikes }">${list.vote.dislikes }</div>
													</td>
													<td>
														<c:forEach var="tagName1" items="${tagList }" varStatus="status">
															<c:forEach var="tagName2" items="${tag }" varStatus="status">
																<c:if test="${tagName1.tagno == tagName2}">${tagName1.title}</c:if>
															</c:forEach>
														</c:forEach>
													</td>
													<td>${list.users.username}</td>
													<td>
														<fmt:formatDate value="${list.registerdate}" pattern="yyyy-MM-dd" />
													</td>
													<td>${list.readcnt}</td>
												</tr>
											</c:forEach>
											<c:if test="${empty list}">
												<!-- 게시물이 없을 경우 -->
												<tr>
													<td colspan="9">
														<p class="nodata">결과가 없습니다.</p>
													</td>
												</tr>
											</c:if>

										</tbody>
									</table>
								</div>
								<!-- /.col -->
							</div>
						</div>
					</div>
				</div>

			</div>
			<!-- page number -->
			<jsp:include page="/WEB-INF/views/include/paging.jsp" />
		</form>
	</section>


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
						alert("로그인이 필요한 기능입니다.");
						location.href = "/login";
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
