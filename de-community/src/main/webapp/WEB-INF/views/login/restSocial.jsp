<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>

 <!-- jquery-validation -->
  <script src="/plugins/jquery-validation/additional-methods.min.js"></script>
  <script src="/plugins/jquery-validation/jquery.validate.min.js"></script> 


<form action="/login/socialDataPage" method="post">
  <input type="text" name="output" id="output" value="Y">
	<input type="text" name="userid" id="userid" value="${vo.userid }">
	<input type="text" name="username" id="username" value="${vo.username }">
  <input id="submit_button" name="commit" type="submit" value="Enter" />
</form>
<input type="buttion" id="btn_id" value="aa">

<script type="text/javascript">
  $("form").submit(function() {
    console.log("Triggered submit handler in jquery");
  })

function postForm(path, params, method) {
    method = method || 'post';

    var form = document.createElement('form');
    form.setAttribute('method', method);
    form.setAttribute('action', path);

    for (var key in params) {
        if (params.hasOwnProperty(key)) {
            var hiddenField = document.createElement('input');
            hiddenField.setAttribute('type', 'hidden');
            hiddenField.setAttribute('name', key);
            hiddenField.setAttribute('value', params[key]);

            form.appendChild(hiddenField);
        }
    }

    document.body.appendChild(form);
    form.submit();
}

// postForm('login/socialDataPage', {userid: ${vo.userid}, username: ${vo.username}});

$(document).ready(function(){

// postForm('/login/socialDataPage', {userid: $("#userid").val()});

// 	 var form = document.createElement('form');
//      var objs;
//      objs = document.createElement('input');
//      objs.setAttribute('type', 'hidden');
//      objs.setAttribute('name', 'userid');      // 받을 네이밍
//      objs.setAttribute('value', aa);       // 넘길 파라메터
//      form.appendChild(objs);
//      form.setAttribute('method', 'post');
//      form.setAttribute('action', "/login/socialDataPage");      // URL
//      document.body.appendChild(form);
//      form.submit();
      
      
	// ok
	
	location.href = "/login/socialDataPage?userid=${vo.userid}&userno=${vo.userno}&username=${vo.username}" ;
// location.href = "/login/socialDataPage?userid=";
});

</script>

