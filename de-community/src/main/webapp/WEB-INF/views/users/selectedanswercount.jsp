<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<c:if test="${selectedCnt >= 1}">
<img src="/img/icon_replysel.png" title="첫 채택 기념" alt="답변채택" width="25px" height="25px">
</c:if>
<c:if test="${selectedCnt >= 10}">
<img src="/img/icon_replysel.png" title="좋은 답변" alt="답변채택" width="25px" height="25px">
</c:if>
<c:if test="${selectedCnt >= 100}">
<img src="/img/icon_replysel.png" title="훌륭한 답변" alt="답변채택" width="25px" height="25px">
</c:if>
<c:if test="${selectedCnt >= 500}">
<img src="/img/icon_replysel.png" title="최고의 답변" alt="답변채택" width="25px" height="25px">
</c:if>
<c:if test="${selectedCnt >= 1000}">
<img src="/img/icon_replysel.png" title="당신은 인플루엔서!" alt="답변채택" width="25px" height="25px">
</c:if>

