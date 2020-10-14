<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>




<!-- <script src="https://cdn.jsdelivr.net/npm/es6-promise@4/dist/es6-promise.js"></script> -->
<!-- <script src="https://cdn.jsdelivr.net/npm/es6-promise@4/dist/es6-promise.auto.js"></script> -->
<!-- <script src="https://cdn.jsdelivr.net/npm/es6-promise@4/dist/es6-promise.min.js"></script> -->
<!-- <script src="https://cdn.jsdelivr.net/npm/es6-promise@4/dist/es6-promise.auto.min.js"></script> -->


<!-- <script src="/plugins/jquery/jquery.min.js"></script> -->
<!-- <script src="/plugins/bootstrap/js/bootstrap.bundle.min.js"></script> -->
<!-- <script src="/dist/js/adminlte.min.js"></script> -->
<!-- <script src="/dist/js/demo.js"></script> -->
<!-- <script src="/dist/js/common.js"></script> -->

<body style="margin:0;">




<script type="text/javascript" src="https://pms.invesume.com:8443/s/13daa8308e207cf7e1e2f92b09ba4e1e-T/-3u9lym/710002/dc612081449bde6c3e001c67ab5d6f50/2.0.30/_/download/batch/com.atlassian.jira.collector.plugin.jira-issue-collector-plugin:issuecollector/com.atlassian.jira.collector.plugin.jira-issue-collector-plugin:issuecollector.js?locale=ko-KR&collectorId=3e42cc0a"></script>



	<script type="text/javascript">

window.ATL_JQ_PAGE_PROPS =  {
			"triggerFunction": function(showCollectorDialog) {
				jQuery(document).ready(function(){
					setTimeout(function(){
						console.log("opening");
						showCollectorDialog();
						$(".atlwdg-popup").css("margin", "0");
						$(".atlwdg-blanket").css("width", "0");
// 						$("#atlwdg-frame >form.aui .textarea,").css("height", "50px");
// 						var cssLink = document.createElement("atlwdg-frame");
						
						
					}, 50);
				});
			},
			"fieldValues": {
				summary : '제안이나 사용시 불편사항등의 제목을 입력해주세요.',
			   	// components: '33023',
			   	description: 'Description: \n 제안이나 불편사항등에 대한 제세한 설명을 입력해주세\n' +
			        	             '관련 스크린샷 또는 파일을 업로드해 주시 \n' +
			        	             '요청하신 사항을 처리하는데 도움이 됩니다.  \n' +
			        	             '업로드 용량은 100M입니다.\n'
			}
			
}

$(document).ready(function(){
// document.getElementsByClassName('cancel').addEventListener('click', alert(1));
  $("iframe").load(function(){
    $(this).contents().on("mousedown, mouseup, click", function(){
        alert("Click detected inside iframe.");
    });
});
});
  </script>


</body>
