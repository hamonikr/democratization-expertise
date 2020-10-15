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

<style>
.card.bg-light { 
	box-shadow: 0 0 1px rgba(0,0,0,.125), 0 1px 3px rgba(0,0,0,.2); 
	overflow: hidden;
}
.card-header { padding: .75rem 1.25rem }

.card-body { border-top: 0 }
.card-body .lead { margin: 1em 0 .5em 0 }
.card-body .lead b { 
	 display: block;
	text-decoration: none;
	color: #333;
	text-overflow: ellipsis;
	white-space: nowrap;
	overflow: hidden;
}
.card-body ul { margin: 0 !important }

.card-footer.row { margin: 0 }
.card-footer button.btn-sm { 
	font-size: .75em; 
	margin: 0;
}
</style>

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

<div class="row">

	<div id="input_div" class="col-12 " style="margin-top: .75rem;">
		<div class="callout callout-info row ">
			<div class="col-6">
				<h5>계약서 등록</h5>
			</div>
			<div class="col-6">
				<span class="float-right  "><a href="/main/index">Home</a> / 계약서 관리 / 계약서 등록</span>
			</div>
		</div>
	</div>
	

	<div class="col-12">
		<div class="card card-primary">
			
			<div class="row mb-2">
				<div class="col-sm-12">
					<h5>계약주요 사항</h5>
				</div>
			</div>
			
			<div class="card-body card-primary card-outline row">

				<div class="col-lg-6">
					<div class="form-group">
						<label for="inputEmail3" class="col-form-label">계약명 <span class="important">*</span></label>
						<input type="text" class="form-control" id="contract" name="contract" placeholder="계약명을 입력해주세요." value="${result.contract}" />
					 </div>
				</div>

				<div class="col-lg-6">
					<div class="form-group">
						<label for="inputEmail3" class="col-form-label">총금액 <span class="important">*</span></label>
						<input type="text" class="form-control" id="contract_amount" name="contract_amount" placeholder="총금액을 입력해주세요." value="${result.contract_amount}" />
					 </div>
				</div>

				<div class="col-lg-6">
					<div class="form-group">
						<label for="inputEmail3" class="col-form-label">계약기간 <span class="important">*</span></label>
						<div class="input-group">
							<div class="input-group-prepend">
								<span class="input-group-text">
									<i class="far fa-calendar-alt"></i>
								</span>
							</div>
							<input type="text" class="form-control float-right contract_period" name="contract_period" id="contract_period" autocomplete="off" value="${result.contract_period }">
						</div>
					 </div>
				</div>

				<div class="col-lg-6">
					<div class="form-group">
						<label for="inputEmail3" class="col-form-label">계약체결일 <span class="important">*</span></label>
						<div class="input-group">
							<div class="input-group-prepend">
								<span class="input-group-text">
									<i class="far fa-calendar-alt"></i>
								</span>
							</div>
							<input type="text" class="form-control float-right" id="contract_date" name="contract_date" autocomplete="off" value="${result.contract_date }" >
						</div>
					 </div>
				</div>
			</div>

		</div>
	</div>


	<div class="col-12">
		<div class="card card-primary">
			
			<div class="row mb-2">
				<div class="col-sm-12">
					<h5>계약당사자</h5>
				</div>
			</div>

			<div class="card-body card-primary card-outline row">

				<div class="col-lg-6">
		              <div class="card bg-light">
		                <div class="card-header text-muted border-bottom-0"><b>수요자</b></div>
			                <div class="card-body pt-0">
			                  <div class="row">
			                  	
			                        <div class="col-lg-12">
										<div class="form-group">
											<label for="inputEmail3" class="col-form-label">상호</label>
											<input type="text" class="form-control" id="demand_name" name="demand_name" placeholder="상호명을 입력해주세요." value="${result.demand_name}" readonly />
										 </div>
									</div>
									
									<div class="col-lg-12">
										<div class="form-group">
											<label for="inputEmail3" class="col-form-label">주소 <span class="important">*</span></label>
											<input type="text" class="form-control" id="demand_addr" name="demand_addr" placeholder="주소를 입력해주세요." value="${result.demand_addr}" />
										 </div>
									</div>
									
									<div class="col-lg-12">
										<div class="form-group">
											<label for="inputEmail3" class="col-form-label">사업자번호 <span class="important">*</span></label>
											<input type="text" class="form-control" id="demand_bizno" name="demand_bizno" placeholder="사업자번호를 입력해주세요." value="${result.demand_bizno}" />
										 </div>
									</div>
									
									<div class="col-lg-12">
										<div class="form-group">
											<label for="inputEmail3" class="col-form-label">대표이사 <span class="important">*</span></label>
											<input type="text" class="form-control" id="demand_cxfc" name="demand_cxfc" placeholder="대표이사명을 입력해주세요." value="${result.demand_cxfc}" />
										 </div>
									</div>
			                        
			                    </div>
			                    
			                  </div>
		                </div>
		              </div>


					<div class="col-lg-6">
		              <div class="card bg-light">
		                <div class="card-header text-muted border-bottom-0"><b>공급자</b></div>
			                <div class="card-body pt-0">
			                  <div class="row">
								<div class="col-lg-12">
									<div class="form-group">
										<label for="inputEmail3" class="col-form-label">상호</label>
										<input type="text" class="form-control" id="supply_name" name="supply_name" placeholder="상호명을 입력해주세요." value="${result.supply_name}" readonly />
									 </div>
								</div>
								
								<div class="col-lg-12">
									<div class="form-group">
										<label for="inputEmail3" class="col-form-label">주소</label>
										<input type="text" class="form-control" id="supply_addr" name="supply_addr" placeholder="주소를 입력해주세요." value="${result.supply_addr}" readonly />
									 </div>
								</div>
								
								<div class="col-lg-12">
									<div class="form-group">
										<label for="inputEmail3" class="col-form-label">사업자번호</label>
										<input type="number" class="form-control" id="supply_bizno" name="supply_bizno" placeholder="사업자번호를 입력해주세요." value="${result.supply_bizno}" readonly />
									 </div>
								</div>
								
								<div class="col-lg-12">
									<div class="form-group">
										<label for="inputEmail3" class="col-form-label">대표이사</label>
										<input type="text" class="form-control" id="supply_cxfc" name="supply_cxfc" placeholder="대표이사명을 입력해주세요." value="${result.supply_cxfc}" readonly />
									 </div>
								</div>
							</div>
						</div>
					</div>
				</div>
				
			</div>
		</div>
	</div>


	<div class="col-12">
		<div class="card card-primary">
			
			<div class="row mb-2">
				<div class="col-sm-12">
					<h5>계약품목</h5>
				</div>
			</div>
			
			<div class="card-body card-primary card-outline row">

				<div class="col-lg-6">
					<div class="form-group">
						<label for="inputEmail3" class="col-form-label">아이템코드</label>
						<input type="text" class="form-control" id="product_section" name="product_section" value="${result.product_section}" readonly />
					 </div>
				</div>
				
				<%-- <div class="col-lg-6">
					<div class="form-group">
						<label for="inputEmail3" class="col-form-label">납품일 <span class="important">*</span></label>
						<input type="text" class="form-control" id="offer_date" name="offer_date" data-inputmask-alias="datetime" data-inputmask-inputformat="yyyy/mm/dd" data-mask="" im-insert="false" value="${result.offer_date }">
					 </div>
				</div> --%>
				<div class="col-lg-6">
					<div class="form-group">
						<label for="inputEmail3" class="col-form-label">납품일 <span class="important">*</span></label>
						<div class="input-group">
							<div class="input-group-prepend">
								<span class="input-group-text">
									<i class="far fa-calendar-alt"></i>
								</span>
							</div>
							<input type="text" class="form-control float-right contract_period" name="offer_date" id="offer_date" autocomplete="off" value="${result.offer_date }">
						</div>
					 </div>
				</div>
				
				<div class="col-lg-6">
					<div class="form-group">
						<label for="inputEmail3" class="col-form-label">단가</label>
						<input type="text" class="form-control" id="price" name="price" value="${result.price}" readonly />
					 </div>
				</div>
				
				<div class="col-lg-6">
					<div class="form-group">
						<label for="inputEmail3" class="col-form-label">품명</label>
						<input type="text" class="form-control" id="product_name" name="product_name" value="${result.product_name}" readonly />
					 </div>
				</div>
				
				<div class="col-lg-6">
					<div class="form-group">
						<label for="inputEmail3" class="col-form-label">금액</label>
						<input type="text" class="form-control" id="contract_amount2" name="contract_amount2" value="" readonly />
					 </div>
				</div>
				
				<div class="col-lg-6">
					<div class="form-group">
						<label for="inputEmail3" class="col-form-label">수량</label>
						<input type="text" class="form-control" id="sale_qy" name="sale_qy" value="${result.sale_qy}" readonly />
					 </div>
				</div>
				
			</div>
		</div>
	</div>


	<div class="col-12">
		<div class="card card-primary" id="inquiry_answer">
			
			<div class="row mb-2">
				<div class="col-sm-12">
					<h5>계약조건 <span class="important">*</span></h5>
				</div>
			</div>
			
			<div class="card-body card-primary card-outline row">
			
				<div class="col-lg-12">
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
		</div>
	</div>


	<div class="col-12">
		<div class="card card-primary" id="inquiry_answer">
			
			<div class="row mb-2">
				<div class="col-sm-12">
					<h5>특약사항 <span class="important">*</span></h5>
				</div>
			</div>
			
			<div class="card-body card-primary card-outline row">
			
				<div class="col-lg-12">
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
		</div>
	</div>


	<div class="col-12">
		<div class="card card-primary" id="inquiry_answer">
			
			<div class="row mb-2">
				<div class="col-sm-12">
					<h5>계약서 첨부 <span class="important">*</span></h5>
				</div>
			</div>
			
			<div class="card-body card-primary card-outline row">
			
				<div class="col-lg-12">
				<div class="form-group row">
					<div class="custom-file">
                        <input type="file" class="custom-file-input" id="filename" name="filename">
                        <label class="custom-file-label" for="filename">
                        <c:if test="${empty file}">파일 선택</c:if>
                        <c:if test="${not empty file}">${file.filerealname }</c:if>
                        </label>
                      </div>
                      </div>
				</div>
				
			</div>
			
			<div class="card-footer cont_btn_div">
				<c:choose> 
					<c:when test="${result.writer_id eq null}"> 
						<button type="submit" name="btnSubmit" class="btn btn-primary purple" value="c"> 등록</button>
					</c:when>
					<c:otherwise>
						<button type="submit" name="btnSubmit" class="btn btn-primary purple" value="u"> 수정</button>
						<button type="button" id="btnDelete" class="btn btn-primary red"> 삭제</button>
					</c:otherwise>
				</c:choose>
				<button type="button" class="btn btn-primary gray" onclick="location.href='list.ivs'"> 목록</button>
			</div>
		</div>
	</div>
</div>
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
    $('#contract_date').daterangepicker({
    	singleDatePicker: true,
    	locale :{
            format: 'YYYY/MM/DD'
        }
        });
    $('#offer_date').daterangepicker({
    	singleDatePicker: true,
    	locale :{
            format: 'YYYY/MM/DD'
        }
        });
   //Datemask yyyy/mm/dd
    /* $('#contract_date').inputmask('yyyy/mm/dd', { 'placeholder': 'yyyy/mm/dd' })
    $('#offer_date').inputmask('yyyy/mm/dd', { 'placeholder': 'yyyy/mm/dd' }) */

    //값 세팅
    	init();
    bsCustomFileInput.init();

    $.validator.setDefaults({
	    submitHandler: function () {
		   var vv = $("input[name=btnSubmit]").val();
	    	document.frm.contract_cnd.value = editor.getHtml();
	    	document.frm.special_contract.value = editor2.getHtml();
	    	if(vv == "c")
	    		document.frm.action = "save.proc";
	    	else if(vv == "u")
	    		document.frm.action = "update.proc";
	    	document.frm.submit();
	    }
	  }); 
    $('#frm').validate({
	    rules: {
	    	contract: {
		        required: true
		      },
	      contract_amount: {
		        required: true,
		        number: true
		      },
	      contract_period: {
		        required: true
		      },
	      contract_date: {
		        required: true
		      },
	      demand_addr: {
		        required: true
		      },
	      demand_bizno: {
		        required: true,
		        number: true
		      },
	      demand_cxfc: {
		        required: true
		      },
	      offer_date: {
		        required: true
		      },
	      contract_cnd: {
		        required: true
		      },
	      special_contract: {
		        required: true
		      }
	    },
	    messages: {
	    	contract: {
		        required: "계약명을 입력해주세요."
		      },
	      contract_amount: {
		        required: "총금액을 입력해주세요.",
		        number: "숫자만 입력가능 합니다."
		      },
	      contract_period: {
		        required: "계약기간을 입력해주세요."
		      },
	      contract_date: {
		        required: "계약체결일을 입력해주세요."
		      },
	      demand_addr: {
		        required: "수요자주소를 입력해주세요."
		      },
	      demand_bizno: {
	    	  	  required: "수요자 사업자 번호를 입력해주세요.",
	    	  	  number: "숫자만 입력가능 합니다."
		      },
	      demand_cxfc: {
	    	     required: "수요자대표이사명을 입력해주세요."
		      },
	      offer_date: {
		        required: "납품일을 입력해주세요."
		      },
	      contract_cnd: {
		        required: "계약조건을 입력해주세요."
		      },
	      special_contract: {
		        required: "특약사항을 입력해주세요."
		      }
	    },
	    errorElement: 'span',
	    errorPlacement: function (error, element) {
	      error.addClass('invalid-feedback');
	      element.closest('.form-group').append(error);
	    },
	    highlight: function (element, errorClass, validClass) {
	      $(element).addClass('is-invalid');
	    },
	    unhighlight: function (element, errorClass, validClass) {
	      $(element).removeClass('is-invalid');
	    }
	  });
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

		document.frm.contract_period.value = "";
		document.frm.contract_date.value = "";
		document.frm.offer_date.value = "";
	}
	
		document.frm.contract_amount2.value = (document.frm.price.value * document.frm.sale_qy.value);
	
	
	
}
</script>
</body>
</html>