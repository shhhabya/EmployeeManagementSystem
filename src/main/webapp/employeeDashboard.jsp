<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%@ page import="com.ems.dao.UserDAO" %>
<%@ page import="com.ems.dao.EmployeeDAO" %>
<%@ page import="com.ems.model.Employee" %>
<%@ page import="com.ems.dao.NotificationDAO" %>
<%@ page import="com.ems.model.Notification" %>
<%@ page import="java.util.List" %>
<%@ page import="com.ems.dao.AnnouncementDAO" %>
<%@ page import="com.ems.model.Announcement" %>
<%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);

if(session.getAttribute("username") == null){

    response.sendRedirect("login.jsp");
    return;
}
Boolean forcePasswordChange =
(Boolean)session.getAttribute(
"forcePasswordChange"
);

String passwordStatus =
request.getParameter(
"password"
);

String pictureStatus =
request.getParameter(
"picture"
);

String username =
(String)session.getAttribute("username");

int employeeId =
UserDAO.getEmployeeIdByUsername(
username
);



Employee emp =
EmployeeDAO.getEmployeeById(
employeeId
);

String profilePicture = null;

if(emp != null){

    profilePicture =
    emp.getProfilePicture();

}



String profilePicturePath =
profilePicture;



String employeeCode =
String.format(
"EMP%05d",
employeeId
);

String lastLogin =
UserDAO.getLastLogin(
username
);

List<Notification> notifications =
NotificationDAO.getLatestNotifications(
employeeId
);

String department = "";

if(emp != null){

    department =
    emp.getDepartment();

}

List<Announcement> announcements =
AnnouncementDAO.getAnnouncementsForEmployee(
employeeId,
department
);

int announcementPage = 1;

if(request.getParameter("announcementPage") != null){

    announcementPage =
    Integer.parseInt(
    request.getParameter(
    "announcementPage"
    )
    );

}

int totalAnnouncementsPerPage = 10;

int announcementStart = 0;

if(announcementPage > 1){

    announcementStart =
    (announcementPage - 1)
    *
    totalAnnouncementsPerPage;

}

int announcementCount =
announcements.size();

int announcementPageCount =
(int)Math.ceil(
announcementCount * 1.0
/
totalAnnouncementsPerPage
);

String firstLogin =
request.getParameter(
"firstLogin"
);
%>

<!DOCTYPE html>
<html>

<head>
<link
rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/cropperjs/1.6.2/cropper.min.css">

<link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<meta charset="UTF-8">

<title>Employee Dashboard</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
rel="stylesheet">

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

.dark-table{

color:white !important;

}

.dark-table td{

background:#1e1e1e !important;
color:white !important;

}
body{

background:#f5f5f5;

}

.dashboard-card{

background:white;

padding:25px;

border-radius:15px;

box-shadow:0px 0px 10px rgba(0,0,0,0.1);

margin-bottom:20px;

}

.profile-btn{

    width:60px;
    height:60px;

    display:flex;
    align-items:center;
    justify-content:center;

    border:none;

    background:white;

    box-shadow:0 2px 8px rgba(0,0,0,0.1);

}
.input-error{

border:1px solid red !important;

}

.input-success{

border:1px solid green !important;

}

.validation-message{

font-size:14px;
margin-top:5px;
font-weight:600;

}

.text-error{

color:red;

}

.text-success{

color:green;

}
.dark-modal{

background:#1e1e1e !important;
color:white !important;

}

.dark-text{

color:#bbb !important;

}

.dark-profile-icon{

color:white !important;

}
.dark-profile-btn{

background:white !important;

}
.cropper-container{
max-width:100% !important;
}

.cropper-wrap-box,
.cropper-canvas,
.cropper-drag-box{
max-width:100% !important;
}
</style>

</head>

<body id="body">

<div class="container mt-5">

<div class="d-flex justify-content-between align-items-center">

    <div>

    <h1>Employee Dashboard</h1>

    <p>
    Welcome <%= emp != null ? emp.getName() : "EMP IS NULL" %>
    </p>

    <div class="form-check form-switch">

        <input class="form-check-input"
        type="checkbox"
        id="darkModeToggle">

        <label class="form-check-label">

        Dark Mode

        </label>

    </div>

</div>

    <div class="dropdown">

<button
id="topProfileButton"
class="btn btn-light rounded-circle profile-btn"
data-bs-toggle="dropdown">

<%
if(profilePicturePath != null
   && !profilePicturePath.isEmpty()){
%>

<img
id="topProfileIcon"
src="profileImage?file=<%= profilePicturePath %>"
style="
width:50px;
height:50px;
border-radius:50%;
object-fit:cover;
">

<%
}else{
%>

<i
id="topProfileIcon"
class="bi bi-person-circle fs-2">
</i>

<%
}
%>

</button>

        <ul class="dropdown-menu dropdown-menu-end">

    <li>

        <a class="dropdown-item"
           data-bs-toggle="modal"
           data-bs-target="#profileModal"
           href="#">

           <i class="bi bi-person"></i>
           Profile

        </a>

    </li>

    <li>

        <a class="dropdown-item"
   data-bs-toggle="modal"
   data-bs-target="#changePasswordModal"
   href="#">

   <i class="bi bi-key"></i>
   Change Password

</a>

    </li>

    <li>

        <a class="dropdown-item text-danger"
           href="logout">

           <i class="bi bi-box-arrow-right"></i>
           Logout

        </a>

    </li>

</ul>

    </div>

</div>

<hr>

<div class="dashboard-card theme-card">

<h4>Account Status</h4>

<p>

🟢 Active

</p>

<p>

<b>Employee ID:</b>

<span class="badge bg-primary">
<%= employeeCode %>
</span>

</p>

<p>

<b>Last Login:</b>

<span class="text-muted">
<%= lastLogin %>
</span>

</p>

</div>

<div class="dashboard-card theme-card">

<h4>Recent Notifications</h4>

<ul>

<%
for(Notification notification : notifications){
%>

<li>

<%= notification.getMessage() %>

<br>

<small class="text-muted">

<%= notification.getCreatedAt() %>

</small>

</li>

<%
}
%>

</ul>

</div>

<div class="dashboard-card theme-card">

<h4>Company Announcements</h4>

<%
if(announcements.isEmpty()){
%>

<p class="text-muted">

No announcements available.

</p>

<%
}else{
%>

<%
for(
int i = announcementStart;

i < Math.min(
announcementStart
+
totalAnnouncementsPerPage,
announcementCount
);

i++
){

Announcement announcement =
announcements.get(i);
%>

<div class="border rounded p-3 mb-3">

<h5>

<%= announcement.getTitle() %>

</h5>

<p>

<%= announcement.getMessage() %>

</p>

<small class="text-muted">

Posted:
<%= new java.text.SimpleDateFormat(
"dd MMM yyyy, hh:mm a"
).format(
announcement.getCreatedAt()
).toLowerCase() %>

<%

if(
announcement.getUpdatedAt()
!= null
){

%>

<br>

Last Edited:
<%= new java.text.SimpleDateFormat(
"dd MMM yyyy, hh:mm a"
).format(
announcement.getUpdatedAt()
).toLowerCase() %>

<%

}

%>
</small>

</div>

<%
}
%>
<nav class="mt-3">

<ul class="pagination justify-content-center">

<%
for(
int pageNum = 1;
pageNum <= announcementPageCount;
pageNum++
){
%>

<li class="page-item <%= (pageNum == announcementPage) ? "active" : "" %>">

<a
class="page-link"
href="employeeDashboard.jsp?announcementPage=<%= pageNum %>">

<%= pageNum %>

</a>

</li>

<%
}
%>

</ul>

</nav>
<%
}
%>

</div>

</div>
<div class="modal fade"
id="profileModal"
tabindex="-1">

<div class="modal-dialog">

<div
id="profileModalContent"
class="modal-content">

<div class="modal-header">

<h5 class="modal-title">
Employee Profile
</h5>

<button
type="button"
class="btn-close"
data-bs-dismiss="modal">
</button>

</div>

<div class="modal-body">

<div class="text-center mb-3">

<%
if(profilePicturePath != null
   && !profilePicturePath.isEmpty()){
%>

<img
id="profileIcon"
src="profileImage?file=<%= profilePicturePath %>&t=<%= System.currentTimeMillis() %>"
style="
width:100px;
height:100px;
border-radius:50%;
object-fit:cover;
">

<%
}else{
%>

<i
id="profileIcon"
class="bi bi-person-circle"
style="font-size:80px;">
</i>

<%
}
%>

<form
id="uploadForm"
class="mt-3">

<input
type="file"
id="profilePictureInput"
class="form-control"
accept=".jpg,.jpeg,.png">

</form>

<div class="d-flex justify-content-center gap-2 mt-3">

<button
type="button"
form="uploadForm"
class="btn btn-primary">

Upload Picture

</button>

<%
if(profilePicturePath != null
   && !profilePicturePath.isEmpty()){
%>

<form
action="deleteProfilePicture"
method="post"
onsubmit="return confirm('Remove profile picture?');">

<button
type="submit"
class="btn btn-danger">

Remove Picture

</button>

</form>

<%
}
%>

</div>

</div>



</div>
<table class="table">

<tr>
<td><strong>Employee ID</strong></td>
<td><%= employeeCode %></td>
</tr>

<tr>
<td><strong>Name</strong></td>
<td><%= emp.getName() %></td>
</tr>

<tr>
<td><strong>Department</strong></td>
<td><%= emp.getDepartment() %></td>
</tr>

<tr>
<td><strong>Salary</strong></td>
<td>₹<%= emp.getSalary() %></td>
</tr>

<tr>
<td><strong>Email</strong></td>
<td><%= emp.getEmail() %></td>
</tr>

<tr>
<td><strong>Username</strong></td>
<td>

<span class="badge bg-dark">
<%= username %>
</span>

</td>
</tr>

</table>

</div>

<div class="modal-footer">

<button
type="button"
class="btn btn-secondary"
data-bs-dismiss="modal">

Close

</button>

</div>

</div>

</div>


<div class="modal fade"
id="changePasswordModal"
tabindex="-1"
data-bs-backdrop="static"
data-bs-keyboard="false">

<div class="modal-dialog">

<div class="modal-content">

<div class="modal-header">

<h5 class="modal-title">

Change Password

</h5>

<%
if(!"true".equals(firstLogin)){
%>

<button
type="button"
class="btn-close"
data-bs-dismiss="modal">
</button>

<%
}
%>

</div>

<div class="modal-body">

<%
if(passwordStatus != null
   && !"success".equals(passwordStatus)){
%>

<div class="alert alert-danger">

<%= passwordStatus.equals("mismatch")
? "Passwords Do Not Match"
: passwordStatus.equals("wrongcurrent")
? "Current Password Incorrect"
: passwordStatus.equals("weak")
? "Password must contain 8 characters, 1 uppercase letter, 1 lowercase letter, 1 number and 1 special character"
: "Password Update Failed" %>

</div>

<%
}
%>

<form action="changePassword"
method="post">

<div class="mb-3">

<label>

Current Password

</label>

<div class="input-group">

<input
type="password"
name="currentPassword"
id="currentPassword"
class="form-control"
required>

<button
class="btn btn-outline-secondary"
type="button"
onclick="togglePassword('currentPassword', this)">

<i class="bi bi-eye"></i>

</button>

</div>

</div>

<div class="mb-3">

<label>

New Password

</label>

<div class="input-group">

<input
type="password"
name="newPassword"
id="newPassword"
class="form-control"
required>

<button
class="btn btn-outline-secondary"
type="button"
onclick="togglePassword('newPassword', this)">

<i class="bi bi-eye"></i>

</button>

</div>

</div>

<div class="mb-3">

<label>

Confirm Password

</label>

<div class="input-group">

<input
type="password"
name="confirmPassword"
id="confirmPassword"
class="form-control"
required>

<button
class="btn btn-outline-secondary"
type="button"
onclick="togglePassword('confirmPassword', this)">

<i class="bi bi-eye"></i>

</button>

</div>

<div id="passwordMessage"
class="validation-message">
</div>
</div>

<button
type="submit"
class="btn btn-primary w-100">

Update Password

</button>

</form>

</div>

</div>

</div>

</div>
<%
if("uploaded".equals(pictureStatus)){
%>

<div class="toast-container position-fixed top-0 end-0 p-3">

<div class="toast show align-items-center text-bg-success border-0">

<div class="d-flex">

<div class="toast-body">

Profile Picture Uploaded Successfully

</div>

<button
type="button"
class="btn-close btn-close-white me-2 m-auto"
data-bs-dismiss="toast">
</button>

</div>

</div>

</div>

<%
}
%>

<%
if("deleted".equals(pictureStatus)){
%>

<div class="toast-container position-fixed top-0 end-0 p-3">

<div class="toast show align-items-center text-bg-danger border-0">

<div class="d-flex">

<div class="toast-body">

Profile Picture Removed Successfully

</div>

<button
type="button"
class="btn-close btn-close-white me-2 m-auto"
data-bs-dismiss="toast">
</button>

</div>

</div>

</div>

<%
}
%>

<%
if("success".equals(passwordStatus)){
%>

<div class="toast-container position-fixed top-0 end-0 p-3">

<div id="passwordToast"
class="toast show align-items-center text-white
<%= passwordStatus.equals("success")
? "bg-success"
: "bg-danger" %>"
role="alert">

<div class="d-flex">

<div class="toast-body">

<%= passwordStatus.equals("success")
? "Password Updated Successfully"
: passwordStatus.equals("mismatch")
? "Passwords Do Not Match"
: passwordStatus.equals("wrongcurrent")
? "Current Password Incorrect"
: "Password Update Failed" %>

</div>

<button
type="button"
class="btn-close btn-close-white me-2 m-auto"
data-bs-dismiss="toast">
</button>

</div>

</div>

</div>

<%
}
%>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>

const newPassword =
document.getElementById(
"newPassword"
);

const confirmPassword =
document.getElementById(
"confirmPassword"
);

const passwordMessage =
document.getElementById(
"passwordMessage"
);

function validatePasswords(){

if(!newPassword ||
   !confirmPassword){

return;

}

if(confirmPassword.value === ""){

confirmPassword.classList.remove(
"input-error",
"input-success"
);

passwordMessage.innerHTML = "";

return;

}

if(newPassword.value ===
confirmPassword.value){

newPassword.classList.remove(
"input-error"
);

confirmPassword.classList.remove(
"input-error"
);

newPassword.classList.add(
"input-success"
);

confirmPassword.classList.add(
"input-success"
);

passwordMessage.className =
"validation-message text-success";

passwordMessage.innerHTML =
"Passwords Match";

}
else{

newPassword.classList.remove(
"input-success"
);

confirmPassword.classList.remove(
"input-success"
);

newPassword.classList.add(
"input-error"
);

confirmPassword.classList.add(
"input-error"
);

passwordMessage.className =
"validation-message text-error";

passwordMessage.innerHTML =
"Passwords Do Not Match";

}

}

newPassword.addEventListener(
"keyup",
validatePasswords
);

confirmPassword.addEventListener(
"keyup",
validatePasswords
);

</script>
<script>

function togglePassword(
fieldId,
button
){

const field =
document.getElementById(
fieldId
);

const icon =
button.querySelector("i");

if(field.type === "password"){

field.type = "text";

icon.classList.remove(
"bi-eye"
);

icon.classList.add(
"bi-eye-slash"
);

}
else{

field.type = "password";

icon.classList.remove(
"bi-eye-slash"
);

icon.classList.add(
"bi-eye"
);

}

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
const topProfileButton =
	document.getElementById(
	'topProfileButton'
	);
const cards =
document.querySelectorAll(
'.theme-card'
);
const profileModalContent =
	document.getElementById(
	'profileModalContent'
	);

	const profileIcon =
	document.getElementById(
	'profileIcon'
	);
	
	const topProfileIcon =
		document.getElementById(
		'topProfileIcon'
		);

	const mutedTexts =
	document.querySelectorAll(
	'.text-muted'
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

}else{

disableDarkMode();

localStorage.setItem(
"darkMode",
"disabled"
);

}

});

function enableDarkMode(){
	profileModalContent.classList.add(
			'dark-modal'
			);

			profileIcon.classList.add(
			'dark-profile-icon'
			);
			topProfileButton.classList.add(
					'dark-profile-btn'
					);
			mutedTexts.forEach(text => {

			text.classList.add(
			'dark-text'
			);

			});
body.classList.add(
'dark-mode'
);

cards.forEach(card => {

card.classList.add(
'dark-card'
);

});

}

function disableDarkMode(){
	profileModalContent.classList.remove(
			'dark-modal'
			);

			profileIcon.classList.remove(
			'dark-profile-icon'
			);
			topProfileButton.classList.remove(
					'dark-profile-btn'
					);
			mutedTexts.forEach(text => {

			text.classList.remove(
			'dark-text'
			);

			});
body.classList.remove(
'dark-mode'
);

cards.forEach(card => {

card.classList.remove(
'dark-card'
);

});

}

</script>
<%
if("true".equals(firstLogin)
		   || "wrongcurrent".equals(passwordStatus)
		   || "mismatch".equals(passwordStatus)
		   || "weak".equals(passwordStatus)
		   || "failed".equals(passwordStatus)){
%>

<script>

document.addEventListener(
"DOMContentLoaded",
function(){

new bootstrap.Modal(
document.getElementById(
'changePasswordModal'
)
).show();

});

</script>

<%
}
%>
<script
src="https://cdnjs.cloudflare.com/ajax/libs/cropperjs/1.6.2/cropper.min.js">
</script>
<div
class="modal fade"
id="cropModal"
tabindex="-1">

<div class="modal-dialog modal-lg">

<div class="modal-content">

<div class="modal-header">

<h5 class="modal-title">

Crop Profile Picture

</h5>

<button
type="button"
class="btn-close"
data-bs-dismiss="modal">
</button>

</div>

<div class="modal-body text-center">

<img
id="cropImage"
style="max-width:100%;">

</div>

<div class="modal-footer">

<button
type="button"
class="btn btn-primary"
id="cropButton">

Crop & Upload

</button>

</div>

</div>

</div>

</div>

<script>

let cropper;

const fileInput =
document.getElementById(
"profilePictureInput"
);

const cropImage =
document.getElementById(
"cropImage"
);

const cropModal =
new bootstrap.Modal(
document.getElementById(
"cropModal"
)
);

fileInput.addEventListener(
"change",
function(e){

const file =
e.target.files[0];

if(!file){
return;
}

const reader =
new FileReader();

reader.onload =
function(event){

cropImage.src =
event.target.result;

cropModal.show();

setTimeout(() => {

if(cropper){

cropper.destroy();

}

cropper =
new Cropper(
cropImage,
{
	aspectRatio:1,
	viewMode:2,
	dragMode:"move",
	autoCropArea:1,
	background:false
}
);

},200);

};

reader.readAsDataURL(
file
);

}
);

document.getElementById(
"cropButton"
).addEventListener(
"click",
function(){

const canvas =
cropper.getCroppedCanvas({
width:300,
height:300
});

canvas.toBlob(
function(blob){

const formData =
new FormData();

formData.append(
"profilePicture",
blob,
"profile.jpg"
);

fetch(
		"uploadProfilePicture",
		{
		method:"POST",
		body:formData
		}
		)
		.then(response => {

		console.log(
		"Response Status:",
		response.status
		);

		if(response.ok){

			location.href =
				"employeeDashboard.jsp?picture=uploaded";

		}else{

		alert(
		"Upload Failed: "
		+ response.status
		);

		}

		})
		.catch(error => {

		console.error(
		error
		);

		alert(
		"JavaScript Error"
		);

		});

},
"image/jpeg",
0.8
);

}
);

</script>

<script
src="https://cdnjs.cloudflare.com/ajax/libs/cropperjs/1.6.2/cropper.min.js">
</script>

</body>

</html>