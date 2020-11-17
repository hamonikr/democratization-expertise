<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>

<script type="text/javascript">

function onRightLayerData(searchtxt){
  var searchtxt = $("#searchtxt").val();
	$.ajax({ 
		//type: "POST", 
		//contentType: "application/json", 
		url: "/cmmn/list",
// 		data:{searchtxt:searchtxt},
		async : false,
		//dataType: 'json', 
		success: function (data) { 
			
			if (data != null){
				
				$.each (data.user, function (index, el) {
					var userHtml = "";
// 				  <li><a href="#"> <img src="../img/sample_profile3.png" alt=""> Company <span>(89)</span></a></li>	
					userHtml += '<li><a href="/users/activity/'+el.userno+'">';			 
					if(el.userprofileimg != null && el.picture == null)
						userHtml += "<img src='/upload/users/"+el.userprofileimg+"' alt='' width='25px' height='25px'>";
					else if(el.userprofileimg == null && el.picture != null)
						userHtml += "<img src='"+el.picture+"' alt='' width='25px' height='25px'>";
					else
						userHtml += "<img src='/img/noprofile.png' alt='' width='25px' height='25px'>";
					
					userHtml += el.username+'<span>('+el.score+')</span></a></li>';
					$("#userrightLayer").append(userHtml);
				});
				//console.log(userHtml);
				
				
				$.each (data.tag, function (index, el) {
					var tagHtml = "";
					  
						tagHtml += '<li><a href="/wiki/view/'+el.wikino+'">'+el.title+'</li>';			 
						$("#tagrightLayer").append(tagHtml);
					});
				$.each (data.board, function (index, el) {
					var boardHtml = "";
					  
					boardHtml += '<li><a href="/board/'+el.boardid+'/list">'+el.boardname+'</li>';			 
						$("#menu").append(boardHtml);
					});
				
// 				$("#bodyrightLayer").append("<br/>");
				
// 				 for(y=0;y<data.partnerslist.length;y++){
// 					 var str = data.partnerslist[y].enterpriseabout;		
// 					var entHtml = "";
// 					entHtml += '<div class="col-md-9 col-sm-6 col-12" >';
// 					entHtml += '<div class="info-box ">'; 
// 					entHtml += '<span class="info-box-icon col-1"><i class="far fa-bookmark"></i></span>';
// 					entHtml += '<div class="info-box-content">';
// 					entHtml += '<span class="info-box-text ">'+data.partnerslist[y].enterprisename+'</span>';
// 					entHtml += '<div class="progress"><div class="progress-bar" style="width: 70%"></div></div>';
// 					entHtml += '<span class="progress-description">';
// 					entHtml += str.link("/enterprises/activity/"+data.partnerslist[y].enterpriseno);
// 					entHtml += '</span>';
// 					entHtml += '</div>';
// 					entHtml += '</div>';
// 					entHtml += '</div>';
// 					$("#bodyrightLayer").append(entHtml);
          		
// 				} 
				}
			}, 
			error: function (e) { 
				alert("fail"); 
			} 
			});
	
}
/* 
$(function() {
	 var searchtxt = $("#searchtxt").val();
	$.ajax({ 
		//type: "POST", 
		//contentType: "application/json", 
		url: "/cmmn/list",
		data:{searchtxt:searchtxt},
		async : false,
		//dataType: 'json', 
		success: function (data) { 
			
			if (data != null){
				
				$.each (data.user, function (index, el) {
					var userHtml = "";
// 				  <li><a href="#"> <img src="../img/sample_profile3.png" alt=""> Company <span>(89)</span></a></li>	
					userHtml += '<li><a href="/users/activity/'+el.userno+'">';			 
					if(el.userprofileimg != null && el.picture == null)
						userHtml += "<img src='/upload/users/"+el.userprofileimg+"' alt='' width='25px' height='25px'>";
					else if(el.userprofileimg == null && el.picture != null)
						userHtml += "<img src='"+el.picture+"' alt='' width='25px' height='25px'>";
					else
						userHtml += "<img src='/img/noprofile.png' alt='' width='25px' height='25px'>";
					
					userHtml += el.username+'<span>('+el.score+')</span></a></li>';
					$("#userrightLayer").append(userHtml);
				});
				//console.log(userHtml);
				
				
				$.each (data.tag, function (index, el) {
					var tagHtml = "";
					  
						tagHtml += '<li><a href="/wiki/view/'+el.wikino+'">'+el.title+'</li>';			 
						$("#tagrightLayer").append(tagHtml);
					});
				$.each (data.board, function (index, el) {
					var boardHtml = "";
					  
					boardHtml += '<li><a href="/board/'+el.boardid+'/list">'+el.boardname+'</li>';			 
						$("#menu").append(boardHtml);
					});
				
// 				$("#bodyrightLayer").append("<br/>");
				
// 				 for(y=0;y<data.partnerslist.length;y++){
// 					 var str = data.partnerslist[y].enterpriseabout;		
// 					var entHtml = "";
// 					entHtml += '<div class="col-md-9 col-sm-6 col-12" >';
// 					entHtml += '<div class="info-box ">'; 
// 					entHtml += '<span class="info-box-icon col-1"><i class="far fa-bookmark"></i></span>';
// 					entHtml += '<div class="info-box-content">';
// 					entHtml += '<span class="info-box-text ">'+data.partnerslist[y].enterprisename+'</span>';
// 					entHtml += '<div class="progress"><div class="progress-bar" style="width: 70%"></div></div>';
// 					entHtml += '<span class="progress-description">';
// 					entHtml += str.link("/enterprises/activity/"+data.partnerslist[y].enterpriseno);
// 					entHtml += '</span>';
// 					entHtml += '</div>';
// 					entHtml += '</div>';
// 					entHtml += '</div>';
// 					$("#bodyrightLayer").append(entHtml);
          		
// 				} 
				}
			}, 
			error: function (e) { 
				alert("fail"); 
			} 
			});
}); 
*/
  function numberWithCommas(x) {
    return x.toString().replace( /\B(?=(\d{3})+(?!\d))/g, "," );
  }
</script>

<div class="content-right">

	<div class="right-title">Tages</div>
	<ul class="right-tags" id="tagrightLayer"></ul>

	<div class="right-title">활동순위</div>
	<div class="ranking">
		<div class="user-list">
			<div class="user-title">유저</div>
			<ul class="user" id="userrightLayer">
				
			</ul>
		</div>
		<!-- //end user-list -->

		<div class="part-list">
			<div class="user-title">파트너사</div>
			<ul class="user">

				<li><a href="#"> <img src="/img/sample_profile3.png" alt=""> Company <span>(89)</span>
				</a></li>
			</ul>
		</div>
		<!-- //end user-list -->
	</div>
	<!-- // ranking -->


	<div class="partner-banner">
		<div class="slide-banner">
			<img src="/img/sample_part1.png" alt="">
		</div>
		<ul class="list-banner">
			<li><img src="/img/sample_part2.png" alt=""></li>
			<li><img src="/img/sample_part3.png" alt=""></li>
		</ul>
	</div>


</div>