<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>




<!-- <script src="../node_modules/jquery/dist/jquery.min.js"></script>
    <script src="assets/js/jquery.min.js"></script> -->
<!-- Automatically provides/replaces `Promise` if missing or broken. -->
<script src="https://cdn.jsdelivr.net/npm/es6-promise@4/dist/es6-promise.js"></script>
<script src="https://cdn.jsdelivr.net/npm/es6-promise@4/dist/es6-promise.auto.js"></script>

<!-- Minified version of `es6-promise-auto` below. -->
<script src="https://cdn.jsdelivr.net/npm/es6-promise@4/dist/es6-promise.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/es6-promise@4/dist/es6-promise.auto.min.js"></script>




<!-- jQuery -->
<script src="/plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- AdminLTE App -->
<script src="/dist/js/adminlte.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="/dist/js/demo.js"></script>
<script src="/dist/js/common.js"></script>
<!-- <script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script> -->

<style>
#summary /* The "id" of the "Summary" text box */
{
  max-width: 100px; /* This line will set the length of the text box to 100px */
}

#priority-single-select /* The "id" of the "Priority" text box */
{
  max-width: 100px; /* This line will set the length of the text box to 100px */
}
</style>
<body>



   
<script type="text/javascript" src="https://pms.invesume.com:8443/s/13daa8308e207cf7e1e2f92b09ba4e1e-T/-3u9lym/710002/dc612081449bde6c3e001c67ab5d6f50/2.0.30/_/download/batch/com.atlassian.jira.collector.plugin.jira-issue-collector-plugin:issuecollector/com.atlassian.jira.collector.plugin.jira-issue-collector-plugin:issuecollector.js?locale=ko-KR&collectorId=0257d3bf"></script>



	<script type="text/javascript">
// 	window.ATL_JQ_PAGE_PROPS =  {
// 	    "triggerFunction": function(showCollectorDialog) {
// 	        setTimeout(function() {
// 	            if(showCollectorDialog !== undefined)
// 	                showCollectorDialog();
// 	        }, 100);
// 	    }
// 	};

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
					var textarea= document.createElement('textarea');
				  textarea.setAttribute('style', 'height: 56px;');
				});
			},
			"fieldValues": {
				summary : 'Plugin request for <<plugin name>>',
			   	// components: '33023',
			   	description: 'Description: <<briefly describe what the plugin does>>\n' +
			        	             'Plugin URL: \n' +
			        	             'Vendor URL: \n' +
			        	             'Product: <<Jira, Confluence, etc>>\n' +
			        	             'Requesting LOB: \n' +
			        	             'Requestor: \n' + 
			        	             'Benefits: \n'
			}
			
}
$(document).ready(function() {
  $(".form-body textarea#description").css('height','50px');
});
	
//     window.ATL_JQ_PAGE_PROPS = {
//       "triggerFunction" : function(showCollectorDialog) {
//         //Requires that jQuery is available! 
//         //$("#request_support").trigger("click");
       
//         document.getElementById( "request_support" ).addEventListener( "click", function(e) {
//           e.preventDefault();
//           showCollectorDialog();
//         } );
//       }
//     };
    
    
//     window.ATL_JQ_PAGE_PROPS.triggerFunction;
// window.ATL_JQ_PAGE_PROPS = $.extend(window.ATL_JQ_PAGE_PROPS, {
// 	// ==== custom trigger function ====
// 	triggerFunction : function( showCollectorDialog ) {
// 		$('#request_support').on( 'click', function(e) {
// 			e.preventDefault();
// 			showCollectorDialog();
// 		});
 
// 		// add any other custom triggers for the issue collector here
// 	}
// });

// window.ATL_JQ_PAGE_PROPS = $.extend(window.ATL_JQ_PAGE_PROPS, {

// 	// ==== custom trigger function ====
// 	triggerFunction : function( showCollectorDialog ) {
// 		$('#request_support').on( 'click', function(e) {
// 			e.preventDefault();
// 			showCollectorDialog();
// 		}); 
// 	},
// 	// ==== we add the code below to set the field values ====
// 	fieldValues: {
//  		summary : 'This is the default summary value',
// 		description : 'The font doesn\'t quite look right',
//  		priority : '2'
// 	}					
// });

  </script>

<!-- 	<input class="btsbtn" id="request_support" name="request_support" type="button" value="기술지원 요청하기" /> -->


</body>
