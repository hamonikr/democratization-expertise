<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<style>
.ui-autocomplete {
    max-height: 200px;
    overflow-y: auto;
    /* prevent horizontal scrollbar */
    overflow-x: hidden;
    /* add padding to account for vertical scrollbar */
    padding-right: 20px;
}
/* IE 6 doesn't support max-height
 * we use height instead, but this forces the menu to always be this tall
 */
* html .ui-autocomplete {
    height: 200px;
}
.ui-menu-item .ui-menu-item-wrapper:hover
{
    border: none !important;
    background-color: #7878FF;
}
</style>
<script type="text/javascript" src="/js/jquery-ui.min.js"></script>
<script type="text/javascript">
 $(function() {	
	
		var availableTags = new Array();
		$("#searchtxt").on("propertychange change keyup paste input", function() {
			var searchtxt = $(this).val();
			if(searchtxt.length > 1){
	    		$.ajax({ 
	    			//type: "POST", 
	    			//contentType: "application/json", 
	    			url: "/search/auto",
	    			data:{searchtxt:searchtxt},
	    			//dataType: 'json', 
	    			success: function (data) { 
	    				$.each (data.list, function (index, el) {
	    					availableTags[index] = {value:el.title};
	    					console.log(availableTags[index]);
	    					});
	    				}, 
	    				error: function (e) { 
	    					alert("fail"); 
	    				} 
	    				});
	    		}
		});
			
		    $( "#searchtxt" ).autocomplete({
		      delay: 0,	
		      minLength: 2,
		      source: availableTags,
		      focus: function( event, ui ) {
		        $( "#searchtxt" ).val( ui.item.value );
		        return false;
		      },
		      select: function( event, ui ) {
		        $( "#searchtxt" ).val( ui.item.value );
		        //$( "#searchtxt" ).val( ui.item.key );
		 
		        return false;
		      } 
			  });
	});
 </script>
<header class="topbar">
	<nav class="navbar top-navbar navbar-expand-md">

		<div class="navbar-header">
			<a class="nav-toggler d-block d-md-none" href="#"> <i class="mdi mdi-menu"></i></a>
			<!-- mobile menu -->
			<h1>
				<a class="navbar-brand" href="/"><img src="/img/logo.png" alt="" /></a>
			</h1>
			<!-- mobile user toggle -->
			<a class="topbartoggler d-block d-md-none" href="#" data-toggle="collapse" data-target="#user"> <i class="mdi mdi-dots-vertical"></i>
			</a>
		</div>

		<div class="top-search">
		<form name="sfrm" action="/search/list" method="post">
			<input type="text" name="searchtxt" id="searchtxt" placeholder="Search" value="${searchtxt }"/>
			<%-- <input type="hidden" id="searchtxt" name="searchtxt" value="${searchtxt }"/> --%>
			<button type="submit">
				<i class="mdi mdi-magnify"></i>
			</button>
		</form>
		</div>

		<div class="navbar-collapse collapse f-right" id="user">
			<div class="navbar-nav f-left mr-auto"></div>
			<ul class="navbar-nav  userinfo">
				<li class="profile">
					<span class="photo"><img src="/img/sample_profile.png" alt="" /></span> 
					<span class="alarm">알람</span> 
					<span class="level"><img src="/img/level_gold.png" alt="" /></span>
					<a href="/users/activity/${userSession.userno}">${userSession.username }</a></li>

				<li><a href="#">Help</a></li>

				<li>
					<sec:authorize access="hasRole('ROLE_USER') || hasRole('ROLE_ADMIN')">
						<a href="javascript:;" style="margin-left:10px; width:100px;color: wheat;" onClick="location.href='/login/logout'">Sign out </a>
					</sec:authorize>
					<sec:authorize access="!(hasRole('ROLE_USER') || hasRole('ROLE_ADMIN'))">
						<a href="/login" style="margin-left:10px; width:100px;color: wheat;">Sign in</a>
						<a href="/signup/signup" style="margin-left:10px; width:100px;color: wheat;">Sign up</a>	
					</sec:authorize>
				</li>
			</ul>
		</div>

	</nav>
</header>
