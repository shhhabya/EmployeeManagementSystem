<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String error =
request.getParameter(
"error"
);

String reset =
request.getParameter(
"reset"
);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Employee Login</title>

<link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
.dark-mode{

background:#121212 !important;
color:white !important;

}

.dark-card{

background:#1e1e1e !important;
color:white !important;

}

.dark-input{

background:#2b2b2b !important;
color:white !important;
border:1px solid #555;

}

.dark-input::placeholder{

color:#bbb;

}
body{
    background:#f5f5f5;
}

.login-box{
    width:350px;
    margin:100px auto;
    padding:30px;
    background:white;
    border-radius:12px;
    box-shadow:0px 0px 10px rgba(0,0,0,0.1);
}
#loadingScreen{

position: fixed;
top:0;
left:0;

width:100%;
height:100%;

background: rgba(0,0,0,0.7);

display:none;

justify-content:center;
align-items:center;

z-index:9999;

backdrop-filter: blur(5px);

}

.loader-box{

text-align:center;
color:white;

}

.spinner-border{

width:4rem;
height:4rem;

}

.loading-text{

margin-top:15px;
font-size:20px;
font-weight:600;

letter-spacing:1px;

animation: pulse 1s infinite;

}

@keyframes pulse{

0%{
opacity:0.5;
}

50%{
opacity:1;
}

100%{
opacity:0.5;
}

}
.error-message{

    color:red;
    margin-bottom:15px;
    text-align:center;
    font-weight:600;

}

.input-error{

    border:1px solid red !important;

}

.error-message{

    color:red;
    font-size:14px;
    margin-top:8px;
    text-align:center;

}
.login-footer{

    position:fixed;

    bottom:0;
    left:0;

    width:100%;

    padding:12px;

    text-align:center;

    background:rgba(0,0,0,0.08);

    font-size:14px;

    z-index:1000;

}
.dark-mode .login-footer{

    background:rgba(255,255,255,0.08);

    color:white;

}
</style>

</head>

<body id="body">
<div class="d-flex justify-content-end p-3">

<div class="form-check form-switch">

<input class="form-check-input"
type="checkbox"
id="darkModeToggle">

<label class="form-check-label">

Dark Mode

</label>

</div>

</div>
<div id="loadingScreen">

<div class="loader-box">

<div class="spinner-border text-light"
role="status">
</div>

<div class="loading-text">

Logging In...

</div>

</div>

</div>
<div class="login-box" id="loginCard">

<h2 class="text-center mb-4">
Employee Login
</h2>
<%
if("success".equals(reset)){
%>

<div class="alert alert-success">

Password Reset Successful.
Please Login.

</div>

<%
}
%>
<%
if("invalid".equals(error)){
%>

<div class="error-message">
    Invalid Username or Password
</div>

<%
}
%>

<form action="login"
method="post"
onsubmit="showLoader()">

<div class="mb-3">
<label>Username</label>

<input type="text"
name="username"
class="form-control theme-input <%= "invalid".equals(error) ? "input-error" : "" %>">
</div>

<div class="mb-3">

<label>Password</label>

<div class="input-group">

<input
type="password"
id="loginPassword"
name="password"
class="form-control theme-input <%= "invalid".equals(error) ? "input-error" : "" %>">

<button
type="button"
class="btn btn-outline-secondary"
onclick="togglePassword()">

<i id="passwordIcon" class="bi bi-eye"></i>

</button>

</div>

</div>

<button class="btn btn-dark w-100">
Login
</button>

<div class="text-center mt-3">

<a href="forgotPassword.jsp">

Forgot Password?

</a>

</div>


<%
if("invalid".equals(error)){
%>


<%
}
%>
</form>

</div>

<script>

function showLoader(){

document.getElementById(
'loadingScreen'
).style.display = "flex";

}

</script>
<script>

const toggle =
document.getElementById(
'darkModeToggle'
);

const body =
document.getElementById(
'body'
);

const loginCard =
document.getElementById(
'loginCard'
);

const inputs =
document.querySelectorAll(
'.theme-input'
);

if(localStorage.getItem("darkMode")
=== "enabled"){

enableDarkMode();

toggle.checked = true;

}

toggle.addEventListener(
'change',
() => {

if(toggle.checked){

enableDarkMode();

localStorage.setItem(
"darkMode",
"enabled"
);

} else {

disableDarkMode();

localStorage.setItem(
"darkMode",
"disabled"
);

}

});

function enableDarkMode(){

body.classList.add(
'dark-mode'
);

loginCard.classList.add(
'dark-card'
);

inputs.forEach(input => {

input.classList.add(
'dark-input'
);

});

}

function disableDarkMode(){

body.classList.remove(
'dark-mode'
);

loginCard.classList.remove(
'dark-card'
);

inputs.forEach(input => {

input.classList.remove(
'dark-input'
);

});

}

</script>
<script>

function togglePassword(){

    const passwordField =
    document.getElementById(
    "loginPassword"
    );

    const icon =
    document.getElementById(
    "passwordIcon"
    );

    if(passwordField.type === "password"){

        passwordField.type = "text";

        icon.classList.remove(
        "bi-eye"
        );

        icon.classList.add(
        "bi-eye-slash"
        );

    }else{

        passwordField.type = "password";

        icon.classList.remove(
        "bi-eye-slash"
        );

        icon.classList.add(
        "bi-eye"
        );

    }

}

</script>
<footer class="login-footer">

    For testing purposes, log in as <br> Username: 
    <strong>publicadmin</strong>
    Password: <strong>publicadmin@1234</strong>

    <br>

    You may also create your own Employee account through the Admin Dashboard and test all employee features separately.

</footer>
</body>
</html>