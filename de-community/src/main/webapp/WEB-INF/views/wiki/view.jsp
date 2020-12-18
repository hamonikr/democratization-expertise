<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>

<!-- tui chart -->
<link rel="stylesheet" type="text/css" href="/tui-chart/tui-chart.css" />

<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.48.4/codemirror.min.css"/>
<link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />


<style>
.nav-tabs .nav-link.active {
	font-weight: 500;
    background: #2d096a;
    color: #fff;
    border: 1px solid #2d096a;
    border-radius: 20px;
}

.nav-tabs .nav-link {
    border-radius: 20px;
}
.nav-tabs {
    border-bottom: 0;
}
</style>		




<div class="content-center">
	<h2>
		<c:if test="${gubun == 'w' }">
			AskOS-위키
		</c:if>
		<c:if test="${gubun == 't' }">
			태그(Tags)
		</c:if>
	</h2>
	<ul class="nav nav-tabs" id="custom-tabs-three-tab" role="tablist">
		<li class="nav-item">
        	<a class="nav-link active" id="" data-toggle="pill" href="#custom-tabs-four-home" role="tab" aria-controls="custom-tabs-four-home"aria-selected="true">읽기</a>
		</li>
      	<c:if test="${empty history_view.title}">
      	<li class="nav-item">
        	<a class="nav-link" id="" data-toggle="pill" href="#custom-tabs-four-profile" role="tab" aria-controls="custom-tabs-four-profile" aria-selected="false">편집</a>
      	</li>
       	<li class="nav-item">
        	<a class="nav-link" id="edit-tab" data-toggle="pill" href="#custom-tabs-four-messages" role="tab" aria-controls="custom-tabs-four-messages" aria-selected="false">히스토리</a>
      	</li>
		</c:if>     
	</ul>
	
	<div class="tab-content" id="custom-tabs-three-tabContent">
		<!-- 뷰 -->
		<div class="tab-pane fade show active con-box" id="custom-tabs-four-home" role="tabpanel" aria-labelledby="custom-tabs-four-home-tab">
			<p class="wiki-title">${result.title}</p>
			<div id="viewer" class="mT30">${result.contents }</div>
			<script>
				var viewer = new toastui.Editor.factory( { 
					el: document.querySelector('#viewer'),
					viewer: true
				});
            </script>
			
		</div>
		
		<!-- 편집  -->
		<div class="tab-pane fade con-box" id="custom-tabs-four-profile" role="tabpanel" aria-labelledby="custom-tabs-four-profile-tab">
			<form id="frm" name="frm" method="post">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
				<input type="hidden" name="wikino" id="wikino" value="${result.wikino}"/>
				<input type="hidden" name ="section" id="section" value ='w' >
				
	    		<p style="float:right">
	    			<a class="" id="btnUpdate">[수정하기]</a>
	    			<a class="" id="btnDelete">[삭제하기]</a>
	    		</p>
				<p class="wiki-title">${result.title}</p>
		    	
	    		<input type="hidden" name="title" value="${result.title}">
				<input type="hidden" name="contents" id="contents" value="">
				<div id="editSection" class="mT30">${result.contents }</div>
				<script class="code-js">
					var editor = new toastui.Editor( { 
						el: document.querySelector('#editSection'),
						initialEditType: 'wysiwyg',
						previewStyle: 'vertical',
						height: '100%'
					});
	            </script>
            </form>
		</div>
		<!-- 히스토 -->
		<div class="tab-pane fade con-box" style="height: 100%;" id="custom-tabs-four-messages" role="tabpanel" aria-labelledby="custom-tabs-four-messages-tab">
			<p class="wiki-title">[ ${result.title} ]Histories</p>
				<div class="mywrit" style="width:100%">
				<ul>
					<c:forEach var="list" items="${history}" varStatus="status">
					<li>
						<span class="up" style="width: 50px;"><i class="mdi"></i>No_${ list.rowno}</span>
					  	${list.usernm} 님이 수정....
					  	<fmt:formatDate value="${list.updatedate}" pattern="yyyy-MM-dd HH:mm:ss" />
<%-- 					  	<a href="/wiki/edit/${list.seq}">${list.title} </a> --%>
					</li>
					</c:forEach>
				</ul>
			</div>
		</div>
	</div>
	
	
	           
           
</div>




<script type="text/javascript">

$(function() {
	$("#btnUpdate").on("click", fnUpdate);
	$("#btnDelete").on("click", fnDelete);
});

function fnUpdate() {
	var contents =  editor.getHtml();

	if(contents.length !=0){
		document.frm.action = "/wiki/edit.proc";
		document.frm.contents.value = contents;
		document.frm.submit();
	} else{
			alert("내용을 입력해주세요");
		}
}

function fnDelete() {
	document.frm.action = "/wiki/delete.proc";
	document.frm.submit();
}



</script>

<script>
const { Editor } = toastui;
//const { color-syntax } = Editor.plugin;

const editor = new Editor({
	 el: document.querySelector('#editor'),
	 initialEditType : 'wysiwyg',
	 previewStyle : 'vertical',
	 height : '700px'
});

var viewer = Editor.factory({
     el: document.querySelector('#viewer'),
     viewer : true
    // color: black
});

</script>