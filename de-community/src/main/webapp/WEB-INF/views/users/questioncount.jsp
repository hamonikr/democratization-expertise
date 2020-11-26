<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<c:choose>
<c:when test="${qCnt >= 3 and qCnt < 20}">
<img src="/img/icon_write.png" alt="글쓰기" width="25px" height="25px">
</c:when>
<c:when test="${qCnt >= 20 and qCnt < 40}">
<img src="/img/icon_write.png" alt="글쓰기" width="25px" height="25px">
</c:when>
<c:when test="${qCnt >= 40 and qCnt < 60}">
<img src="/img/icon_write.png" alt="글쓰기" width="25px" height="25px">
</c:when>
<c:when test="${qCnt >= 60 and qCnt < 90}">
<img src="/img/icon_write.png" alt="글쓰기" width="25px" height="25px">
</c:when>
<c:when test="${qCnt >= 90 and qCnt < 120}">
<img src="/img/icon_write.png" alt="글쓰기" width="25px" height="25px">
</c:when>
<c:when test="${qCnt >= 120 and qCnt < 150}">
<img src="/img/icon_write.png" alt="글쓰기" width="25px" height="25px">
</c:when>
<c:when test="${qCnt >= 150 and qCnt < 200}">
<img src="/img/icon_write.png" alt="글쓰기" width="25px" height="25px">
</c:when>
<c:otherwise>
</c:otherwise>
</c:choose>
