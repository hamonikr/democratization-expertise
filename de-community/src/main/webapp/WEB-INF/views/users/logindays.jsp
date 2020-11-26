<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<c:if test="${user.usersDetail.maxloginday >= 3}">
<h4 style="width: 80px;"> 
    <div style="float:left;"><span class="level"><img src="/img/level_03.png" alt="" width="25px" height="25px"></span></div>
    <div style="float:right;">3</div>
    <div style="clear: left;"/>
</h4>
</c:if>
<c:if test="${user.usersDetail.maxloginday >= 5}">
<h4 style="width: 80px;"> 
    <div style="float:left;"><span class="level"><img src="/img/level_02.png" alt="" width="25px" height="25px"></span></div>
    <div style="float:right;">5</div>
    <div style="clear: left;"/>
</h4>
</c:if>
<c:if test="${user.usersDetail.maxloginday >= 10}">
<h4 style="width: 80px;"> 
    <div style="float:left;"><span class="level"><img src="/img/level_01.png" alt="" width="25px" height="25px"></span></div>
    <div style="float:right;">10</div>
    <div style="clear: left;"/>
</h4>
</c:if>
<c:if test="${user.usersDetail.maxloginday >= 20}">
<h4 style="width: 80px;"> 
    <div style="float:left;"><span class="level"><img src="/img/level_gold.png" alt="" width="25px" height="25px"></span></div>
    <div style="float:right;">20</div>
    <div style="clear: left;"/>
</h4>
</c:if>
<c:if test="${user.usersDetail.maxloginday >= 30}">
<h4 style="width: 80px;"> 
    <div style="float:left;"><span class="level"><img src="/img/level_gold.png" alt="" width="25px" height="25px"></span></div>
    <div style="float:right;">30</div>
    <div style="clear: left;"/>
</h4>
</c:if>
<c:if test="${user.usersDetail.maxloginday >= 60}">
<h4 style="width: 80px;"> 
    <div style="float:left;"><span class="level"><img src="/img/level_gold.png" alt="" width="25px" height="25px"></span></div>
    <div style="float:right;">60</div>
    <div style="clear: left;"/>
</h4>
</c:if>
<c:if test="${user.usersDetail.maxloginday >= 100}">
<h4 style="width: 80px;"> 
    <div style="float:left;"><span class="level"><img src="/img/level_gold.png" alt="" width="25px" height="25px"></span></div>
    <div style="float:right;">100</div>
    <div style="clear: left;"/>
</h4>
</c:if>

