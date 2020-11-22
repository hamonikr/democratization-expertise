<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<c:choose>
<c:when test="${aCnt >= 3 and aCnt < 20}">
<h4 style="width: 100px;"> 
    <div style="float:left;"><span class="level"><img src="/img/level_gold.png" alt="" width="25px" height="25px"></span></div>
    <div style="float:right;">답변초보</div>
    <div style="clear: left;"/>
</h4>
</c:when>
<c:when test="${aCnt >= 20 and aCnt < 40}">
<h4 style="width: 100px;"> 
    <div style="float:left;"><span class="level"><img src="/img/level_gold.png" alt="" width="25px" height="25px"></span></div>
    <div style="float:right;">답변입문</div>
    <div style="clear: left;"/>
</h4>
</c:when>
<c:when test="${aCnt >= 40 and aCnt < 60}">
<h4 style="width: 100px;"> 
    <div style="float:left;"><span class="level"><img src="/img/level_gold.png" alt="" width="25px" height="25px"></span></div>
    <div style="float:right;">답변중수</div>
    <div style="clear: left;"/>
</h4>
</c:when>
<c:when test="${aCnt >= 60 and aCnt < 90}">
<h4 style="width: 100px;"> 
    <div style="float:left;"><span class="level"><img src="/img/level_gold.png" alt="" width="25px" height="25px"></span></div>
    <div style="float:right;">답변고수</div>
    <div style="clear: left;"/>
</h4>
</c:when>
<c:when test="${aCnt >= 90 and aCnt < 120}">
<h4 style="width: 100px;"> 
    <div style="float:left;"><span class="level"><img src="/img/level_gold.png" alt="" width="25px" height="25px"></span></div>
    <div style="float:right;">답변초고수</div>
    <div style="clear: left;"/>
</h4>
</c:when>
<c:when test="${aCnt >= 120 and aCnt < 150}">
<h4 style="width: 100px;"> 
    <div style="float:left;"><span class="level"><img src="/img/level_gold.png" alt="" width="25px" height="25px"></span></div>
    <div style="float:right;">답변왕</div>
    <div style="clear: left;"/>
</h4>
</c:when>
<c:when test="${aCnt >= 150 and aCnt < 200}">
<h4 style="width: 100px;"> 
    <div style="float:left;"><span class="level"><img src="/img/level_gold.png" alt="" width="25px" height="25px"></span></div>
    <div style="float:right;">답변신</div>
    <div style="clear: left;"/>
</h4>
</c:when>
<c:otherwise>
</c:otherwise>
</c:choose>