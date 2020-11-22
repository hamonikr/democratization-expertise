<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<c:choose>
<c:when test="${user.usersDetail.maxloginday >= 0 and user.usersDetail.maxloginday < 1000}">
<h4 style="width: 80px;"> 
    <div style="float:left;"><span class="level"><img src="/img/level_03.png" alt="" width="25px" height="25px"></span></div>
    <div style="float:right;">초보</div>
    <div style="clear: left;"/>
</h4>
</c:when>
<c:when test="${score >= 1000 and score < 3500}">
<h4 style="width: 80px;"> 
    <div style="float:left;"><span class="level"><img src="/img/level_02.png" alt="" width="25px" height="25px"></span></div>
    <div style="float:right;">입문</div>
    <div style="clear: left;"/>
</h4>
</c:when>
<c:when test="${score >= 3500 and score < 7000}">
<h4 style="width: 80px;"> 
    <div style="float:left;"><span class="level"><img src="/img/level_01.png" alt="" width="25px" height="25px"></span></div>
    <div style="float:right;">중수</div>
    <div style="clear: left;"/>
</h4>
</c:when>
<c:when test="${score >= 7000 and score < 12000}">
<h4 style="width: 80px;"> 
    <div style="float:left;"><span class="level"><img src="/img/level_gold.png" alt="" width="25px" height="25px"></span></div>
    <div style="float:right;">고수</div>
    <div style="clear: left;"/>
</h4>
</c:when>
<c:when test="${score >= 12000 and score < 20000}">
<h4 style="width: 80px;"> 
    <div style="float:left;"><span class="level"><img src="/img/level_gold.png" alt="" width="25px" height="25px"></span></div>
    <div style="float:right;">초고수</div>
    <div style="clear: left;"/>
</h4>
</c:when>
<c:when test="${score >= 20000 and score < 35000}">
<h4 style="width: 80px;"> 
    <div style="float:left;"><span class="level"><img src="/img/level_gold.png" alt="" width="25px" height="25px"></span></div>
    <div style="float:right;">왕</div>
    <div style="clear: left;"/>
</h4>
</c:when>
<c:when test="${score >= 35000 and score < 60000}">
<h4 style="width: 80px;"> 
    <div style="float:left;"><span class="level"><img src="/img/level_gold.png" alt="" width="25px" height="25px"></span></div>
    <div style="float:right;">신</div>
    <div style="clear: left;"/>
</h4>
</c:when>
<c:otherwise>
</c:otherwise>
</c:choose>
