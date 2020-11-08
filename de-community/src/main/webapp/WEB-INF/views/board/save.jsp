<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>

<script src="/plugins/bootstrap-switch/js/bootstrap-switch.min.js"></script>
<!-- Select2 -->
<script src="/plugins/select2/js/select2.full.min.js"></script>
<link rel="stylesheet" href="/tui-editor/tui-editor/dist/tui-editor.css">
<link rel="stylesheet" href="/tui-editor/tui-editor/dist/tui-editor-contents.css">
<link rel="stylesheet" href="/tui-editor/codemirror/lib/codemirror.css">
<link rel="stylesheet" href="/tui-editor/highlightjs/styles/github.css">
<!-- Select2 -->
<link rel="stylesheet" href="/plugins/select2/css/select2.min.css">
<link rel="stylesheet" href="/plugins/select2-bootstrap4-theme/select2-bootstrap4.min.css">
<!-- tuideditor -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.48.4/codemirror.min.css" />
<link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />
<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
<script src="https://uicdn.toast.com/editor-plugin-color-syntax/latest/toastui-editor-plugin-color-syntax.js"></script>
<style>
<!--
.select2-container--default .select2-selection--multiple .select2-selection__choice
	{
	background-color: #007bff;
	border: 1px solid #aaa;
	border-radius: 4px;
	cursor: default;
	float: left;
	margin-right: 5px;
	margin-top: 5px;
	padding: 0 5px;
}

.select2-container--default.select2-container--focus .select2-selection--multiple
	{
	height: 40px;
}
-->
</style>



<div class="content-center">
	<h2>Stacked Q&amp;A</h2>
	<div class="section-info">
		<span class="bold">질문 작성 가이드 :</span> 커뮤니티는 특정한 코딩, 알고리즘 또는 언어 문제에 대해 당신을 돕기 위함입니다. 의견 기반 질문을 피해주세요.<br> 1. 문제를 요약하세요. (목표에 대한 세부 정보 포함, 예상 결과 및 실제 결과 설명, 오류 메시지 포함)<br> 2. 시도해 본 내용을
		설명하세요.<br> 3. 일부 코드 표시<br>
	</div>


	<form id="frm" name="frm" method="post">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> <input type="hidden" name="tags" value="${result.tagno }" /> <input type="hidden" name="section" value="Q" /> <input
			type="hidden" name="editauth" value=""
		/> <input type="hidden" name="userno" value="${user.userno }" />
		<c:if test="${empty result.users.userid}">
			<input type="hidden" name="firstuserno" value="${user.userno }" />
		</c:if>
		<c:if test="${not empty result.users.userid}">
			<input type="hidden" name="userid" value="${result.users.userid }" />
			<input type="hidden" name="readcnt" value="${result.readcnt }" />
			<input type="hidden" name="questionno" value="${result.questionno }" />
			<input type="hidden" name="firstuserno" value="${result.users.userno }" />
		</c:if>


		<div class="con-box">
			<div class="form-list">
				<span>제목 <font class="red">*</font></span>
				<c:choose>
					<c:when test="${result.title ne null and isMyQuestion ne true}">
						<span> ${result.title } <input type="hidden" class="input-type1" id="title" name="title" placeholder="제목을 입력해주세요." value="${result.title }" />
						</span>
					</c:when>
					<c:when test="${isMyQuestion eq true}">
						<span> <input type="text" class="input-type1" id="title" name="title" placeholder="제목을 입력해주세요." value="${result.title }" />
						</span>
					</c:when>
					<c:otherwise>
						<input type="text" class="input-type1" id="title" name="title" placeholder="제목을 입력해주세요." value="" />
					</c:otherwise>
				</c:choose>

				<!-- 퍼블 필요 -->
				<div id="preSearch"></div>

				<span>내용 <font class="red">*</font></span>
				<div class="de-editro">
					<input type="hidden" name="contents" id="contents" value="">
					<div class="code-html">
						<div id="editSection">${result.contents }</div>
					</div>
					<script class="code-js">
			            var editor = new toastui.Editor( {
			            el : document.querySelector( '#editSection' ),
			            initialEditType : 'wysiwyg',
			            //			                    initialEditType: 'markdown',
			            previewStyle : 'vertical',
			            height : '400px'
			            } );
			          </script>
				</div>

				<span>태그</span>
				<select class="select2" multiple="multiple" name="tagno" id="tagno" data-placeholder="" style="width: 100%; background-color: #8056d6;">
					<c:forEach var="item" items="${tagList}" varStatus="status">
						<option value="${item.wikino }">${item.title }</option>
					</c:forEach>
				</select>

				<c:if test="${(result.firstuserno eq user.userno) or (result.users.userno eq null)}">
					<span>수정권한 ${result.editauth}</span>

					<div class="checkbox-switch">
						<input type="checkbox" checked="" onchange="T.toggleToobarStatus()" value="" name="editcheck" class="input-checkbox" id="toolbar-active">
						<div class="checkbox-animate">
							<span class="checkbox-off">OFF</span> <span class="checkbox-on">ON</span>
						</div>
					</div>
					<div class="txt12 txtgray">ON을 선택할 경우 다른 사람이 내가 작성한 질문을 수정할 수 있습니다. OFF을 선택할 경우 다른 사람이 내 질문을 수정할 수 없습니다.</div>
				</c:if>

			</div>
		</div>


		<div class="mT30 txt-center">
			<c:choose>
				<c:when test="${empty result.users.userid}">
					<button type="submit" name="btnSubmit" class="btn-blue" value="c">등록</button>
				</c:when>
				<c:otherwise>
					<button type="submit" name="btnSubmit" class="btn-blue" value="u">수정</button>
				</c:otherwise>
			</c:choose>
			<button type="button" class="btn-gray" onclick="location.href='/questions/list'">목록</button>
		</div>




	</form>


</div>


<script type="text/javascript">
 $( function() {
    	if($("#editcheck").val() == 1){
    		$("input:checkbox[id='editcheck']").attr("checked", true);
    	}else{
    		$("input:checkbox[id='editcheck']").attr("checked", false);
    	}
    	//질의시 presearch start
    	$("#title").on("propertychange change keyup paste input", function() {
    		var searchtxt = $(this).val();
    		var url = window.location.pathname;
    		console.log("searchtxt===="+searchtxt.length);
    		if(searchtxt.length > 1){
    		$.ajax({ 
    			//type: "POST", 
    			//contentType: "application/json", 
    			url: "/search/data",
    			data:{searchtxt:$("#title").val()},
    			//dataType: 'json', 
    			success: function (data) { 
    				var shtml = "";
    				$.each (data.list, function (index, el) {
    					  var txt = "";
      					txt = "<a href='/questions/view/"+el.seq+"'>"+el.title+"</a><br/>";
      					shtml += txt;
    					});
    				$("#preSearch").html(shtml);
    				}, 
    				error: function (e) { 
    					alert("fail"); 
    				} 
    				});
    		}else{
    			$("#preSearch").html("");
    		}
    	});
    	//질의시 presearch end
      $( "input[data-bootstrap-switch]" ).each( function() {
        $( this ).bootstrapSwitch( 'state', $( this ).prop( 'checked' ) );
      } );
      //Initialize Select2 Elements
      $( '.select2' ).select2({
			width: 'resolve'
			//language: 'ko',
			//minimumInputLength: 2
		});
      var tagno = $('form[name=frm] input[name=tags]').val();
      //alert("tags==="+tagno);
      //$('form[name=frm] input[name=tag]').val();
      var tagnoArr = tagno.split(',');
      //alert("tagnoArr===="+tagnoArr[1]);
      for ( var i in tagnoArr) {
        $( "#tagno option" ).each( function() {
          //if ($( this ).val() == tagnoArr[i]) {
            //$( "#tagno" ).select2( 'val', tagnoArr );
            $("#tagno").val(tagnoArr).trigger("change");
         // }
        } );
      }


    //저장 버튼
    //$("#btnSave").on("click",fnSave);	
    //$("#btnUpdate").on("click",fnUpdate);

    $.validator.setDefaults( {
      submitHandler : function() {
        if ($( 'input:checkbox[name="editcheck"]' ).is( ":checked" ) == true)
          document.frm.editauth.value = 1;
        else
          document.frm.editauth.value = 0;
        var vv = $( "input[name=btnSubmit]" ).val();
        document.frm.contents.value = editor.getHtml();
        if (vv == "c")
          document.frm.action = "/questions/save.proc";
        else if (vv == "u")
          document.frm.action = "/questions/edit.proc";

        document.frm.submit();
      }
    } );
    $( '#frm' ).validate( {
    rules : {
    title : {
      required : true
    },
    tag : {
      required : true
    },
    contents : {
      required : true
    }
    },
    messages : {
    title : {
      required : "제목을 입력 해주세요."
    },
    tag : {
    required : "가격을 입력 해주세요.",
    number : "숫자만 입력 가능합니다."
    },
    contents : {
      required : "내용을 입력 해주세요."
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
    } );

  } );


</script>













