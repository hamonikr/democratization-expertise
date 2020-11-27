<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<c:if test="${user.usersDetail.maxloginday >= 1}">
<img src="/img/icon_stamp.png" title="첫 만남 기념!" alt="출석" width="25px" height="25px">
</c:if>
<c:if test="${user.usersDetail.maxloginday >= 5}">
<img src="/img/icon_stamp.png" title="5일 연속 방문!" alt="출석" width="25px" height="25px">
</c:if>
<c:if test="${user.usersDetail.maxloginday >= 10}">
<img src="/img/icon_stamp.png" title="10일 연속 방문!"  alt="출석" width="25px" height="25px">
</c:if>
<c:if test="${user.usersDetail.maxloginday >= 20}">
<img src="/img/icon_stamp.png" title="20일 연속 방문!"  alt="출석" width="25px" height="25px">
</c:if>
<c:if test="${user.usersDetail.maxloginday >= 30}">
<img src="/img/icon_stamp.png" title="한달 연속 방문!" alt="출석" width="25px" height="25px">
</c:if>
<c:if test="${user.usersDetail.maxloginday >= 60}">
<img src="/img/icon_stamp.png" title="두달 연속 방문!" alt="출석" width="25px" height="25px">
</c:if>
<c:if test="${user.usersDetail.maxloginday >= 100}">
<img src="/img/icon_stamp.png" title="(축) 100일 연속 방문 달성! (하)" alt="출석" width="25px" height="25px">
</c:if>

