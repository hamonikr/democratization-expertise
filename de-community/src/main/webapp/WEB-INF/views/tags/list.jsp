<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>

<link rel="stylesheet" href="/dist/css/adminlte.min.css">

<script>

$( function() {
//   $( "#bodyrightLayer" ).hide();
} );
</script>
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
							<h5>Tags</h5>


							<div class="card-header" style="border-bottom: 0px;">
								<div class="card-tools float-left col-10">
									<div class="input-group input-group ">활동적인 유저의 공헌 목록은 다음과 같습니다.<br> 커뮤니티에 지식을 제공하여 더 많은 사람들이 성장할 수 있도록 합니다.</div>
								</div>
								<div class="col-2 float-right">
									<button type="button" class="btn btn-outline-primary float-right" id="btnSave" onclick="location.href='save'">+ Tag 생성</button>
								</div>
							</div>
						</div>



						<div class="invoice p-3 mb-3" style="border-left: 5px solid #117a8b;">
							<div class="row">
								<div class="col-md-3">
									<div class="card card-outline card-primary col-12">
										<div class="card-header col-12">
											<h3 class="card-title">
												<a href="javascript:;">Collap</a>
											</h3>

											<div class="card-tools"></div>
										</div>
										<div class="card-body col-12" style="height: 200px;">안드로이드(Android)는 리눅스 커널을 기반으로 구글에서 제작한 스마트폰과 같은 플랫폼의 모바일 운영</div>
									</div>
								</div>
								<div class="col-md-3">
									<div class="card card-outline card-primary col-12">
										<div class="card-header col-12">
											<h3 class="card-title">python</h3>
											<div class="card-tools"></div>
										</div>
										<div class="card-body col-12" style="height: 200px;">1991년에 발표된 MATLAB과 유사한 인터프리터 방식의 프로그래밍 언어. 공식 홈페이지 공식 깃헙 저장소 최신 버전은 2019년 10월 14일</div>
									</div>
								</div>
								<div class="col-md-3">
									<div class="card card-outline card-primary col-12">
										<div class="card-header col-12">
											<h3 class="card-title">Javasript</h3>
											<div class="card-tools"></div>
										</div>
										<div class="card-body col-12" style="height: 200px;">자바스크립트를 한마디로 요약하자면 웹을 풍부하게 만들어주는 작고 가벼운 언어입</div>
									</div>
								</div>
								<div class="col-md-3">
									<div class="card card-outline card-primary col-12">
										<div class="card-header col-12">
											<h3 class="card-title">java</h3>
											<div class="card-tools"></div>
										</div>
										<div class="card-body col-12" style="height: 200px;">에 개발한 객체 지향 프로그래밍 언어. 창시자는 제임스 고슬링이다. 2010년에 오라클이 썬 마이크로시스템즈을 인수하면서 Java의 저작권을 소</div>
									</div>
								</div>

							</div>
						</div>
					</div>
				</div>



			</div>
			<!-- page number -->
			<%-- 			<jsp:include page="/WEB-INF/views/include/paging.jsp" /> --%>
		</form>
	</section>



</body>

<script type="text/javascript">
  $( function() {
    //저장 버튼
    //$(".sort").on("click",fnSort);	
    //$("#btnUpdate").on("click",fnUpdate);	
  } );

  function linkPage(pageNo) {
    location.href = "list.do?pageNo=" + pageNo;
  }

  function fnLike(p, su, s, i, l) {
    var like = l;
    console.log( "like===" + like );
    $.ajax( {
    //type: "POST", 
    contentType : "application/json",
    url : "/vote/like",
    data : {
    pno : p,
    section : s,
    userno : su,
    likes : 1
    },
    //dataType: 'json', 
    success : function(data) {
      console.log( data );
      if (data == "FAIL") {
        alert( "이미 투표하셨습니다." );
        /* $(".like").each(function(index, item){ 
        	alert($(".like").eq(index).attr('value'));
        }) */
      } else if (data == "LOGIN") {
        alert( "로그인이 필요한 기능입니다." );
        location.href = "/login";
      } else {
        alert( "투표하였습니다." );
        ++l;
        $( "#like" + i ).html( l );
      }
    },
    error : function(e) {
      alert( "fail" );
    }
    } );

  }
  function fnDisLike(p, su, s, i, l) {

    $.ajax( {
    //type: "POST", 
    contentType : "application/json",
    url : "/vote/dislike",
    data : {
    pno : p,
    section : s,
    userno : su,
    dislikes : 1
    },
    //dataType: 'json', 
    success : function(data) {
      console.log( data );
      if (data == "FAIL") {
        alert( "이미 투표하셨습니다." );
      } else {
        alert( "투표하였습니다." );
        ++l;
        $( "#dislike" + i ).html( l );
      }
    },
    error : function(e) {
      alert( "fail" );
    }
    } );

  }
</script>
