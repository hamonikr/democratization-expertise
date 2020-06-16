<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>


<script type="text/javascript" src="https://bayzat.atlassian.net/s/d41d8cd98f00b204e9800998ecf8427e-T/-6k9c9m/100026/c/1000.718.1/_/download/batch/com.atlassian.jira.collector.plugin.jira-issue-collector-plugin:issuecollector/com.atlassian.jira.collector.plugin.jira-issue-collector-plugin:issuecollector.js?locale=en-US&collectorId=512aca2b"></script>

    <script type="text/javascript">window.ATL_JQ_PAGE_PROPS =  {
	"triggerFunction": function(showCollectorDialog) {
		//Requires that jQuery is available! 
		jQuery("#myCustomTrigger").click(function(e) {
			e.preventDefault();
			showCollectorDialog();
		});
	}};</script>
<button id="myCustomTrigger">
Give Feedback
</button>