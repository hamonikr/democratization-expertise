<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>
<head>
<style type="text/css">
.profileImg img{ width: 100% }
</style>
</head>

<body>
<form id="frm" name="frm" action="" method="post">
<div class="row" id="content">
	<div class="col-12">
		<div class="card">

			<!-- /.card-header -->
			<div class="card-header">
				<h3 class="card-title">유저 보드</h3>
				<p>활동적인 유저의 공헌 목록은 다음과 같습니다. 커뮤니티에 지식을 제공하여 더 많은 사람들이 성장할 수 있도록합니다.</p>

				<div class="card-tools">
					<div class="input-group input-group-sm" style="width: 150px;">
						<input type="text" name="table_search" class="form-control float-right" placeholder="Search">
						<div class="input-group-append">
							<button type="submit" class="btn btn-default"><i class="fas fa-search"></i></button>
						</div>
					</div>

					<!-- <a href="javascript:alert('준비중');" class="btn btn-primary purple">평판</a> -->
					<a href="/users/list?sort=registerdate,DESC" class="btn btn-primary purple">사용자</a>
					<!-- <a href="javascript:alert('준비중');" class="btn btn-primary purple">좋아요</a> -->
				</div>
			</div>

			<div class="card-body table-responsive p-0">
				<div class="row">
					<c:forEach var="list" items="${data}" varStatus="status">
						<div class="col-3">
							<a class="profileImg" href="/users/dashboard/${list.userno}">
								<c:if test="${list.userprofileimg != null}">
									<img alt="userProfileImg_${list.username}" src="/upload/${list.userprofileimg}">
								</c:if>
								<c:if test="${list.userprofileimg == null}">
									<img alt="userProfileImg_${list.username}" src="/img/user_over.png">
								</c:if>
							</a>
							<a href="/users/dashboard/${list.userno}">${list.username}</a>
						</div>
					</c:forEach>

					<!-- 게시물이 없을 경우 -->
					<c:if test="${empty data}">
						<div class="col-12">
							<p class="nodata">결과가 없습니다.</p>
						</div>
					</c:if>
				</div>

			</div>
			<!-- /.card-body -->

			<div class="card-footer row">
				<!-- page number -->
				<c:if test="${not paging.first}">
					<a href="/users/list?page=${paging.number}">이전</a><
				</c:if>
				<c:forEach begin="1" end="${paging.totalPages}" var="idx">
					<a href="/users/list?page=${idx}">${idx}</a>
				</c:forEach>
				<c:if test="${not paging.last && paging.totalPages > 0}">
					<a href="/users/list?page=${paging.number + 2}">다음</a>
				</c:if>
			</div>
  
		</div>
		<!-- /.card -->
	</div>
  
</div>
</form>
</body>

<script type="text/javascript">
function linkPage(pageNo){
	location.href = "list.ivs?pageNo="+pageNo;
}
</script>