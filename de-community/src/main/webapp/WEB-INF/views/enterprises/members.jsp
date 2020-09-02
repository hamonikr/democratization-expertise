<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>
<head>
<style type="text/css">
.dash-list { height: 25px }
.dash-list > a { margin-left: 8px }
.dash-list .tagSpan { 
	margin-left: 0;
	margin-right: 5px;
	margin-bottom: 5px; 
}

.enterprise-list-card { border: 1px solid #ddd }
.enterprise-list-card p { margin: 0 }
.enterprise-list-card .title { font-weight: bold }
.enterprise-list-card .position {  }
.enterprise-list-card .reputation {  }
</style>
</head>

<body>
	<form id="frm" name="frm" method="post">
	
		<div class="row">
			<!-- Content Header (Page header) -->
			<div class="col-12">
				<a href="/enterprises/dashboard/${enterpriseno}" class="btn btn-primary">활동정보</a>
				<a href="/enterprises/view/${enterpriseno}" class="btn btn-primary">프로필</a>
				<a href="/enterprises/member/${enterpriseno}" class="btn btn-primary">사람들</a>
			</div>
			
			<div class="col-12">
				<div class="card card-primary" style="width: 100%;">

${ users }
					<div class="card-body card-primary row" style="width: 100%;">
						
						<div class="col-12">
							<div>활동중인 사람들</div>
							<hr/>
							<div class="enterprise-list row">
								
								<div class="enterprise-list-card col-4 row">
									<div class="col-4">
										<img alt="profile" src="/img/user_over.png" id="profileImg" class="img" width="100%">
									</div>
									<div class="col-8">
										<p class="title">Kim</p>
										<p class="position">CEO</p>
										<p class="reputation">평판 300</p>
									</div>
								</div>
								
								<div class="enterprise-list-card col-4 row">
									<div class="col-4">
										<img alt="profile" src="/img/user_over.png" id="profileImg" class="img" width="100%">
									</div>
									<div class="col-8">
										<p class="title">Kim</p>
										<p class="position">CEO</p>
										<p class="reputation">평판 300</p>
									</div>
								</div>
								
								<div class="enterprise-list-card col-4 row">
									<div class="col-4">
										<img alt="profile" src="/img/user_over.png" id="profileImg" class="img" width="100%">
									</div>
									<div class="col-8">
										<p class="title">Kim</p>
										<p class="position">CEO</p>
										<p class="reputation">평판 300</p>
									</div>
								</div>
								
								<div class="enterprise-list-card col-4 row">
									<div class="col-4">
										<img alt="profile" src="/img/user_over.png" id="profileImg" class="img" width="100%">
									</div>
									<div class="col-8">
										<p class="title">Kim</p>
										<p class="position">CEO</p>
										<p class="reputation">평판 300</p>
									</div>
								</div>
								
								<div class="enterprise-list-card col-4 row">
									<div class="col-4">
										<img alt="profile" src="/img/user_over.png" id="profileImg" class="img" width="100%">
									</div>
									<div class="col-8">
										<p class="title">Kim</p>
										<p class="position">CEO</p>
										<p class="reputation">평판 300</p>
									</div>
								</div>
								
								<div class="enterprise-list-card col-4 row">
									<div class="col-4">
										<img alt="profile" src="/img/user_over.png" id="profileImg" class="img" width="100%">
									</div>
									<div class="col-8">
										<p class="title">Kim</p>
										<p class="position">CEO</p>
										<p class="reputation">평판 300</p>
									</div>
								</div>
								
							</div>
						</div>
						
						<div class="col-12">
							<div>요청한 사람들</div>
							<hr/>
							<div class="enterprise-list row">
								
								<div class="enterprise-list-card col-4 row">
									<div class="col-4">
										<img alt="profile" src="/img/user_over.png" id="profileImg" class="img" width="100%">
									</div>
									<div class="col-8">
										<p class="title">Kim</p>
										<p class="position">CEO</p>
										<p class="reputation">평판 300</p>
									</div>
								</div>
								
								<div class="enterprise-list-card col-4 row">
									<div class="col-4">
										<img alt="profile" src="/img/user_over.png" id="profileImg" class="img" width="100%">
									</div>
									<div class="col-8">
										<p class="title">Kim</p>
										<p class="position">CEO</p>
										<p class="reputation">평판 300</p>
									</div>
								</div>
								
								<div class="enterprise-list-card col-4 row">
									<div class="col-4">
										<img alt="profile" src="/img/user_over.png" id="profileImg" class="img" width="100%">
									</div>
									<div class="col-8">
										<p class="title">Kim</p>
										<p class="position">CEO</p>
										<p class="reputation">평판 300</p>
									</div>
								</div>
								
								<div class="enterprise-list-card col-4 row">
									<div class="col-4">
										<img alt="profile" src="/img/user_over.png" id="profileImg" class="img" width="100%">
									</div>
									<div class="col-8">
										<p class="title">Kim</p>
										<p class="position">CEO</p>
										<p class="reputation">평판 300</p>
									</div>
								</div>
								
								<div class="enterprise-list-card col-4 row">
									<div class="col-4">
										<img alt="profile" src="/img/user_over.png" id="profileImg" class="img" width="100%">
									</div>
									<div class="col-8">
										<p class="title">Kim</p>
										<p class="position">CEO</p>
										<p class="reputation">평판 300</p>
									</div>
								</div>
								
								<div class="enterprise-list-card col-4 row">
									<div class="col-4">
										<img alt="profile" src="/img/user_over.png" id="profileImg" class="img" width="100%">
									</div>
									<div class="col-8">
										<p class="title">Kim</p>
										<p class="position">CEO</p>
										<p class="reputation">평판 300</p>
									</div>
								</div>
								
							</div>
						</div>
					</div>
					
				</div>
			</div>
		</div>
	</form>

<!-- FLOT CHARTS -->
<script src="../../plugins/flot/jquery.flot.js"></script>
<script type="text/javascript">
$(function() {
	
	/*
	 * LINE CHART
	 * ----------
	 */
	//LINE randomly generated data
	var sin = [],
	    cos = []
	for (var i = 0; i < 14; i += 0.5) {
	  sin.push([i, Math.sin(i)])
	  cos.push([i, Math.cos(i)])
	}
	
	var line_data1 = {
	  data : sin,
	  color: '#3c8dbc'
	}
	var line_data2 = {
	  data : cos,
	  color: '#00c0ef'
	}
	$.plot('#line-chart', [line_data1, line_data2], {
	  grid  : {
	    hoverable  : true,
	    borderColor: '#f3f3f3',
	    borderWidth: 1,
	    tickColor  : '#f3f3f3'
	  },
	  series: {
	    shadowSize: 0,
	    lines     : {
	      show: true
	    },
	    points    : {
	      show: true
	    }
	  },
	  lines : {
	    fill : false,
	    color: ['#42A5F5', '#f56954']
	  },
	  yaxis : {
	    show: true
	  },
	  xaxis : {
	    show: true
	  }
	})
	//Initialize tooltip on hover
	$('<div class="tooltip-inner" id="line-chart-tooltip"></div>').css({
	  position: 'absolute',
	  display : 'none',
	  opacity : 0.8
	}).appendTo('body')
	$('#line-chart').bind('plothover', function (event, pos, item) {
	
	  if (item) {
	    var x = item.datapoint[0].toFixed(2),
	        y = item.datapoint[1].toFixed(2)
	
	    $('#line-chart-tooltip').html(item.series.label + ' of ' + x + ' = ' + y)
	      .css({
	        top : item.pageY + 5,
	        left: item.pageX + 5
	      })
	      .fadeIn(200)
	  } else {
	    $('#line-chart-tooltip').hide()
	  }
	
	});
});
/* END LINE CHART */
</script>
</body>
</html>