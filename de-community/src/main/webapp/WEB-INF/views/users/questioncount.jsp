<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<c:choose>
<c:when test="${qCnt >= 3 and qCnt < 20}">
<h4 style="width: 100px;"> 
    <div style="float:left;"><span class="level"><img src="/img/level_gold.png" alt="" width="25px" height="25px"></span></div>
    <div style="float:right;">질문초보</div>
    <div style="clear: left;"/>
</h4>
</c:when>
<c:when test="${qCnt >= 20 and qCnt < 40}">
<h4 style="width: 100px;"> 
    <div style="float:left;"><span class="level"><img src="/img/level_gold.png" alt="" width="25px" height="25px"></span></div>
    <div style="float:right;">질문입문</div>
    <div style="clear: left;"/>
</h4>
</c:when>
<c:when test="${qCnt >= 40 and qCnt < 60}">
<h4 style="width: 100px;"> 
    <div style="float:left;"><span class="level"><img src="/img/level_gold.png" alt="" width="25px" height="25px"></span></div>
    <div style="float:right;">질문중수</div>
    <div style="clear: left;"/>
</h4>
</c:when>
<c:when test="${qCnt >= 60 and qCnt < 90}">
<h4 style="width: 100px;"> 
    <div style="float:left;"><span class="level"><img src="/img/level_gold.png" alt="" width="25px" height="25px"></span></div>
    <div style="float:right;">질문고수</div>
    <div style="clear: left;"/>
</h4>
</c:when>
<c:when test="${qCnt >= 90 and qCnt < 120}">
<h4 style="width: 100px;"> 
    <div style="float:left;"><span class="level"><img src="/img/level_gold.png" alt="" width="25px" height="25px"></span></div>
    <div style="float:right;">질문초고수</div>
    <div style="clear: left;"/>
</h4>
</c:when>
<c:when test="${qCnt >= 120 and qCnt < 150}">
<h4 style="width: 100px;"> 
    <div style="float:left;"><span class="level"><img src="/img/level_gold.png" alt="" width="25px" height="25px"></span></div>
    <div style="float:right;">질문왕</div>
    <div style="clear: left;"/>
</h4>
</c:when>
<c:when test="${qCnt >= 150 and qCnt < 200}">
<h4 style="width: 100px;"> 
    <div style="float:left;"><span class="level"><img src="/img/level_gold.png" alt="" width="25px" height="25px"></span></div>
    <div style="float:right;">질문신</div>
    <div style="clear: left;"/>
</h4>
</c:when>
<c:otherwise>
</c:otherwise>
</c:choose>
