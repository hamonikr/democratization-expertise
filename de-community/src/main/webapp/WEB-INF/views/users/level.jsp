<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<c:if test="${score >= 10 and score < 50}">
레벨1
<span class="level"><img src="/img/level_gold.png" alt=""></span>
</c:if>
<c:if test="${score >= 50 and score < 100}">
레벨2
<span class="level"><img src="/img/level_gold.png" alt=""></span>
</c:if>
<c:if test="${score >= 100 and score < 130}">
레벨3
<span class="level"><img src="/img/level_gold.png" alt=""></span>
</c:if>
<c:if test="${score >= 130 and score < 170}">
레벨4
<span class="level"><img src="/img/level_gold.png" alt=""></span>
</c:if>
<c:if test="${score >= 170 and score < 200}">
레벨5
<span class="level"><img src="/img/level_gold.png" alt=""></span>
</c:if>
<c:if test="${score >= 200 and score < 300}">
레벨6
<span class="level"><img src="/img/level_gold.png" alt=""></span>
</c:if>
<c:if test="${score >= 300 and score < 500}">
레벨7
<span class="level"><img src="/img/level_gold.png" alt=""></span>
</c:if>

