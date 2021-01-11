<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>
<style>
.ui-autocomplete {
    max-height: 200px;
    overflow-y: auto;
    overflow-x: hidden;
    padding-right: 20px;
    width: 500px; 
    background: #fff;
    border-radius: 0 0 6px 6px;
    padding: 20px;
    border: 1px solid #e5ecf2;
    box-shadow: 0 2px 3px 0 rgba(0,1,3,.07);
}
.ui-autocomplete > li:hover {
width: 500px; 
    cursor: pointer;
    box-sizing: border-box;
    background: #f2f2f2;
    border:1px solid #ccc;
    white-space: nowrap;
    &:nth-child(even) {
       background: #eee;
    }
    &:hover {
       opacity: 0.25
    }
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
/*     background-color: #7878FF; */
    background-color: #FFFFFF;
}
</style>
<script type="text/javascript" src="/js/jquery-ui.min.js"></script>
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
		<form id="sfrm" name="sfrm" action="/search/list" method="get">
		<div class="form-group"><input type="text" name="searchtxt" id="searchtxt" placeholder="Search" value="${searchtxt }" autocomplete="off"/></div>
			<button type="submit">
				<i class="mdi mdi-magnify"></i>
			</button>
		</form>
		</div>

		<div class="navbar-collapse collapse f-right" id="user">
			<div class="navbar-nav f-left mr-auto"></div>
			<ul class="navbar-nav  userinfo">
				<li class="profile">
				<c:if test="${not empty userSession}">
<%-- 					<c:if test="${userSession.userprofileimg ne null}"> --%>
<%-- 						<span class="photo"><img src="/upload/users/${userSession.userprofileimg}" alt="" /></span>  --%>
<%-- 					</c:if> --%>
<%-- 					<c:if test="${userSession.userprofileimg eq null and userSession.picture eq null}" > --%>
<!-- 						<span class="photo"><img src="/img/sample_profile.png" alt="" /></span>  -->
<%-- 					</c:if> --%>
<%-- 					<c:if test="${userSession.picture ne null and userSession.userprofileimg eq null}"> --%>
<%-- 						<span class="photo"><img src="${userSession.picture}" alt="" /></span>  --%>
<%-- 					</c:if> --%>
					
					<c:if test="${ userSession.userprofileimg != null}">
						<img alt="photo" src="/upload/users/${userSession.userprofileimg}" id="profileImg" class="img" width="25px" height="25px">
					</c:if>
					<%-- <c:if test="${userSession.userprofileimg == null and userSession.picture == null}">
						<img alt="photo" src="/img/user_over.png" id="profileImg" class="img" width="25px" height="25px">
					</c:if> --%>
					<c:if test="${userSession.picture != null}">
						<img alt="photo" src="${userSession.picture}" id="profileImg" class="img" width="25px" height="25px">
					</c:if>
				</c:if>
<!-- 					<span class="alarm">알람</span>  -->
<!-- 					<span class="level"><img src="/img/level_gold.png" alt="" /></span> -->
					<c:choose>
						<c:when test="${userSession.representat == 1}">
							<a href="/enterprises/activity/${userSession.enterpriseno}">${userSession.enterprisename }</a>
						</c:when>
						<c:otherwise>
							<a href="/users/activity/${userSession.userno}">${userSession.username }</a>
						</c:otherwise>
					</c:choose>
					
				<li><a href="/wiki/Help/h">Help</a></li>

				<li>
				<c:choose>				
				<c:when test="${empty userSession}">
					<a href="/login" style="margin-left:10px; width:100px;color: wheat;">Sign in</a>
					<a href="/signup/signup" style="margin-left:10px; width:100px;color: wheat;">Sign up</a>	
				</c:when>
				<c:otherwise>
					<a href="javascript:;" style="margin-left:10px; width:100px;color: wheat;" onClick="location.href='/login/logout'">Sign out </a>	
				</c:otherwise>
				</c:choose>
				<%-- 	<sec:authorize access="hasRole('ROLE_USER') || hasRole('ROLE_ADMIN')">
						<a href="javascript:;" style="margin-left:10px; width:100px;color: wheat;" onClick="location.href='/login/logout'">Sign out </a>
					</sec:authorize>
					<sec:authorize access="!(hasRole('ROLE_USER') || !hasRole('ROLE_ADMIN'))">
						<a href="/login" style="margin-left:10px; width:100px;color: wheat;">Sign in</a>
						<a href="/signup/signup" style="margin-left:10px; width:100px;color: wheat;">Sign up</a>	
					</sec:authorize> --%>
				</li>
			</ul>
		</div>

	</nav>
	<script type="text/javascript">
 $(function() {	
	
		var availableTags = new Array();
		$("#searchtxt").on("propertychange change keyup paste input", function() {
			var searchtxt = $(this).val();
			if((searchtxt.length % 2) == 0){
	    		$.ajax({ 
	    			//type: "POST", 
	    			//contentType: "application/json", 
	    			url: "/search/auto",
	    			data:{searchtxt:searchtxt},
	    			async:false,
	    			//dataType: 'json', 
	    			success: function (data) { 
	    			  $("#searchtxt").val(data.searchtxt);
	    				$.each (data.list, function (index, el) {
	    					availableTags[index] = {value:el.title};
	    					});
	    				}, 
	    				error: function (e) { 
	    					alert("fail"); 
	    				} 
	    				});
	    		}
		});
			
	    $( "#searchtxt" ).autocomplete({
		      delay: 2,	
		      minLength: 2,
		      source: availableTags,
		      focus: function( event, ui ) {
		        $( "#searchtxt" ).val( ui.item.value );
		        return false;
		      },
		      select: function( event, ui ) {
		        $( "#searchtxt" ).val(ui.item.value );
		        //$( "#searchtxt" ).val( ui.item.key );
		 
		        return false;
		      } 
		  });

	  //공백체크
	    $.validator.addMethod("trimCheck",  function( value, element ) {
			   return this.optional(element) ||  $.trim(value);
			});
	    
	    $.validator.setDefaults( {
	      submitHandler : function() {
	        document.sfrm.submit();
	      }
	    } );
	    $( '#sfrm' ).validate( {
	    rules : {
	    searchtxt : {
	      required : true,
	      trimCheck: true
	    }
	    },
	    messages : {
	    searchtxt : {
	      required : "검색어를 입력해주세요.",
	      trimCheck : "공백만 입력 할 수 없습니다."
	    }
	    },
	    errorElement : 'span',
	    errorPlacement : function(error, element) {
	      error.addClass( 'invalid-feedback' );
	      element.closest( '.form-group' ).append( error );
	    },
	    highlight : function(element, errorClass, validClass) {
	      $( element ).addClass( 'is-invalid' );
	    },
	    unhighlight : function(element, errorClass, validClass) {
	      $( element ).removeClass( 'is-invalid' );
	    }
	    });
	});
 
 
 </script>
</header>
