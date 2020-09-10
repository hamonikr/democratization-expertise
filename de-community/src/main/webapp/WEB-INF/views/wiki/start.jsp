<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<!-- tui editor-->
	<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
	<!-- Editor's Dependecy Style -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.48.4/codemirror.min.css"/>
	<!-- Editor's Style -->
	<link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />

<title>wiki domain</title>
</head>
<style>
.inputStyle{
	padding : 3%;
}

.menu {
    min-width: 100%;
    position: absolute;
    top: 2.5em;
    left: -1px;
    background-color: white;
    border: solid 1px silver;
    border-top-width: 0;
    clear: both;
    text-align: left;
    display: none;
    z-index: 1;
}
.mw-body {
    margin-left: 10em;
    padding: 1em;
    border: 1px solid #a7d7f9;
    border-right-width: 0;
    margin-top: -1px;
    background-color: #ffffff;
    color: #252525;
    direction: ltr;
}
#mw-head-base {
    margin-top: -5em;
    margin-left: 10em;
    height: 5em;
}
#mw-head {
    position: absolute;
    top: 0;
    right: 0;
    width: 100%;
}
#mw-panel {
    font-size: inherit;
    position: absolute;
    top: 160px;
    padding-top: 1em;
    width: 10em;
    left: 0;
}

#mw-page-base {
    height: 5em;
    background-position: bottom left;
    background-repeat: repeat-x;
    background-image: url(/skins/VectorV2/images/page-fade.png?1d168);
    background-color: #f6f6f6;
    background-image: -webkit-gradient(linear,left top,left bottom,color-stop(50%,#ffffff),color-stop(100%,#f6f6f6));
    background-image: -webkit-linear-gradient(top,#ffffff 50%,#f6f6f6 100%);
    background-image: -moz-linear-gradient(top,#ffffff 50%,#f6f6f6 100%);
    background-image: linear-gradient(#ffffff 50%,#f6f6f6 100%);
    background-color: #ffffff;
}

#mw-head-base {
    margin-top: -5em;
    margin-left: 10em;
    height: 5em;
}
li.selected {
    background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAABkAQAAAABvV2fNAAAADElEQVR4AWNoGB4QAInlMgFKeRKBAAAAAElFTkSuQmCC);
    background-image: url(/skins/VectorV2/images/tab-current-fade.png?22887)!ie;
}
.vectorTabs {
    float: left;
    height: 2.5em;
    background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAAuCAIAAABmjeQ9AAAAQ0lEQ…OcUegfarWjP3ojZvEzxs6j+nygmo+zzsk79nY+tOxdEhlf3UHVgUFrVwAAAABJRU5ErkJggg==);
    background-image: url(/skins/VectorV2/images/tab-break.png?09d4b)!ie;
    background-position: bottom left;
    background-repeat: no-repeat;
    padding-left: 1px;
}
.mw-body .mw-indicators {
    float: right;
    line-height: 1.6;
    font-size: 0.875em;
    position: relative;
    z-index: 1;
}
.emptyPortlet {
    display: none;
}
#mw-navigation h2 {
    position: absolute;
    top: -9999px;
}

.vectorMenu {
    direction: ltr;
    float: left;
    cursor: pointer;
    position: relative;
}
.vectorMenu h3 {
    float: left;
    background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAAuCAIAAABmjeQ9AAAAQ0lEQ…OcUegfarWjP3ojZvEzxs6j+nygmo+zzsk79nY+tOxdEhlf3UHVgUFrVwAAAABJRU5ErkJggg==);
    background-image: url(/skins/VectorV2/images/tab-break.png?09d4b)!ie;
    background-repeat: no-repeat;
    background-position: bottom right;
    font-size: 1em;
    height: 2.5em;
    padding-right: 1px;
    margin-right: -1px;
}
#left-navigation {
    float: left;
    margin-left: 10em;
    margin-top: 2.5em;
    margin-bottom: -2.5em;
    display: inline;
}
#right-navigation {
    float: right;
    margin-top: 2.5em;
}

#p-personal {
    position: absolute;
    top: 0.33em;
    right: 0.75em;
    z-index: 100;
}

#p-personal li {
    line-height: 1.125em;
    float: left;
    margin-left: 0.75em;
    margin-top: 0.5em;
    font-size: 0.75em;
    white-space: nowrap;
}
span {
    display: block;
    font-size: 0.8em;
    padding-left: 0.7em;
    padding-top: 1.375em;
    margin-right: 20px;
    font-weight: normal;
    color: #4d4d4d;
}
ul li {
    line-height: 1.125em;
    margin: 0;
    padding: 0.25em 0;
    font-size: 0.75em;
    word-wrap: break-word;
}

a {
    text-decoration: none;
    color: #0645ad;
    background: none;
}
#p-logo {
    position: absolute;
    top: -160px;
    left: 0;
    width: 10em;
    height: 160px;
}
#footer {
    margin-left: 10em;
    margin-top: 0;
    padding: 0.75em;
    direction: ltr;
}

.portal {
    margin: 0 0.6em 0 0.7em;
    padding: 0.25em 0;
    direction: ltr;
    background-position: top left;
    background-repeat: no-repeat;
    background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAIwAAAABCAAAAAAphRnkAAAAJ0lEQVQIW7XFsQEAIAyAMPD/b7uLWz8wS5youFW1UREfiIpH1Q2VBz7fGPS1dOGeAAAAAElFTkSuQmCC);
    background-image: url(/skins/VectorV2/images/portal-break.png?3ea1b)!ie;
}
</style>

 <body >
 <div id="mw-page-base" class="noprint"></div>
 <div id="mw-head-base" class="noprint"></div>
  <!-- start of contents  -->   
    <div id="content" class="mw-body" role="main">
    <div class="mw-indicators mw-body-content"></div>
 		<div class="row">
 			<div class="col-md-10" data-placeholder="WikiPlaceholder-HelpCenterIntro">
				<p><br></p>
					<h2>시작하기</h2><br>
					<p>
					 <a href="">DE 커뮤니티 시작하기!</a><br>
					  하모니카 커뮤니티에 오신것을 환영합니다. 하모니카 커뮤니티 이용에 관련된 정보를 제공합니다.
					</p>	
					<p><br>
						<a href="">※자주 묻는 질문들※ </a> <br>
					</p>
					<ul>
					  <li>
					  <svg aria-hidden="true" class="svg-icon iconTack" width="18" height="18" viewBox="0 0 18 18"><path d="M6.79 12.67l3.53 3.53a6 6 0 001.18-6.83l2.03-2.03A4 4 0 0018 5.5L12.53.03A4 4 0 0010.7 4.5L8.67 6.54a6 6 0 00-6.83 1.18l3.53 3.53-3.18 3.18-1.77 3.19 3.18-1.77 3.19-3.18z"></path></svg>     
					  <a href="">질문을 어떻게 묻고 답하는가?</a></li>
					  <li>
					    <svg aria-hidden="true" class="svg-icon iconTack" width="18" height="18" viewBox="0 0 18 18"><path d="M6.79 12.67l3.53 3.53a6 6 0 001.18-6.83l2.03-2.03A4 4 0 0018 5.5L12.53.03A4 4 0 0010.7 4.5L8.67 6.54a6 6 0 00-6.83 1.18l3.53 3.53-3.18 3.18-1.77 3.19 3.18-1.77 3.19-3.18z"></path></svg>     
					  	<a href="">왜 내 평판이 올랐는가/떨어졌는가?</a></li>
					  <li>
					   <svg aria-hidden="true" class="svg-icon iconTack" width="18" height="18" viewBox="0 0 18 18"><path d="M6.79 12.67l3.53 3.53a6 6 0 001.18-6.83l2.03-2.03A4 4 0 0018 5.5L12.53.03A4 4 0 0010.7 4.5L8.67 6.54a6 6 0 00-6.83 1.18l3.53 3.53-3.18 3.18-1.77 3.19 3.18-1.77 3.19-3.18z"></path></svg>     
					  	<a href="">내 질문이 중복이 아니라고 생각될 때 나는 어떻게 할 수 있을까?</a></li>
					  <li>
					    <svg aria-hidden="true" class="svg-icon iconTack" width="18" height="18" viewBox="0 0 18 18"><path d="M6.79 12.67l3.53 3.53a6 6 0 001.18-6.83l2.03-2.03A4 4 0 0018 5.5L12.53.03A4 4 0 0010.7 4.5L8.67 6.54a6 6 0 00-6.83 1.18l3.53 3.53-3.18 3.18-1.77 3.19 3.18-1.77 3.19-3.18z"></path></svg>     
					  	<a href="">"우리는 더 이상 이 계정에서 질문/대답을 받지 않는다"를 받을 때 어떻게 해야 하는가?</a></li>
					</ul>
					<div>
					   	<a href="/wiki/createHelp">[helps 작성하기]</a>
					</div>
				<hr>
			</div>
		
 		</div>
 		<div class="row" data-placeholder="WikiPlaceholder-HelpCenterIntro">
 		<div class="col">		
 			<p><br></p>
					<h2>Tags</h2>	
			<p><br></p>
		</div>
		</div>
		<div class="row">
			<div class="col-md-3">
			<hr>		
				<ul>
					  <li> JavaScript</li>
					  <li> Java</li>
					  <li> Jquery</li>
				</ul>	  
			</div>
			<div class="col-md-3" style="margin-left:5%">		
			<hr>		
				<ul>
					  <li> JavaScript</li>
					  <li> Java</li>
					  <li> Jquery</li>
				</ul>	 				
			</div>
			<div class="col-md-3" style="margin-left:5%">		
				<hr>		
				<ul>
					  <li> JavaScript</li>
					  <li> Java</li>
					  <li> Jquery</li>
				</ul>	 						
			</div>
 		 <div>    
     </div>
 	</div>
    	<a href="/wiki/createTag">[Tag 작성하기]</a>
  </div>  
  <!-- end of contents  -->   
  <!-- start of  nav -->
 <div id = "mv-navigation">
 <!-- right-top nav bar -->
  <div id="mw-head">
		<div id="right-navigation">
			<div id="p-views" role="navigation" class="vectorTabs" aria-labelledby="p-views-label">
				<ul>
					<li id="ca-viewsource">
						<span>
							<a href="" title="이 문서가 보호되어 있습니다. 문서의 원본을 볼 수 있습니다. [alt-shift-e]" accesskey="e">[원본 보기]</a>
						</span>
					</li>
					<li id="ca-history" class="collapsible">
						<span>
							<a href="" title="문서의 과거 판 [alt-shift-h]" accesskey="h">[히스토리 보기]</a>
						</span>
					</li>
				</ul>
			</div>
		
			<!-- <div id="p-search" role="search">				
				<form action="/" id="searchform">
					<div id="simpleSearch">
						<input type="search" name="search" placeholder="위키 검색" title="검색 [alt-shift-f]" accesskey="f" id="searchInput" tabindex="1" autocomplete="off">
						<input type="hidden" value="특수:검색" name="title">
						<input type="submit" name="go" value="보기" title="이 이름의 문서가 존재하면 그 문서로 바로 가기" id="searchButton" class="searchButton">	
					</div>
				</form>
			</div>
 -->		</div>
	</div>

  </div>  

</body>

<script>

  </script>


</html>