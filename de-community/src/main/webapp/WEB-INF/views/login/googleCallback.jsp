<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<style>
  input{
    width:300px;
  }
 </style>

<head>
<meta charset="UTF-8">
<title>google login callback</title>
</head>
 <body>

      <a href="/login/login">login</a>
      <form action="https://www.googleapis.com/oauth2/v4/token" method="post" enctype="application/x-www-form-urlencoded">
        code : <input type="text" name="code" value="<?=$_GET['code']?>"><br>
        client_id : <input type="text" name="client_id" value="1042506284094-s49av9n5sk34ell2u70lachpmihn07gu.apps.googleusercontent.com"><br>
        client_secret : <input type="text" name="client_secret" value="ttiC6MgXFuXtxe6aiNdVBskO"><br>
        redirect_uri : <input type="text" name="redirect_uri" value="http://localhost:8080/googleCallback.jsp"><br>
        grant_type : <input type="text" name="grant_type" value="authorization_code"><br>
        <input type="submit">
      </form>
 
  </body>
</html>