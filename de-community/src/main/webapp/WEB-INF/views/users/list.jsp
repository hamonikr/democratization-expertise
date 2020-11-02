<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>



<!-- <head> -->
<!-- <style type="text/css"> 
 .profileImg img{ width: 100% }--> 
<!-- </style> -->
<!-- </head> -->


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
			 <input type="hidden" name="page" value="${paginationInfo.currentPageNo }" />
			<div class="container-fluid">
				<div class="row">
					<div class="col-12">
						<div class="callout callout-info">
							<h5>Users</h5>
							<div class="card-header" style="border-bottom: 0px;">
								<p>활동적인 유저의 공헌 목록은 다음과 같습니다. 커뮤니티에 지식을 제공하여 더 많은 사람들이 성장할 수 있도록합니다</p>
							</div>
						</div>


						<div class="invoice p-3 mb-3" style="border-left: 5px solid #117a8b;">
							<table class="table table-striped">
								<tbody>
									<tr>
										<td>
											
											<div class="input-group">
												<input type="text" name="searchtext" class="form-control float-left" value="${vo.searchtext }" placeholder="Search">
												<div class="input-group-append">
													<button type="submit" class="btn btn-default">
														<i class="fas fa-search"></i>
													</button>
												</div>
											</div>
										</td>
										<td>
											<button type="submit" class="btn btn-outline-primary float-right" name="sort" class="sort" value="1">평판순</button>
											<button type="submit" class="btn btn-outline-primary float-right" name="sort" class="sort" value="2">투표많은순</button>
											
											<!-- <a href="javascript:alert('준비중');" class="btn btn-primary purple">평판</a> -->
<!-- 											<a href="/users/list?sort=registerdate: DESC" class="btn btn-primary purple">사용자</a> -->
											<!-- <a href="javascript:alert('준비중');" class="btn btn-primary purple">좋아요</a> -->
											
										</td>
									</tr>
								</tbody>
							</table>
									
									
							<div class="row">		
					        	
					        	<c:forEach var="list" items="${data}" varStatus="status">
						        	<div class="col-md-3 col-sm-6 col-xs-12">
						         		<div class="info-box" onclick="javascript:location.href='/users/activity/${list.userno}'" style="cursor: pointer;">
						            		<span class="info-box-icon bg-aqua">
						            			<c:if test="${list.userprofileimg != null}">
													<img src="/upload/users/${list.userprofileimg}">
												</c:if>
												<c:if test="${list.userprofileimg == null}">
													<img src="/img/noprofile.png">
												</c:if>
											</span>
						            		<div class="info-box-content">
						              		<span class="info-box-text">${list.username}</span>
						              		<span class="info-box-number">${list.userno }</span>
						            		</div>
						          	</div>
						        	</div>
								</c:forEach>
								<!-- 게시물이 없을 경우 -->
								<c:if test="${empty data}">
									<div class="col-12">
										<p class="nodata">사용자 데이터가 없습니다.</p>
									</div>
								</c:if>
				        	</div>
				        	
							
        
						</div>
					</div>
				</div>

			</div>
			<!-- page number -->
			<jsp:include page="/WEB-INF/views/include/paging_jpa.jsp" />
		</form>
	</section>
	


<script type="text/javascript">
function linkPage(pageNo){
	location.href = "users/list?page="+pageNo;
}
</script>