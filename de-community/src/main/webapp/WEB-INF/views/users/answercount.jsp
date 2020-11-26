<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<c:choose>
<c:when test="${aCnt >= 3 and aCnt < 20}">
<img src="/img/icon_reply.png" alt="답변" width="25px" height="25px">
</c:when>
<c:when test="${aCnt >= 20 and aCnt < 40}">
<img src="/img/icon_reply.png" alt="답변" width="25px" height="25px">
</c:when>
<c:when test="${aCnt >= 40 and aCnt < 60}">
<img src="/img/icon_reply.png" alt="답변" width="25px" height="25px">
</c:when>
<c:when test="${aCnt >= 60 and aCnt < 90}">
<img src="/img/icon_reply.png" alt="답변" width="25px" height="25px">
</c:when>
<c:when test="${aCnt >= 90 and aCnt < 120}">
<img src="/img/icon_reply.png" alt="답변" width="25px" height="25px">
</c:when>
<c:when test="${aCnt >= 120 and aCnt < 150}">
<img src="/img/icon_reply.png" alt="답변" width="25px" height="25px">
</c:when>
<c:when test="${aCnt >= 150 and aCnt < 200}">
<img src="/img/icon_reply.png" alt="답변" width="25px" height="25px">
</c:when>
<c:otherwise>
</c:otherwise>
</c:choose>