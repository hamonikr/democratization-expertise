<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>

<script src="/tui-editor/jquery/dist/jquery.js"></script>
<script src='/tui-editor/markdown-it/dist/markdown-it.js'></script>
<script src="/tui-editor/to-mark/dist/to-mark.js"></script>
<script src="/tui-editor/tui-code-snippet/dist/tui-code-snippet.js"></script>
<script src="/tui-editor/codemirror/lib/codemirror.js"></script>
<script src="/tui-editor/highlightjs/highlight.pack.js"></script>
<script src="/tui-editor/squire-rte/build/squire-raw.js"></script>
<script src="/tui-editor/tui-editor/dist/tui-editor-Editor.js"></script>
<link rel="stylesheet" href="/tui-editor/tui-editor/dist/tui-editor.css">
<link rel="stylesheet" href="/tui-editor/tui-editor/dist/tui-editor-contents.css">
<link rel="stylesheet" href="/tui-editor/codemirror/lib/codemirror.css">
<link rel="stylesheet" href="/tui-editor/highlightjs/styles/github.css">

<!-- jquery-validation -->
<script src="/plugins/jquery-validation/jquery.validate.min.js"></script>
<script src="/plugins/jquery-validation/additional-methods.min.js"></script>

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>


<style>
/*datepicer 버튼 롤오버 시 손가락 모양 표시*/
.ui-datepicker-trigger {
	cursor: pointer;
}
/*datepicer input 롤오버 시 손가락 모양 표시*/
.hasDatepicker {
	cursor: pointer;
}
</style>



<body>

	<form id="frm" name="frm" method="post" enctype="multipart/form-data">
		<input type="hidden" id="user_ip" name="user_ip" value="127.0.0.1" /> <input type="hidden" id="user_addr" name="user_addr" value="테스트 주소" />
		<!-- 스프링 시큐리티 form에 추가 해줘야함. -->
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		<!-- content -->
		<div class="hamo_container">
			<div class="content_con">

				<h2>라이선스 등록</h2>
				<!-- content list -->
				<div class="con_box">

					<div class="board_view mT20">
						<table>
							<colgroup>
								<col style="width: 15%;" />
								<col style="width: 35%;" />
								<col style="width: 15%;" />
								<col style="width: 35%;" />
								<col />
							</colgroup>
							<tbody> 
								<tr>
									<th>상호명 (한글)</th>
									<td colspan="3">
										<div class="form-group">
											<label for="titl" class="none"></label>
											<input type="text" name="biznm" id="biznm" placeholder="제목을 입력해주세요." value="" />
										</div>
									</td>
								</tr>
								<tr>
									<th>상호명 (영문)</th>
									<td>
										<div class="form-group">
											<label for="user_id" class="none"></label>
											<input type="text" name="biznm_en" id="biznm_en" placeholder="아이디를 입력해주세요." value="" />
										</div>
									</td>
								</tr>
								<tr>
									<th>사업자번호</th>
									<td>
										<div class="form-group">
											<label for="user_nm" class="none"></label>
											<input type="text" name="bizno1" id="bizno1" placeholder="이름을 입력해주세요." value="" />
											<input type="text" name="bizno2" id="bizno2" placeholder="이름을 입력해주세요." value="" />
											<input type="text" name="bizno3" id="bizno3" placeholder="이름을 입력해주세요." value="" />
										</div>
									</td>
								</tr>
								<tr>
									<th>라이선스 발급 명</th>
									<td>
										<div class="form-group">
											<label for="user_nm" class="none"></label>
											<input type="text" name="license_title" id="license_title" placeholder="이름을 입력해주세요." value="" />
										</div>
									</td>
								</tr>
								<tr>
									<th>라이선스 발급 개수</th>
									<td>
										<div class="form-group">
											<label for="user_nm" class="none"></label>
											<input type="text" name="license_count" id="license_count" placeholder="이름을 입력해주세요." value="" />
										</div>
									</td>
								</tr>
								<tr>
									<th>라이선스 사용 기간</th>
									<td>
										<div class="form-group">
											<label for="user_hp" class="none"></label>
											From: <input type="text" id="lcns_st" name="lcns_st">To: <input type="text" id="lcns_dt" name="lcns_dt">
										</div>
									</td>
								</tr>


							</tbody>
						</table>
					</div>
					<!-- //List -->
					<div class="t_center mT20">
						<c:choose>
							<c:when test="${result.user_id == null}">
								<button type="button" id="btnSave" class="btn_type2">등록</button>
							</c:when>
							<c:otherwise>
								<button type="button" id="btnUpdate" class="btn_type2">수정</button>
								<button type="button" class="btn_type2" onclick="goDelete()">삭제</button>
							</c:otherwise>
						</c:choose>
						<button type="button" class="btn_type2" onclick="location.href='sampleList'">목록</button>
					</div>
				</div>
				<!-- //con_box -->
			</div>
		</div>
		<!-- //content -->
	</form>
	<script type="text/javascript">
    $( function() {
      $.datepicker.setDefaults( {
      dateFormat : 'yy-mm-dd',
      showOtherMonths : true,
      showMonthAfterYear : true,
      changeYear : true,
      changeMonth : true,
      showOn : "both",
      buttonImage : "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif",
      buttonImageOnly : true,
      buttonText : "선택",
      yearSuffix : "년",
      monthNamesShort : [ '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12' ],
      monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월' ],
      dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ],
      dayNames : [ '일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일' ]

      } );

      //input을 datepicker로 선언
      $( "#lcns_st" ).datepicker();
      $( "#lcns_dt" ).datepicker();

      //From의 초기값을 오늘 날짜로 설정
      $( '#lcns_st' ).datepicker( 'setDate', 'today' ); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)
      //To의 초기값을 내일로 설정
      $( '#lcns_dt' ).datepicker( 'setDate', '+1D' ); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)
    } );

    $( function() {
      //저장 버튼
      $( "#btnSave" ).on( "click", fnSave );
      $( "#btnUpdate" ).on( "click", fnUpdate );
    } );

    function fnSave() {
      //document.frm.ctnt.value = editor.getHtml();
      document.frm.action = "/lcns/addForm.proc";
      document.frm.submit();
    }

    function fnUpdate() {
      document.frm.ctnt.value = editor.getHtml();
      document.frm.action = "/update?seq=${result.seq}";
      document.frm.submit();
    }
  </script>
</body>
</html>