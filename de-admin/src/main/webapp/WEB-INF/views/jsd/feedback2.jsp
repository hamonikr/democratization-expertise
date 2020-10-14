<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>


<!DOCTYPE html>
<html lang="en">


	<head>
		<meta charset="utf-8"/>
		<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
		<title>Application List - Profiled by Windup</title>

		<!-- Bootstrap -->
		<link href="reports/resources/css/bootstrap.min.css" rel="stylesheet"/>
		<link href="reports/resources/css/windup.css" rel="stylesheet" media="screen"/>
        <link href="reports/resources/img/favicon.png" rel="shortcut icon" type="image/x-icon"/>
        <style>
            body.viewAppList .apps  { margin: 0 2ex; }
            body.viewAppList .apps .appInfo {
                border-bottom: 1px solid gray;
                overflow: auto; width: 100%; /* clearing */
                margin: 1ex 0;
                padding: 1ex 0 2ex;
            }
            body.viewAppList .apps .appInfo .stats { float: left; width: 330px; padding: 0.4ex 0; }
            body.viewAppList .apps .appInfo .stats .effortPoints { float: left; width: 170px; padding: 0.3ex 0.2em 0; font-size: 33pt; }
            body.viewAppList .apps .appInfo .stats .effortPoints span { display: block; margin: auto; text-align: center; }
            body.viewAppList .apps .appInfo .stats .effortPoints .points { line-height: 1; color: rgb(41, 69, 147); }
            body.viewAppList .apps .appInfo .stats .effortPoints .legend { font-size: 7pt; }
            body.viewAppList .apps .appInfo .stats .incidentsCount { float: left; margin:  0 2ex;}
            body.viewAppList .apps .appInfo .stats .incidentsCount table tr.total td { border-top: 1px solid silver; }
            body.viewAppList .apps .appInfo .stats .incidentsCount .count { text-align: right; padding-left: 10px; }
            body.viewAppList .apps .appInfo .traits { margin-left: 340px; }
            body.viewAppList .apps .appInfo .traits .fileName { padding: 0.0ex 0em 0.2ex; font-size: 18pt; }
            body.viewAppList .apps .appInfo .traits .techs { }
        </style>
	</head>
	<body role="document" class="viewAppList">

        <!-- Navbar -->
        <div id="main-navbar" class="navbar navbar-default navbar-fixed-top">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-responsive-collapse">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
            </div>

                <div class="navbar-collapse collapse navbar-responsive-collapse">
<ul class="nav navbar-nav">
        <li class="active">
            <a href="#"><i class="glyphicon glyphicon-home"></i> All Applications</a>
        </li>

</ul>
<ul class="nav navbar-nav navbar-right">
<li>
    <a href="#" id="jiraFeedbackTrigger" class="feedback-nav-btn"><i class="glyphicon glyphicon-comment"></i> Send Feedback </a>
</li>


<script type="text/javascript" src="https://issues.jboss.org/s/f215932e68571747ac58d0f5d554396f-T/en_US-r7luaf/6346/82/1.4.16/_/download/batch/com.atlassian.jira.collector.plugin.jira-issue-collector-plugin:issuecollector/com.atlassian.jira.collector.plugin.jira-issue-collector-plugin:issuecollector.js?locale=en-US&amp;collectorId=8b9e338b"></script>
<script type="text/javascript">
window.ATL_JQ_PAGE_PROPS = {
    "triggerFunction": function(showCollectorDialog) {
        jQuery("#jiraFeedbackTrigger").click(function(e) {
            e.preventDefault();
            showCollectorDialog();
        });
    }
};
</script>
</ul>

<script type="text/javascript">
    var script   = document.createElement("script");
    script.type  = "text/javascript";
    script.src   = "resources/js/navbar.js";
    document.body.appendChild(script);
</script>                </div><!-- /.nav-collapse -->
        </div>
        <!-- / Navbar -->


        <div class="container-fluid" role="main">
            <div class="row">
                <div class="windup-bar" role="navigation">
                    <div class="container theme-showcase" role="main">
                        <img src="reports/resources/img/windup-logo.png" class="logo"/>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="page-header">
                    <h1>
                        <div class="main">Application List</div>
                        <div class="path">Profiled by Windup</div>
                    </h1>
                    <div class="desc">
                        The Application List report shows all applications which were analyzed.
                        Click on an individual application to see individual reports or you can follow
                        the global Migration Issues report.
                    </div>
                </div>
            </div>
        </div>



        <div class="container-fluid theme-showcase" role="main">

            <!-- Table -->
            <div class="apps">
		<div class="appInfo">
            <div class="stats">
                <div class="effortPoints">
                    <span class="points">83</span>
                    <span class="legend">story points</span>
                </div>
                <div class="incidentsCount">
                    <table>
                            <tr>
                                <td class="label_"> Potential Issues </td>
                                <td class="count"> 32&times; </td>
                            </tr>
                            <tr>
                                <td class="label_"> Optional </td>
                                <td class="count"> 41&times; </td>
                            </tr>
                            <tr>
                                <td class="label_"> Mandatory </td>
                                <td class="count"> 36&times; </td>
                            </tr>
                        <tr class="total">
                            <td class="label_"> <span>Total</span> </td>
                            <td class="count"> <span>109&times;</span> </td>
                        </tr>
                    </table>
                </div>
            </div>

            <div class="traits">
                <div class="fileName">
                    <a href="reports/report_index_JEE_Example_App.html">jee-example-app-1.0.0-unparsable.ear</a>
                </div>
                <div class="techs">
		<span class="label label-danger" title="IMPORTANT">
		                            WebLogic EJB XML 
</span>
		<span class="label label-danger" title="IMPORTANT">
		                            WebLogic Web XML 
</span>
		<span class="label label-info" title="INFORMATIONAL">
		                            Apache License 2.0 
</span>
		<span class="label label-info" title="INFORMATIONAL">
		                            EJB XML 2.1
</span>
		<span class="label label-info" title="INFORMATIONAL">
		                            Manifest 
</span>
		<span class="label label-info" title="INFORMATIONAL">
		                            Maven XML 
</span>
		<span class="label label-info" title="INFORMATIONAL">
		                            Properties 
</span>
		<span class="label label-info" title="INFORMATIONAL">
		                            Unknown License 
</span>
		<span class="label label-info" title="INFORMATIONAL">
		                            Web XML 2.4
</span>
                </div>
            </div>
		</div>
            </div>


        <div style="width: 100%; text-align: center">
            <a href="reports/windup_ruleproviders.html">Executed rules overview</a>
                | 
            <a href="reports/windup_freemarkerfunctions.html">Windup FreeMarker methods</a>
                |
            <a href="#" id="jiraFeedbackTriggerBottomLink">Send feedback</a>
            
            <script type="text/javascript" src="https://pms.invesume.com:8443/s/13daa8308e207cf7e1e2f92b09ba4e1e-T/-3u9lym/710002/dc612081449bde6c3e001c67ab5d6f50/2.0.30/_/download/batch/com.atlassian.jira.collector.plugin.jira-issue-collector-plugin:issuecollector/com.atlassian.jira.collector.plugin.jira-issue-collector-plugin:issuecollector.js?locale=ko-KR&collectorId=3e42cc0a"></script>
            <script type="text/javascript">
                var existingTriggerFunction = window.ATL_JQ_PAGE_PROPS.triggerFunction;
                window.ATL_JQ_PAGE_PROPS = {
                    "triggerFunction": function(showCollectorDialog) {
                        jQuery("#jiraFeedbackTriggerBottomLink").click(function(e) {
                            e.preventDefault();
                            showCollectorDialog();
                        });
                        if (existingTriggerFunction)
                            existingTriggerFunction(showCollectorDialog);
                    }
                };
            </script>
        </div>

        </div> <!-- /container -->
        <script src="reports/resources/js/jquery-1.10.1.min.js"></script>
        <script src="reports/resources/js/bootstrap.min.js"></script>
    </body>
</html>
