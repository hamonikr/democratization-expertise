<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<c:choose>
<c:when test="${score >= 0 and score < 1000}">
<%-- <h4 style="width: 80px;"> 
    <div style="float:left;"><span class="level"><img src="/img/level_03.png" alt="" width="25px" height="25px"></span></div>
    <div style="float:right;">레벨1</div>
    <div style="clear: left;"/>
</h4> --%>
<h4 style="width: 80px;"> 
    <div style="float:left;">레벨1</div>
    <div style="float:right;"><span class="level"><img src="/img/level_03.png" alt="" width="25px" height="25px"></span></div>
    <div style="clear: left;"/>
</h4>
</c:when>
<c:when test="${score >= 1000 and score < 3500}">
<h4 style="width: 80px;"> 

    <div style="float:left;">레벨2</div>
    <div style="float:right;"><span class="level"><img src="/img/level_02.png" alt="" width="25px" height="25px"></span></div>
    <div style="clear: left;"/>
</h4>
</c:when>
<c:when test="${score >= 3500 and score < 7000}">
<h4 style="width: 80px;"> 
    <div style="float:left;">레벨3</div>
    <div style="float:lerightft;"><span class="level"><img src="/img/level_01.png" alt="" width="25px" height="25px"></span></div>
    <div style="clear: left;"/>
</h4>
</c:when>
<c:when test="${score >= 7000 and score < 12000}">
<h4 style="width: 80px;"> 
    <div style="float:left;">레벨4</div>
    <div style="float:right;"><span class="level"><img src="/img/level_gold.png" alt="" width="25px" height="25px"></span></div>
    <div style="clear: left;"/>
</h4>
</c:when>
<c:when test="${score >= 12000 and score < 20000}">
<h4 style="width: 80px;"> 
    <div style="float:left;">레벨5</div>
    <div style="float:right;"><span class="level"><img src="/img/level_gold.png" alt="" width="25px" height="25px"></span></div>
    <div style="clear: left;"/>
</h4>
</c:when>
<c:when test="${score >= 20000 and score < 35000}">
<h4 style="width: 80px;"> 
    <div style="float:left;">레벨6</div>
    <div style="float:right;"><span class="level"><img src="/img/level_gold.png" alt="" width="25px" height="25px"></span></div>
    <div style="clear: left;"/>
</h4>
</c:when>
<c:when test="${score >= 35000 and score < 60000}">
<h4 style="width: 80px;"> 
    <div style="float:left;">레벨7</div>
    <div style="float:right;"><span class="level"><img src="/img/level_gold.png" alt="" width="25px" height="25px"></span></div>
    <div style="clear: left;"/>
</h4>
</c:when>
<c:otherwise>
<h4 style="width: 80px;"> 
    <div style="float:left;">최고레벨</div>
    <div style="float:right;"><span class="level"><img src="/img/level_gold.png" alt="" width="25px" height="25px"></span></div>
    <div style="clear: left;"/>
</h4>
</c:otherwise>
</c:choose>
