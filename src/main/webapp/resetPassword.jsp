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

<title>Reset Password</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
rel="stylesheet">

</head>

<body>

<div class="container mt-5">

<div class="card p-4 mx-auto"
style="max-width:400px;">

<h3 class="text-center mb-3">

Reset Password

</h3>
<%
if("nomatch".equals(error)){
%>

<div class="alert alert-danger">

Passwords do not match.

</div>

<%
}
%>
<%
if("weak".equals(error)){
%>

<div class="alert alert-danger">

Password must contain:
8 characters,
1 uppercase letter,
1 lowercase letter,
1 number,
and 1 special character.

</div>

<%
}
%>
<form action="resetPassword"
method="post">

<input
type="password"
name="newPassword"
class="form-control mb-3"
placeholder="New Password"
required>

<input
type="password"
name="confirmPassword"
class="form-control mb-3"
placeholder="Confirm Password"
required>

<button
class="btn btn-success w-100">

Reset Password

</button>

</form>

</div>

</div>

</body>

</html>