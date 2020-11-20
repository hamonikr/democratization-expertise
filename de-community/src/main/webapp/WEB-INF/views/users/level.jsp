<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<c:if test="${score >= 10 and score < 50}">
<h4 style="width: 80px;"> 
    <div style="float:left;"><span class="level"><img src="/img/level_gold.png" alt="" width="25px" height="25px"></span></div>
    <div style="float:right;">레벨1</div>
    <div style="clear: left;"/>
</h4>
</c:if>
<c:if test="${score >= 50 and score < 100}">
<h4 style="width: 80px;"> 
    <div style="float:left;"><span class="level"><img src="/img/level_gold.png" alt="" width="25px" height="25px"></span></div>
    <div style="float:right;">레벨2</div>
    <div style="clear: left;"/>
</h4>
</c:if>
<c:if test="${score >= 100 and score < 130}">
<h4 style="width: 80px;"> 
    <div style="float:left;"><span class="level"><img src="/img/level_gold.png" alt="" width="25px" height="25px"></span></div>
    <div style="float:right;">레벨3</div>
    <div style="clear: left;"/>
</h4>
</c:if>
<c:if test="${score >= 130 and score < 170}">
<h4 style="width: 80px;"> 
    <div style="float:left;"><span class="level"><img src="/img/level_gold.png" alt="" width="25px" height="25px"></span></div>
    <div style="float:right;">레벨4</div>
    <div style="clear: left;"/>
</h4>
</c:if>
<c:if test="${score >= 170 and score < 200}">
<h4 style="width: 80px;"> 
    <div style="float:left;"><span class="level"><img src="/img/level_gold.png" alt="" width="25px" height="25px"></span></div>
    <div style="float:right;">레벨5</div>
    <div style="clear: left;"/>
</h4>
</c:if>
<c:if test="${score >= 200 and score < 300}">
<h4 style="width: 80px;"> 
    <div style="float:left;"><span class="level"><img src="/img/level_gold.png" alt="" width="25px" height="25px"></span></div>
    <div style="float:right;">레벨6</div>
    <div style="clear: left;"/>
</h4>
</c:if>
<c:if test="${score >= 300 and score < 500}">
<h4 style="width: 80px;"> 
    <div style="float:left;"><span class="level"><img src="/img/level_gold.png" alt="" width="25px" height="25px"></span></div>
    <div style="float:right;">레벨7</div>
    <div style="clear: left;"/>
</h4>
</c:if>

