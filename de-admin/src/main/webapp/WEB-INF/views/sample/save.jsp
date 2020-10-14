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

<body>

<form id="frm" name="frm" method="post" enctype="multipart/form-data">
<input type="hidden" id="user_ip" name="user_ip" value="127.0.0.1"/>
<input type="hidden" id="user_addr" name="user_addr" value="테스트 주소"/>
<!-- 스프링 시큐리티 form에 추가 해줘야함. -->
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
<!-- content -->
    <div class="hamo_container">
        <div class="content_con">

            <h2>등록</h2>
            <!-- content list -->
            <div class="con_box">

                <div class="board_view mT20">
                    <table>
                        <colgroup>
                            <col style="width:15%;" />
                            <col style="width:35%;" />
                            <col style="width:15%;" />
                            <col style="width:35%;" />
                            <col />
                        </colgroup>
                        <tbody>
                        		<tr>
                               <th>제목</th>
                               <td colspan="3">
                               <div class="form-group">
                                   <label for="titl" class="none"></label>
                                   <input type="text" name="titl" id="titl" placeholder="제목을 입력해주세요." value="${result.titl}" />
                               </div>
                               </td>
                            </tr>
                            <tr>
                                <th>ID</th>
                                <td>
                                <div class="form-group">
                                    <label for="user_id" class="none"></label>
                                    <input type="text" name="user_id" id="user_id" placeholder="아이디를 입력해주세요." value="${result.user_id}" />
                                </div>
                                </td>
                            </tr>
                            <tr>
                                <th>이름</th>
                                <td>
                                <div class="form-group">
                                    <label for="user_nm" class="none"></label>
                                    <input type="text" name="user_nm" id="user_nm" placeholder="이름을 입력해주세요." value="${result.user_nm}" />
                                </div>
                                </td>
                            </tr>
                            <tr>
                                <th>이메일</th>
                                <td>
                                <div class="form-group">
                                    <label for="user_email" class="none"></label>
                                    <input type="text" name="user_email" id="user_email" placeholder="이메일을 입력해주세요." value="${result.user_email}" />
                               </div>
                                </td>
                            </tr>
                            <tr>
                                <th>연락처</th>
                                <td>
                                <div class="form-group">
                                    <label for="user_hp" class="none"></label>
                                    <input type="text" name="user_hp" id="user_hp" placeholder="연락처를 입력해주세요." value="${result.user_hp}" />
                                </div>
                                </td>
                            </tr>
                            <tr>
                                <th>첨부파일</th>
                                <td>
                                <div class="form-group">
                                    <label for="file1" class="none"></label>
                                    <input type="file" name="filename" id="filename" placeholder="" />
                                </div>
                                </td>
                            </tr>
                            <tr>
                                    <td colspan="6" class="view">
                                    <div class="form-group">
                                       <input type="hidden" name="ctnt" id="ctnt" value="">
                                        <div class="code-html">
						                <div id="editSection">${result.ctnt }</div> 
						            </div>
						            <script class="code-js">
						                var editor = new tui.Editor({
						                    el: document.querySelector('#editSection'),
						                    initialEditType: 'wysiwyg',
			//			                    initialEditType: 'markdown',
						                    previewStyle: 'vertical',
						                    height: '400px'
						                });
						            </script>
						            </div>
                                    </td>
                                </tr>
                        </tbody>
                    </table>
                </div><!-- //List -->
                <div class="t_center mT20">
                <c:choose> 
					<c:when test="${result.user_id == null}"> 
                    <button type="button" id="btnSave" class="btn_type2"> 등록</button>
                    </c:when>
                    <c:otherwise>
                    <button type="button" id="btnUpdate" class="btn_type2"> 수정</button>
                    <button type="button" class="btn_type2" onclick="goDelete()"> 삭제</button>
                    </c:otherwise>
                    </c:choose>
                    <button type="button" class="btn_type2" onclick="location.href='sampleList'"> 목록</button>
                </div>
            </div><!-- //con_box -->
        </div>
    </div><!-- //content -->
    </form>
<script type="text/javascript">

$(function() {
	//저장 버튼
    $("#btnSave").on("click",fnSave);	
    $("#btnUpdate").on("click",fnUpdate);	
});

function fnSave() {
	document.frm.ctnt.value = editor.getHtml();
	document.frm.action = "save";
	document.frm.submit();
}

function fnUpdate() {
	document.frm.ctnt.value = editor.getHtml();
	document.frm.action = "update?seq=${result.seq}";
	document.frm.submit();
}
</script>
</body>
</html>