<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>

<link rel="stylesheet" href="/dist/css/adminlte.min.css">

<!-- tui editor-->
<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
<!-- Editor's Dependecy Style -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.48.4/codemirror.min.css"/>
<!-- Editor's Style -->
<link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />

<style>

.ellipsis {
display: -webkit-box;
width: 300px; 
height: 208px;

-webkit-line-clamp: 10;
-webkit-box-orient: vertical;
overflow: hidden; 
text-overflow: ellipsis; 

word-wrap: break-word; 
line-height: 1.2; 

pointer-events: none;
cursor: default;
text-decoration:none ;
font-size: small;
color: rgb(0,0,0);
}

</style>
<script>

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
									<button type="button" class="btn btn-outline-primary float-right" id="btnSave" onclick="location.href='/wiki/saveTag'">+ Tag 생성</button>
								</div>
							</div>
						</div>

						<div class="invoice p-3 mb-3" style="border-left: 5px solid #117a8b;">
							<div class="row">
				 		
				 			<c:forEach var="list" items="${result}" varStatus="status">
								<div class="col-md-3">
									<div class="card card-outline card-primary col-12" >
										<div class="card-header col-12">
											<h3 class="card-title">
												<a href="/wiki/view/${list.wikino}">${list.title}</a>
											</h3>
											
											<div class="card-tools">
											 	<p style="font-size:9px"><a href="/questions/list">${list.relatedcnt}</a> 개의 질문들</p>
											 </div>
										</div>
										<div class="card-body col-12 ellipsis">
											<div> ${list.contents}</div>
										</div>
									</div>
								</div>
							</c:forEach>
							
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

 