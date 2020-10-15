<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>

<body>

	<form name="frm" id="frm" action="/signup/bizEditForm.proc" method="POST">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />


		<div class="row" id="content">

			<div id="input_div" class="col-12 " style="margin-top: .75rem;">
				<div class="callout callout-info row ">
					<div class="col-6">
						<h5>기업정보관리</h5>
					</div>
					<div class="col-6">
						<span class="float-right  "><a href="/main/index">Home</a> / 회원정보관리 / 기업정보관리</span>
					</div>
				</div>
			</div>


			<div id="input_div" class="col-12">

				<div class="card">
					<div class="row mb-2">
						<div class="col-sm-12">
							<h5>기업정보</h5>
						</div>
					</div>

					<div class="card-body row">

						<div class="col-lg-4">
							<div class="form-group">
								<label for="inputEmail3" class="col-form-label">
									업체명(한글) <span class="important">*</span>
								</label>
								<input type="text" placeholder="업체명(한글)" class="form-control" id="biznm" name="biznm" value="${bizResult.biznm}" readonly onfocus="this.blur()">
							</div>
						</div>

						<div class="col-lg-4">
							<div class="form-group">
								<label for="inputEmail3" class="col-form-label">
									업체명(영문) <span class="important">*</span>
								</label>
								<input type="text" placeholder="업체명(영문)" class="form-control" id="biznm_en" name="biznm_en" value="${bizResult.biznm_en}" readonly onfocus="this.blur()">
							</div>
						</div>

						<div class="col-lg-4">
							<div class="form-group">
								<label for="inputEmail3" class="col-form-label">
									사업자번호 <span class="important">*</span>
								</label>
								<input type="text" placeholder="사업자번호" class="form-control" id="bizno" name="bizno" value="${bizResult.bizno}" readonly onfocus="this.blur()">
							</div>
						</div>

						<div class="col-lg-4">
							<div class="form-group">
								<label for="inputEmail3" class="col-form-label">업종</label>
								<input type="text" placeholder="업종" class="form-control" id="biztype" name="biztype" value="${bizResult.biztype}" maxlength="50">
							</div>
						</div>

						<div class="col-lg-4">
							<div class="form-group">
								<label for="inputEmail3" class="col-form-label">업태</label>
								<input type="text" placeholder="업태" class="form-control" id="bizkind" name="bizkind" value="${bizResult.bizkind}" maxlength="50">
							</div>
						</div>

						<div class="col-lg-4">
							<div class="form-group">
								<label for="inputEmail3" class="col-form-label">사업자구분</label>
								<select id="biz_auth_role" name="selected_biz_auth_role" class="form-control">
									<option value='1' disabled <c:if test="${bizResult.biz_auth_role eq '1' }"> selected </c:if>>총판사</option>
									<option value='2' disabled <c:if test="${bizResult.biz_auth_role eq '2' }"> selected </c:if>>파트너사</option>
									<option value='3' disabled <c:if test="${bizResult.biz_auth_role eq '3' }"> selected </c:if>>일반</option>
								</select>
							</div>
						</div>

						<div class="col-lg-4">
							<div class="form-group">
								<label for="inputEmail3" class="col-form-label">대표자명</label>
								<input type="text" placeholder="대표자명" class="form-control" id="rprsnt_nm" name="rprsnt_nm" value="${bizResult.rprsnt_nm}" maxlength="30">
							</div>
						</div>

						<div class="col-lg-4">
							<div class="form-group">
								<label for="inputEmail3" class="col-form-label">전화번호</label>
								<div class="tel_div row">
									<input type="tel" class="form-control filter col-lg-3 inputs" placeholder="000" id="tele1" name="tele1" value="${bizResult.tele1}" maxlength=3 onKeyUp="chk_Number(this);"> 
									<span class="col-lg-1" > - </span> 
									<input type="tel" class="form-control filter col-lg-3_5 inputs" placeholder="0000" id="tele2" name="tele2" value="${bizResult.tele2}" maxlength=4 onKeyUp="chk_Number(this);"> 
									<span class="col-lg-1"> - </span> 
									<input type="tel" class="form-control filter col-lg-3_5" placeholder="0000" id="tele3" name="tele3" value="${bizResult.tele3}" maxlength=4 onKeyUp="chk_Number(this);" >
								</div>
							</div>
						</div>

						<div class="col-lg-4">
							<div class="form-group">
								<label for="inputEmail3" class="col-form-label">팩스</label>
								<div class="tel_div row">
									<input type="tel" class="form-control filter col-lg-3 inputs" placeholder="000"  id="fax1" name="fax1" value="${bizResult.fax1}" maxlength=3 onKeyUp="chk_Number(this);"> 
									<span class="col-lg-1"> - </span> 
									<input type="tel" class="form-control filter col-lg-3_5 inputs" placeholder="0000" id="fax2" name="fax2" value="${bizResult.fax2}" maxlength=4 onKeyUp="chk_Number(this);"> 
									<span class="col-lg-1"> - </span> 
									<input type="tel" class="form-control filter col-lg-3_5 inputs" placeholder="0000" id="fax3" name="fax3" value="${bizResult.fax3}" onKeyUp="chk_Number(this);" maxlength=4>
								</div>
							</div>
						</div>

						<div class="col-lg-6">
							<div class="form-group">
								<label for="inputEmail3" class="col-form-label">주소</label>
								<input type="text" placeholder="주소" class="form-control" id="addr1" name="addr1" value="${bizResult.addr1}" maxlength="80">
							</div>
						</div>

						<div class="col-lg-6">
							<div class="form-group">
								<label for="inputEmail3" class="col-form-label">상세주소</label>
								<input type="text" placeholder="상세주소" class="form-control" id="addr2" name="addr2" value="${bizResult.addr2}" maxlength="30">
							</div>
						</div>
						
					</div>

					<div class="card-footer row">
						<!-- page number -->
						<ul class="pagination justify-content-left m-0 col-6">
							<%-- <ui:pagination paginationInfo = "${paginationInfo}" type="text" jsFunction="linkPage"/> --%>
						</ul>
						<div class="col-6 cont_btn_div">
							<button type="button" class="btn btn-primary purple" onclick="saveEditConfirm()">저장</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</form>
</body>


<script type="text/javascript">
  //수정한 값 저장하기       
  function saveEditConfirm() {
    if (confirm( "저장 하시겠습니까?" ) == true) {
      document.frm.submit();
      alert( "저장이 완료되었습니다!" );
    } else
      return;
  }


  // 인풋박스 커서 자동이동  
  $( function() {
    $( ".inputs" ).keyup( function() {
      var charLimit = $( this ).attr( "maxlength" );
      if (this.value.length >= charLimit) {
        $( this ).next( '.inputs' ).focus();
        return false;
      }
    } );
  } );
  
  function chk_Number(object) {
    $( object ).keyup( function() {
      $( this ).val( $( this ).val().replace( /[^0-9]/g, "" ) );
    } );
  }
</script>
