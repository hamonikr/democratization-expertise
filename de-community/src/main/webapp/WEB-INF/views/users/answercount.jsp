<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<c:choose>
<c:when test="${aCnt >= 3 and aCnt < 20}">
<img src="/img/icon_reply.png" title="도움러" alt="답변" width="25px" height="25px">
</c:when>
<c:when test="${aCnt >= 20 and aCnt < 100}">
<img src="/img/icon_reply.png" title="지식인" alt="답변" width="25px" height="25px">
</c:when>
<c:when test="${aCnt >= 100 and aCnt < 500}">
<img src="/img/icon_reply.png" title="선생님" alt="답변" width="25px" height="25px">
</c:when>
<c:when test="${aCnt >= 500 and aCnt < 1000}">
<img src="/img/icon_reply.png" title="교수님" alt="답변" width="25px" height="25px">
</c:when>
<c:when test="${aCnt >= 1000}">
<img src="/img/icon_reply.png" title="걸어다니는 백과사전" alt="답변" width="25px" height="25px">
</c:when>
<c:otherwise>
</c:otherwise>
</c:choose>