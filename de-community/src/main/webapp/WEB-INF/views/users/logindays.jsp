<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<c:if test="${user.usersDetail.maxloginday >= 3}">
<img src="/img/icon_stamp.png" alt="출석" width="25px" height="25px">
</c:if>
<c:if test="${user.usersDetail.maxloginday >= 5}">
<img src="/img/icon_stamp.png" alt="출석" width="25px" height="25px">
</c:if>
<c:if test="${user.usersDetail.maxloginday >= 10}">
<img src="/img/icon_stamp.png" alt="출석" width="25px" height="25px">
</c:if>
<c:if test="${user.usersDetail.maxloginday >= 20}">
<img src="/img/icon_stamp.png" alt="출석" width="25px" height="25px">
</c:if>
<c:if test="${user.usersDetail.maxloginday >= 30}">
<img src="/img/icon_stamp.png" alt="출석" width="25px" height="25px">
</c:if>
<c:if test="${user.usersDetail.maxloginday >= 60}">
<img src="/img/icon_stamp.png" alt="출석" width="25px" height="25px">
</c:if>
<c:if test="${user.usersDetail.maxloginday >= 100}">
<img src="/img/icon_stamp.png" alt="출석" width="25px" height="25px">
</c:if>

