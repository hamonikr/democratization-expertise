<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<c:if test="${qCnt >= 10 and qCnt < 20}">
질문초보
<span class="level"><img src="/img/level_gold.png" alt=""></span>
</c:if>
<c:if test="${qCnt >= 20 and qCnt < 40}">
질문입문
<span class="level"><img src="/img/level_gold.png" alt=""></span>
</c:if>
<c:if test="${qCnt >= 40 and qCnt < 60}">
질문중수
<span class="level"><img src="/img/level_gold.png" alt=""></span>
</c:if>
<c:if test="${qCnt >= 60 and qCnt < 90}">
질문고수
<span class="level"><img src="/img/level_gold.png" alt=""></span>
</c:if>
<c:if test="${qCnt >= 90 and qCnt < 120}">
질문초고수
<span class="level"><img src="/img/level_gold.png" alt=""></span>
</c:if>
<c:if test="${qCnt >= 120 and qCnt < 150}">
질문왕
<span class="level"><img src="/img/level_gold.png" alt=""></span>
</c:if>
<c:if test="${qCnt >= 150 and qCnt < 200}">
질문신
<span class="level"><img src="/img/level_gold.png" alt=""></span>
</c:if>

