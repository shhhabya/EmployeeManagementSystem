<%@ page language="java"
contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%
String error =
request.getParameter(
"error"
);

String resent =
request.getParameter(
"resent"
);
%>
<%
if("true".equals(resent)){
%>

<div class="alert alert-success">

A new OTP has been sent.

</div>

<%
}
%>
<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Verify OTP</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
rel="stylesheet">

</head>

<body>

<div class="container mt-5">

<div class="card p-4 mx-auto"
style="max-width:400px;">

<h3 class="text-center mb-3">

Verify OTP

</h3>

<%
if("invalid".equals(error)){
%>

<div class="alert alert-danger">

Invalid OTP

</div>

<%
}
%>
<%
if("expired".equals(error)){
%>

<div class="alert alert-danger">

OTP Expired.
Please request a new OTP.

</div>

<%
}
%>
<form action="verifyOtp"
method="post">

<input
type="text"
name="otp"
class="form-control mb-3"
placeholder="Enter OTP"
required>

<button
class="btn btn-primary w-100">

Verify OTP

</button>
<div class="text-center mt-3">

<a
href="resendOtp">

Resend OTP

</a>

</div>
</form>

</div>

</div>

</body>

</html>