<%@ page import="com.ems.dao.AnnouncementDAO" %>
<%@ page import="com.ems.model.Announcement" %>

<%

int id =
Integer.parseInt(
request.getParameter("id")
);

Announcement announcement =
AnnouncementDAO.getAnnouncementById(
id
);

%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>
Edit Announcement
</title>

<link
href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
rel="stylesheet">

<style>

body{

background:#f5f5f5;

}

.edit-box{

width:700px;

margin:50px auto;

background:white;

padding:30px;

border-radius:15px;

box-shadow:0px 0px 10px rgba(0,0,0,0.1);

}

</style>

</head>

<body>

<div class="edit-box">

<h2 class="mb-4">

Edit Announcement

</h2>

<form
action="updateAnnouncement"
method="post">

<input
type="hidden"
name="id"
value="<%= announcement.getId() %>">

<div class="mb-3">

<label>

Title

</label>

<input
type="text"
name="title"
class="form-control"
value="<%= announcement.getTitle() %>"
required>

</div>

<div class="mb-3">

<label>

Message

</label>

<textarea
name="message"
class="form-control"
rows="6"
required><%= announcement.getMessage() %></textarea>

</div>

<button
class="btn btn-dark">

Update Announcement

</button>

<a
href="adminDashboard.jsp#announcements"
class="btn btn-secondary">

Cancel

</a>

</form>

</div>

</body>

</html>