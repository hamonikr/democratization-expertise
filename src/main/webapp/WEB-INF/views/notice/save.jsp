<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>

<!-- <script src="/tui-editor/jquery/dist/jquery.js"></script> -->
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
<c:if test="${result ne null }">
<input type="hidden" name="bizcd" id="bizcd" value="${result.bizcd}" />
<input type="hidden" name="seq" id="seq" value="${result.seq}" />
<input type="hidden" name="writer_id" id="writer_id" value="${result.writer_id }"/>
<input type="hidden" name="writer_name" id="writer_name" value="${result.writer_name }"/>
</c:if>
<c:if test="${params ne null }">
<!-- 저장필수값 -->
<input type="hidden" name="bizcd" id="bizcd" value="" />
<input type="hidden" name="writer_id" id="writer_id" value=""/>
<input type="hidden" name="writer_name" id="writer_name" value=""/>
<input type="hidden" name="business_code" id="business_code" value=""/>
</c:if>
<!-- 스프링 시큐리티 form에 추가 해줘야함. -->
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
<section class="content">
<section class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1>계약서 등록</h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active">계약서 등록</li>
            </ol>
          </div>
        </div>
      </div><!-- /.container-fluid -->
    </section>
<!-- general form elements -->
              <div class="card card-secondary">
              <div class="card-header">
                <h3 class="card-title">계약주요 사항</h3>
              </div>
              <div class="card-body">
              <div class="row">
              <div class="col-md-6">
                  <div class="form-group">
                    <label for="contract">계약명</label>
                    <input type="text" class="form-control" id="contract" name="contract" placeholder="계약명을 입력해주세요." value="${result.contract}" />
                  </div>
                  <!-- Date range -->
                <div class="form-group">
                  <label>계약기간</label>
                  <div class="input-group">
                    <div class="input-group-prepend">
                      <span class="input-group-text">
                        <i class="far fa-calendar-alt"></i>
                      </span>
                    </div>
                    <input type="text" class="form-control float-right" id="contract_period" name="contract_period" value="${result.contract_period }">
                  </div>
                  <!-- /.input group -->
                </div>
                <!-- /.form group -->
                  </div>
                  <div class="col-md-6">
                  	<div class="form-group">
                    <label for="contract_amount">총금액</label>
                    <input type="text" class="form-control" id="contract_amount" name="contract_amount" placeholder="총금액을 입력해주세요." value="${result.contract_amount}" />
                  </div>
                  <div class="form-group">
                  <label>계약체결일</label>

                  <div class="input-group">
                    <div class="input-group-prepend">
                      <span class="input-group-text"><i class="far fa-calendar-alt"></i></span>
                    </div>
                    <input type="text" class="form-control" id="contract_date" name="contract_date" value="${result.contract_date }" data-inputmask-alias="datetime" data-inputmask-inputformat="yyyy/mm/dd" data-mask="" im-insert="false">
                  </div>
                  <!-- /.input group -->
                </div>
                </div>
              </div>
            </div>
          </div>
            <div class="card card-secondary">
              <div class="card-header">
                <h3 class="card-title">계약당사자</h3>
              </div>
              <div class="card-body">
              <div class="row">
              <div class="col-md-6">
                  <div class="form-group">
                    <label for="demand_name">수요자 상호</label>
                    <input type="text" class="form-control" id="demand_name" name="demand_name" placeholder="상호명을 입력해주세요." value="${result.demand_name}" readonly />
                  </div>
                  <div class="form-group">
                    <label for="demand_addr">주소</label>
                    <input type="text" class="form-control" id="demand_addr" name="demand_addr" placeholder="주소를 입력해주세요." value="${result.demand_addr}" />
                  </div>
                  <div class="form-group">
                    <label for="demand_bizno">사업자번호</label>
                    <input type="text" class="form-control" id="demand_bizno" name="demand_bizno" placeholder="사업자번호를 입력해주세요." value="${result.demand_bizno}" />
                  </div>
                  <div class="form-group">
                    <label for="demand_cxfc">대표이사</label>
                    <input type="text" class="form-control" id="demand_cxfc" name="demand_cxfc" placeholder="대표이사명을 입력해주세요." value="${result.demand_cxfc}" />
                  </div>
                  </div>
                  <div class="col-md-6">
                  	<div class="form-group">
                    <label for="supply_name">공급자 상호</label>
                    <input type="text" class="form-control" id="supply_name" name="supply_name" placeholder="상호명을 입력해주세요." value="${result.supply_name}" readonly />
                  </div>
                  <div class="form-group">
                    <label for="supply_addr">주소</label>
                    <input type="text" class="form-control" id="supply_addr" name="supply_addr" placeholder="주소를 입력해주세요." value="${result.supply_addr}" readonly />
                  </div>
                  <div class="form-group">
                    <label for="supply_bizno">사업자번호</label>
                    <input type="text" class="form-control" id="supply_bizno" name="supply_bizno" placeholder="사업자번호를 입력해주세요." value="${result.supply_bizno}" readonly />
                  </div>
                  <div class="form-group">
                    <label for="supply_cxfc">대표이사</label>
                    <input type="text" class="form-control" id="supply_cxfc" name="supply_cxfc" placeholder="대표이사명을 입력해주세요." value="${result.supply_cxfc}" readonly />
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="card card-secondary">
              <div class="card-header">
                <h3 class="card-title">계약품목</h3>
              </div>
              <div class="card-body">
              <div class="row">
              <div class="col-md-6">
                  <div class="form-group">
                    <label for="product_section">아이템코드</label>
                    <input type="text" class="form-control" id="product_section" name="product_section" value="${result.product_section}" readonly />
                  </div>
                  <div class="form-group">
                    <label for="product_name">품명</label>
                    <input type="text" class="form-control" id="product_name" name="product_name" value="${result.product_name}" readonly />
                  </div>
                  <div class="form-group">
                    <label for="sale_qy">수량</label>
                    <input type="text" class="form-control" id="sale_qy" name="sale_qy" value="${result.sale_qy}" readonly />
                  </div>
                  </div>
                  <div class="col-md-6">
                  	<div class="form-group">
                    <label for="price">단가</label>
                    <input type="text" class="form-control" id="price" name="price" value="${result.price}" readonly />
                  </div>
                  <div class="form-group">
                    <label for="contract_amount">금액</label>
                    <input type="text" class="form-control" id="contract_amount2" name="contract_amount2" value="" readonly />
                  </div>
                  <div class="form-group">
                  <label>납품일</label>

                  <div class="input-group">
                    <div class="input-group-prepend">
                      <span class="input-group-text"><i class="far fa-calendar-alt"></i></span>
                    </div>
                    <input type="text" class="form-control" id="offer_date" name="offer_date" data-inputmask-alias="datetime" data-inputmask-inputformat="yyyy/mm/dd" data-mask="" im-insert="false" value="${result.offer_date }">
                  </div>
                  <!-- /.input group -->
                </div>
                </div>
              </div>
            </div>
          </div>
                  <div class="card-body">
                  <div class="form-group">
                    <label for="contract_cnd">계약조건</label>
                     <input type="hidden" name="contract_cnd" id="contract_cnd" value="">
                                        <div class="code-html">
						                <div id="editSection">${result.contract_cnd }</div> 
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
                </div>
                  <div class="card-body">
                  <div class="form-group">
                    <label for="special_contract">특약사항</label>
                     <input type="hidden" name="special_contract" id="special_contract" value="">
                                        <div class="code-html">
						                <div id="editSection2">${result.special_contract }</div> 
						            </div>
						            <script class="code-js">
						                var editor2 = new tui.Editor({
						                    el: document.querySelector('#editSection2'),
						                    initialEditType: 'wysiwyg',
			//			                    initialEditType: 'markdown',
						                    previewStyle: 'vertical',
						                    height: '400px'
						                });
						            </script>
                  </div>
                </div>
                <div class="card-body">
                  <div class="form-group">
                    <label for="">계약서 첨부</label>
                    <div class="input-group">
                      <div class="custom-file">
                        <input type="file" class="custom-file-input" id="filename" name="filename">
                        <label class="custom-file-label" for="filename">
                        <c:if test="${empty file}">파일 선택</c:if>
                        <c:if test="${not empty file}">${file.filerealname }</c:if>
                        </label>
                      </div>
                      <!-- <div class="input-group-append">
                        <span class="input-group-text" id="">Upload</span>
                      </div> -->
                    </div>
                  </div>
                </div>
                <div class="card-footer">
                  <c:choose> 
					<c:when test="${result.writer_id eq null}"> 
                    <button type="button" id="btnSave" class="btn btn-primary"> 등록</button>
                    </c:when>
                    <c:otherwise>
                    <button type="button" id="btnUpdate" class="btn btn-primary"> 수정</button>
                    <button type="button" id="btnDelete" class="btn btn-primary"> 삭제</button>
                    </c:otherwise>
                    </c:choose>
                    <button type="button" class="btn btn-primary" onclick="location.href='list.ivs'"> 목록</button>
                </div>
                </section>
    </form>
<script type="text/javascript">

$(function() {
	//저장 버튼
    $("#btnSave").on("click",fnSave);	
    $("#btnUpdate").on("click",fnUpdate);
    $("#btnDelete").on("click",fnDelete);
   //Date range picker
    $('#contract_period').daterangepicker({
    	locale :{
            format: 'YYYY/MM/DD'
        }
        });
   //Datemask yyyy/mm/dd
    $('#contract_date').inputmask('yyyy/mm/dd', { 'placeholder': 'yyyy/mm/dd' })
    $('#offer_date').inputmask('yyyy/mm/dd', { 'placeholder': 'yyyy/mm/dd' })

    //값 세팅
    	init();
    bsCustomFileInput.init();
});

function fnSave() {
	//value_chk();
	document.frm.contract_cnd.value = editor.getHtml();
	document.frm.special_contract.value = editor2.getHtml();
	document.frm.action = "save.proc";
	document.frm.submit();
}

function fnUpdate() {
	document.frm.contract_cnd.value = editor.getHtml();
	document.frm.special_contract.value = editor2.getHtml();
	document.frm.action = "update.proc";
	document.frm.submit();
}

function fnDelete() {
	document.frm.action = "delete.proc";
	document.frm.submit();
}
/* function value_chk(){
	var instt_se = $('input:radio[name="instt_section"]:checked').val();
	var product_se = $('input:radio[name="product_section"]:checked').val();
	document.frm.instt_section.value = instt_se;
	document.frm.product_section.value = product_se;
} */

function init(){
	if(${params != null && params != ""}){
		document.frm.bizcd.value = "${params.bizcd}";
		document.frm.writer_id.value = "${params.writer_id }";
		document.frm.writer_name.value = "${params.writer_name }";
		document.frm.business_code.value = "${params.business_code }";
		document.frm.price.value = "${params.price}";
		document.frm.sale_qy.value = "${params.sale_qy}";
		document.frm.product_section.value = "${params.product_section }";
		document.frm.demand_name.value = "${params.instt_name }";
		
		document.frm.supply_name.value = "${getInfo.biznm }";
		document.frm.supply_addr.value = "${getInfo.addr1 }";
		document.frm.supply_bizno.value = "${getInfo.bizno }";
		document.frm.supply_cxfc.value = "${getInfo.rprsntNm }";
		document.frm.product_name.value = "${getInfo.subject }";
	}
	
		document.frm.contract_amount2.value = (document.frm.price.value * document.frm.sale_qy.value);
	
	
	
}
</script>
</body>
</html>