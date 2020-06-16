<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>
<!-- Brand Logo -->
<a href="/main/index" class="brand-link"> <span class="brand-text font-weight-light">STS</span> <span class="brand-text font-weight-light">
HamoniKR Services</span>
<!-- 기술지원서비스</span> -->
</a>

<!-- Sidebar -->
<div class="sidebar">

	<!-- Sidebar Menu -->
	<nav class="mt-2">
		<ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">

			<li class="nav-item">
				<div class="profile_div">
					<div class="profile_img"></div>
					<h6>
						<span>안녕하세요. </span>${UserSession.user_nm}<span>님!</span>
					</h6>
					<span>${UserSession.biznm} ${UserSession.user_dept} ${UserSession.user_rank} 
					<c:if test="${UserSession.user_role eq 'R'}">대표담당자</c:if>
					<c:if test="${UserSession.user_role eq 'S'}">담당자</c:if>
					</span><br /> <span>${UserSession.user_email}</span>
				</div>
			</li>

			<li class="nav-item">
				<a href="/sign/logout" class="nav-link"> <img src="/img/logout.png">
					<p>로그아웃</p>
				</a>
			</li>


			<li class="nav-header">공지사항</li>
			<li class="nav-item" id="nav-item-notice"><a href="/notice/list.ivs" class="nav-link"> <img class="img_normal" src="/img/notice.png"> <img class="img_over" src="/img/notice_over.png">
					<p>
						공지사항 <span class="badge badge-info right"></span>
					</p>
			</a></li>
			<li class="nav-header">회원정보관리</li>

			<c:if test="${UserSession.user_role eq 'R'}">

				<li class="nav-item" id="nav-item-signup-biz"><a href="/signup/bizEditForm.ivs" class="nav-link"> <img class="img_normal" src="/img/biz.png"> <img class="img_over" src="/img/biz_over.png">
						<p>
							기업 정보 관리 <span class="badge badge-info right"></span>
						</p>
				</a></li>

				<li class="nav-item" id="nav-item-signup-user"><a href="/signup/userEditForm.ivs" class="nav-link"> <img class="img_normal" src="/img/manager.png"> <img class="img_over" src="/img/manager_over.png">
						<p>
							담당자 정보 관리 <span class="badge badge-info right"></span>
						</p>
				</a></li>
			</c:if>

			<c:if test="${UserSession.user_role eq 'S'}">
				<li class="nav-item"><a href="/signup/subUserEditForm.ivs" class="nav-link"> <img class="img_normal" src="/img/user.png"> <img class="img_over" src="/img/user_over.png">
						<p>
							회원 정보 수정 <span class="badge badge-info right"></span>
						</p>
				</a></li>
			</c:if>


			<li class="nav-header">기술문의</li>

			<li class="nav-item" id="nav-item-inquiry"><a href="/inquiry/list.ivs" class="nav-link"> <img class="img_normal" src="/img/technology.png"> <img class="img_over" src="/img/technology_over.png">
					<p>
						기술문의 <span class="badge badge-info right"></span>
					</p>
			</a></li>


			<li class="nav-header">비즈니스</li>

			<li class="nav-item" id="nav-item-estimate"><a href="/estimate/list.ivs" class="nav-link"> <img class="img_normal" src="/img/estimate.png"> <img class="img_over" src="/img/estimate_over.png">
					<p>
						견적요청관리 
					</p>
			</a></li>

			<li class="nav-item" id="nav-item-saleplan"><a href="/saleplan/list.ivs" class="nav-link"> <img class="img_normal" src="/img/delivery.png"> <img class="img_over" src="/img/delivery_over.png">
					<p>
						판매계획관리 
					</p>
			</a></li>

			<li class="nav-item" id="nav-item-contract"><a href="/contract/list.ivs" class="nav-link"> <img class="img_normal" src="/img/contract.png"> <img class="img_over" src="/img/contract_over.png">
					<p>
						계약서 관리 
					</p>
			</a></li>

			<li class="nav-item" id="nav-item-delivery"><a href="/delivery/list.ivs" class="nav-link"> <img class="img_normal" src="/img/delivery.png"> <img class="img_over" src="/img/delivery_over.png">
					<p>
						납품 관리 
					</p>
			</a></li>

		</ul>
	</nav>
	<!-- /.sidebar-menu -->
</div>
<!-- /.sidebar -->