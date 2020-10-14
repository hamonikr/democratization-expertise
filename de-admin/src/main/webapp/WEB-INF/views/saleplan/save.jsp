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

<style>
.card-body > .row { margin: 0 }
.col-lg-6 .form-group .form-control { height: auto }
</style>

<body>

<form id="frm" name="frm" method="post">
<c:if test="${result ne null }">
<input type="hidden" name="bizcd" id="bizcd" value="${result.bizcd}" />
<input type="hidden" name="seq" id="seq" value="${result.seq}" />
<input type="hidden" name="writer_id" id="writer_id" value="${result.writer_id }"/>
<input type="hidden" name="writer_name" id="writer_name" value="${result.writer_name }"/>
</c:if>
<c:if test="${result eq null }">
<input type="hidden" name="bizcd" id="bizcd" value="${userSession.bizcd}" />
<input type="hidden" name="writer_id" id="writer_id" value="${userSession.username }"/>
<input type="hidden" name="writer_name" id="writer_name" value="${userSession.user_nm }"/>
<input type="hidden" name="p_seq" id="p_seq" value="${p_seq}" />
</c:if>
<!-- 스프링 시큐리티 form에 추가 해줘야함. -->
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

<div class="row">

	<div id="input_div" class="col-12 " style="margin-top: .75rem;">
		<div class="callout callout-info row ">
			<div class="col-6">
				<h5>판매계획서 등록</h5>
			</div>
			<div class="col-6">
				<span class="float-right  "><a href="/main/index">Home</a> / 비즈니스 / 판매계획서 등록</span>
			</div>
		</div>
	</div>
	

<!-- general form elements -->
	<div class="col-12">
            <div class="card card-primary">
            	
            	<div class="row mb-2">
					<div class="col-sm-12">
						<h5>판매계획서 등록</h5>
					</div>
				</div>
            	
                <div class="card-body card-primary card-outline row">
                
                	<div class="col-lg-12">
		                  <div class="form-group">
		                    <label for="subject">제목 <span class="important">*</span></label>
		                    <input type="text" class="form-control" id="subject" name="subject" placeholder="판매계획명을 입력해주세요." value="${result.subject}" />
		                  </div>
	                  </div>
                      
					<div class="col-lg-3">
	                   <div class="form-group">
	                    	<label for="instt_name">고객사명 <span class="important">*</span></label>
	                      <input type="text" class="form-control" placeholder="고객사명를 입력해주세요." name="instt_name" id="instt_name" value="${result.instt_name}" />
	                  </div>
                  </div>
                  
                  <div class="col-lg-3">
	                  <div class="form-group">
	                    <label for="price">소비자 가격 <span class="important">*</span></label>
	                    <c:if test="${result ne null }">
	                          <input type="number" class="form-control" placeholder="가격을 입력해 주세요." name="price" id="price" value="${result.price}" readonly/>
	                          </c:if>
							 <c:if test="${result eq null }">
	                          <input type="number" class="form-control" placeholder="가격을 입력해 주세요." name="price" id="price" value="${price}" <c:if test="${price ne null }"> readonly </c:if>/>
	                          </c:if>
	                  </div>
                  </div>
                  
                  <div class="col-lg-3">
	                  <div class="form-group">
	                    <label for="sale_qy">판매수량 <span class="important">*</span></label>
	                    <input type="number" name="sale_qy" id="sale_qy" class="form-control" placeholder="판매수량을 입력해주세요." value="${result.sale_qy}" <c:if test="${result.consent eq 1 }"> readonly </c:if>/> 
	                  </div>
                  </div>
                  
                  <div class="col-lg-3">
	                  <div class="form-group">
	                    <label for="discount">할인요율</label>
								<input type="number" name="discount" id="discount" class="form-control" value="5"  readonly />
	                  </div>
                  </div>
				
					<div class="col-lg-6">
						<div class="form-group">
							<label for="product_section">제품분류</label>
							<div class="form-control">
								<c:forEach items="${getProduct }" var="item" varStatus="status">
									<div class="custom-control custom-radio">
										<input class="custom-control-input" type="radio" id="${status.count }" name="product_section" value="${item.productSn }" <c:if test="${result.product_section eq item.productSn }">checked</c:if>>
										<label class="custom-control-label" for="${status.count }">${item.subject }</label>
									</div>
								</c:forEach>
							</div>
						</div>
					</div>

					<div class="col-lg-6">
						<div class="form-group">
							<label for="instt_section">기관분류</label>
				
							<div class="form-control">
								<div class="custom-control custom-radio">
									<input class="custom-control-input" type="radio" id="instt_section1" name="instt_section" value="public" <c:if test="${result.instt_section eq 'public' }">checked</c:if>>
									<label class="custom-control-label" for="instt_section1">공공기관</label>
								</div>
				
								<div class="custom-control custom-radio">
									<input class="custom-control-input" type="radio" id="instt_section2" name="instt_section" value="private" <c:if test="${result.instt_section eq 'private' }">checked</c:if>>
									<label class="custom-control-label" for="instt_section2">민간기업</label>
								</div>
							</div>
						</div>
					</div>
                  
                  <div class="col-lg-12">
	                  <div class="form-group">
	                    <label for="content">내용 <span class="important">*</span></label>
	                     <input type="hidden" name="content" id="content" value="">
	                                        <div class="code-html">
							                <div id="editSection">${result.content }</div> 
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

    $.validator.setDefaults({
	    submitHandler: function () {
	    	value_chk();
		   var vv = $("input[name=btnSubmit]").val();
	    	document.frm.content.value = editor.getHtml();
	    	if(vv == "c")
	    		document.frm.action = "save.proc";
	    	else if(vv == "u")
	    		document.frm.action = "update.proc";
	    	document.frm.submit();
	    }
	  }); 
    $('#frm').validate({
	    rules: {
	    	subject: {
		        required: true
		      },
	    	price: {
		        required: true,
		        number: true
		      },
	      sale_qy: {
		        required: true,
		        number: true
		      },
	      instt_name: {
		        required: true
		      },
	      instt_section: {
		        required: true
	      	  },
	      	product_section: {
		        required: true
	      	  },
	    	content: {
		        required: true
		      }
	    },
	    messages: {
	    	subject: {
		        required: "제목을 입력 해주세요."
		      },
	    	price: {
		        required: "가격을 입력 해주세요.",
		        number: "숫자만 입력 가능합니다."
		      },
	      sale_qy: {
		        required: "판매수량을 입력 해주세요.",
		        number: "숫자만 입력 가능합니다."
		      },
	      instt_name: {
		        required: "고객사명을 입력 해주세요."
		      },
	      instt_section: {
		        required: "기관분류를 선택 해주세요."
	      	  },
	      	product_section: {
		        required: "제품분류를 선택 해주세요."
	      	  },
	    	content: {
		        required: "내용을 입력 해주세요."
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
	value_chk();
	document.frm.content.value = editor.getHtml();
	document.frm.action = "save.proc";
	document.frm.submit();
}

function fnUpdate() {
	document.frm.content.value = editor.getHtml();
	document.frm.action = "update.proc";
	document.frm.submit();
}

function fnDelete() {
	document.frm.action = "delete.proc";
	document.frm.submit();
}
function value_chk(){
	var instt_se = $('input:radio[name="instt_section"]:checked').val();
	var product_se = $('input:radio[name="product_section"]:checked').val();
	document.frm.instt_section.value = instt_se;
	document.frm.product_section.value = product_se;
}
</script>
</body>
</html>