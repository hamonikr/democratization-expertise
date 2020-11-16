<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<c:if test="${aCnt >= 10 and aCnt < 20}">
답변초보
<span class="level"><img src="/img/level_gold.png" alt=""></span>
</c:if>
<c:if test="${aCnt >= 20 and aCnt < 40}">
답변입문
<span class="level"><img src="/img/level_gold.png" alt=""></span>
</c:if>
<c:if test="${aCnt >= 40 and aCnt < 60}">
답변중수
<span class="level"><img src="/img/level_gold.png" alt=""></span>
</c:if>
<c:if test="${aCnt >= 60 and aCnt < 90}">
답변고수
<span class="level"><img src="/img/level_gold.png" alt=""></span>
</c:if>
<c:if test="${aCnt >= 90 and aCnt < 120}">
답변초고수
<span class="level"><img src="/img/level_gold.png" alt=""></span>
</c:if>
<c:if test="${aCnt >= 120 and aCnt < 150}">
답변왕
<span class="level"><img src="/img/level_gold.png" alt=""></span>
</c:if>
<c:if test="${aCnt >= 150 and aCnt < 200}">
답변신
<span class="level"><img src="/img/level_gold.png" alt=""></span>
</c:if>