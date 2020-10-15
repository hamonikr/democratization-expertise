<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>
<body>
	<form name="frm" action="/sign/signupProc" method="post">
		<input type="hidden" name="${_csrf.parameterName}"
			value="${_csrf.token}" />
		<!-- Input addon -->
		<div class="card card-info">
			<div class="card-header">
				<h3 class="card-title">Input Addon</h3>
			</div>
			<div class="card-body">
				<div class="input-group mb-3">
					<div class="input-group-prepend">
						<span class="input-group-text">아이디</span>
					</div>
					<input type="text" class="form-control" id="user_id" name="user_id"
						placeholder="아이디">
				</div>
				<div class="input-group mb-3">
					<div class="input-group-prepend">
						<span class="input-group-text">비밀번호</span>
					</div>
					<input type="password" class="form-control" id="user_passwd"
						name="user_passwd" placeholder="비밀번호">
				</div>
				<div class="input-group mb-3">
					<div class="input-group-prepend">
						<span class="input-group-text">비밀번호확인</span>
					</div>
					<input type="password" class="form-control"
						id="user_passwd_confirm" name="user_passwd_confirm"
						placeholder="비밀번호확인">
				</div>
				<div class="input-group mb-3">
					<div class="input-group-prepend">
						<span class="input-group-text">이름</span>
					</div>
					<input type="text" class="form-control" id="user_nm" name="user_nm"
						placeholder="이름">
				</div>
				<div class="input-group mb-3">
					<div class="input-group-prepend">
						<span class="input-group-text">이메일</span>
					</div>
					<input type="text" class="form-control" id="user_email"
						name="user_email" placeholder="이메일">
				</div>
				<div class="input-group mb-3">
					<div class="input-group-prepend">
						<span class="input-group-text">핸드폰</span>
					</div>
					<input type="text" class="form-control" id="user_hp" name="user_hp"
						placeholder="핸드폰">
				</div>
				<div class="input-group mb-3">
					<div class="input-group-prepend">
						<span class="input-group-text">회사명</span>
					</div>
					<input type="text" class="form-control" id="user_company"
						name="user_company" placeholder="회사명">
				</div>
				<div class="col-sm-6">
					<!-- select -->
					<div class="form-group">
						<label>회원유형</label> <select class="form-control"
							id="user_auth_role" name="user_auth_role">
							<c:forEach items="${codeList}" var="data" varStatus="status">
								<option value="${data.codeValue }">${data.codeName }</option>
							</c:forEach>
						</select>
					</div>
				</div>
				<div class="card-footer">
					<button type="submit" class="btn btn-info">sign up</button>
					<button type="submit" class="btn btn-default float-right">Cancel</button>
				</div>

				<!-- <div class="input-group mb-3">
                  <input type="text" class="form-control">
                  <div class="input-group-append">
                    <span class="input-group-text">.00</span>
                  </div>
                </div>

                <div class="input-group">
                  <div class="input-group-prepend">
                    <span class="input-group-text">$</span>
                  </div>
                  <input type="text" class="form-control">
                  <div class="input-group-append">
                    <span class="input-group-text">.00</span>
                  </div>
                </div>

                <h4>With icons</h4>

                <div class="input-group mb-3">
                  <div class="input-group-prepend">
                    <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                  </div>
                  <input type="email" class="form-control" placeholder="Email">
                </div>

                <div class="input-group mb-3">
                  <input type="text" class="form-control">
                  <div class="input-group-append">
                    <span class="input-group-text"><i class="fas fa-check"></i></span>
                  </div>
                </div>

                <div class="input-group">
                  <div class="input-group-prepend">
                    <span class="input-group-text">
                      <i class="fas fa-dollar-sign"></i>
                    </span>
                  </div>
                  <input type="text" class="form-control">
                  <div class="input-group-append">
                    <div class="input-group-text"><i class="fas fa-ambulance"></i></div>
                  </div>
                </div>

                <h5 class="mt-4 mb-2">With checkbox and radio inputs</h5>

                <div class="row">
                  <div class="col-lg-6">
                    <div class="input-group">
                      <div class="input-group-prepend">
                        <span class="input-group-text">
                          <input type="checkbox">
                        </span>
                      </div>
                      <input type="text" class="form-control">
                    </div>
                    /input-group
                  </div>
                  /.col-lg-6
                  <div class="col-lg-6">
                    <div class="input-group">
                      <div class="input-group-prepend">
                        <span class="input-group-text"><input type="radio"></span>
                      </div>
                      <input type="text" class="form-control">
                    </div>
                    /input-group
                  </div>
                  /.col-lg-6
                </div>
                /.row

                <h5 class="mt-4 mb-2">With buttons</h5>

                <p>Large: <code>.input-group.input-group-lg</code></p>

                <div class="input-group input-group-lg mb-3">
                  <div class="input-group-prepend">
                    <button type="button" class="btn btn-warning dropdown-toggle" data-toggle="dropdown">
                      Action
                    </button>
                    <ul class="dropdown-menu">
                      <li class="dropdown-item"><a href="#">Action</a></li>
                      <li class="dropdown-item"><a href="#">Another action</a></li>
                      <li class="dropdown-item"><a href="#">Something else here</a></li>
                      <li class="dropdown-divider"></li>
                      <li class="dropdown-item"><a href="#">Separated link</a></li>
                    </ul>
                  </div>
                  /btn-group
                  <input type="text" class="form-control">
                </div>
                /input-group

                <p>Normal</p>
                <div class="input-group mb-3">
                  <div class="input-group-prepend">
                    <button type="button" class="btn btn-danger">Action</button>
                  </div>
                  /btn-group
                  <input type="text" class="form-control">
                </div>
                /input-group

                <p>Small <code>.input-group.input-group-sm</code></p>
                <div class="input-group input-group-sm">
                  <input type="text" class="form-control">
                  <span class="input-group-append">
                    <button type="button" class="btn btn-info btn-flat">Go!</button>
                  </span>
                </div> -->
				<!-- /input-group -->
			</div>
			<!-- /.card-body -->
		</div>
		<!-- /.card -->
	</form>
</body>