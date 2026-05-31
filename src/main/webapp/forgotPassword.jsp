<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%
String error =
request.getParameter(
"error"
);
%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>Forgot Password</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
rel="stylesheet">

</head>

<body>

<div class="container mt-5">

<div class="card p-4 mx-auto"
style="max-width:400px;">

<h3 class="text-center mb-3">

Forgot Password

</h3>
<%
if("usernotfound".equals(error)){
%>

<div class="alert alert-danger">

Username not found.

</div>

<%
}
%>
<form action="forgotPassword"
method="post">

<label class="mb-2">

Username

</label>

<input
type="text"
name="username"
class="form-control mb-3"
required>

<button
class="btn btn-primary w-100">

Send OTP

</button>

</form>

</div>

</div>

</body>
</html>