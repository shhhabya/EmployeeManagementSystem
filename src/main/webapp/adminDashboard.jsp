<%@ page import="java.util.List"%>
<%@ page import="com.ems.dao.EmployeeDAO"%>
<%@ page import="com.ems.model.Employee"%>
<%@ page import="com.ems.dao.AnnouncementDAO"%>
<%@ page import="com.ems.model.Announcement"%>
<%@ page import="com.ems.dao.AdminDAO"%>
<%@ page import="com.ems.model.Admin"%>
<%
String firstLogin = request.getParameter("firstLogin");

String passwordStatus = request.getParameter("password");
%>
<%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
HttpSession currentSession = request.getSession(false);

if (currentSession == null || currentSession.getAttribute("username") == null) {

	response.sendRedirect("login.jsp");
	return;
}
%>
<%
String username = (String) session.getAttribute("username");

Admin admin = AdminDAO.getAdminByUsername(username);
String adminCode = "ADMIN" +
String.format("%03d", admin.getId());

String profilePicturePath =

		admin != null ? admin.getProfilePicture() : null;
%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>Admin Dashboard</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/cropperjs/1.6.2/cropper.min.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<style>
.dark-mode {
	background: #121212 !important;
	color: white !important;
}

.dark-card {
	background: #1e1e1e !important;
	color: white !important;
}

.dark-input {
	background: #2b2b2b !important;
	color: white !important;
	border: 1px solid #555;
}

.dark-input::placeholder {
	color: #bbb;
}

.dark-table {
	color: white !important;
}

.dark-table th {
	background: #2b2b2b !important;
}

.dark-table td {
	background: #1e1e1e !important;
	color: white !important;
}

body {
	background: #f5f5f5;
}

.main-box {
	background: white;
	padding: 30px;
	border-radius: 15px;
	box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
}

.search-box {
	position: relative;
	width: 320px;
}

.search-box i {
	position: absolute;
	top: 50%;
	left: 15px;
	transform: translateY(-50%);
	color: gray;
	font-size: 16px;
}

.search-input {
	padding-left: 42px;
	height: 48px;
	border-radius: 12px;
	border: none;
	box-shadow: 0px 2px 10px rgba(0, 0, 0, 0.08);
	font-size: 15px;
	transition: 0.3s ease;
}

.search-input:focus {
	box-shadow: 0px 0px 0px 4px rgba(13, 110, 253, 0.15);
	transform: scale(1.02);
}

.dashboard-title {
	font-size: 64px;
	font-weight: 700;
	margin-bottom: 30px;
}

.top-bar {
	display: flex;
	justify-content: space-between;
	align-items: center;
	gap: 30px;
	flex-wrap: wrap;
	padding-bottom: 18px;
	border-bottom: 1px solid rgba(255, 255, 255, 0.15);
	margin-bottom: 35px;
}

.left-section, .center-section, .right-section {
	display: flex;
	align-items: center;
	gap: 20px;
}

.search-box {
	position: relative;
	width: 520px;
}

.search-box i {
	position: absolute;
	top: 50%;
	left: 18px;
	transform: translateY(-50%);
	color: #666;
	font-size: 20px;
}

.search-input {
	height: 64px;
	padding-left: 55px;
	border-radius: 16px;
	border: none;
	font-size: 28px;
	font-weight: 500;
	box-shadow: 0 5px 18px rgba(0, 0, 0, 0.12);
}

.search-input:focus {
	box-shadow: 0 0 0 4px rgba(13, 110, 253, 0.2);
}

.nav-tabs .nav-link {
	font-size: 20px;
	padding: 14px 26px;
}

.action-btn.btn-danger {
	padding: 12px 24px;
	font-size: 20px;
	border-radius: 12px;
}

.form-check-label {
	font-size: 22px;
}

.search-btn {
	height: 64px;
	padding: 0px 28px;
	border-radius: 16px;
	font-size: 20px;
	font-weight: 600;
}

.action-btn {
	min-width: 95px;
	text-align: center;
	padding: 8px 0;
}

.sort-text {
	color: #6c757d;
}

.dark-mode .sort-text {
	color: #d1d1d1 !important;
}

.clear-btn {
	height: 48px;
	width: 48px;
	border-radius: 12px;
	font-size: 22px;
	display: flex;
	align-items: center;
	justify-content: center;
	padding: 0;
}

.action-btn {
	min-width: 95px;
	height: 40px;
	border-radius: 12px;
	display: inline-flex;
	align-items: center;
	justify-content: center;
	padding: 0 16px;
	font-weight: 500;
	font-size: 15px;
}

.action-btn {
	width: 90px;
}

.action-btn {
	width: 90px;
	height: 40px;
	font-size: 16px;
	font-weight: 500;
	display: inline-flex;
	align-items: center;
	justify-content: center;
}

.profile-btn {
	width: 60px;
	height: 60px;
	display: flex;
	align-items: center;
	justify-content: center;
	border: none;
	background: white;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

.cropper-container {
	max-width: 100% !important;
}

.input-error {
	border: 1px solid red !important;
}

.input-success {
	border: 1px solid green !important;
}

.validation-message {
	font-size: 14px;
	margin-top: 5px;
	font-weight: 600;
}

.text-error {
	color: red;
}

.text-success {
	color: green;
}
</style>

</head>

<body id="body">
	<%
	String error = request.getParameter("error");
	%>

	<%
	if (error != null) {
	%>

	<div class="alert alert-danger text-center m-3">

		<%
		if (error.equals("emptyfields")) {

		    out.print("All fields are required.");

		} else if (error.equals("invalidsalary")) {

		    out.print("Salary must be greater than 0.");

		} else if (error.equals("invalidemail")) {

		    out.print("Please enter a valid email address.");

		} else if (error.equals("emailExists")) {

		    out.print("Email Address Already Exists.");

		}
		%>

	</div>

	<%
	}
	%>
	<%
	String added = request.getParameter("added");
	String updated = request.getParameter("updated");
	String deleted = request.getParameter("deleted");

	String announcement = request.getParameter("announcement");
	String announcementUpdated = request.getParameter("announcementUpdated");
	String pictureStatus = request.getParameter("picture");
	String sort = request.getParameter("sort");
	String keyword = request.getParameter("keyword");
	%>
	<%
	if (added != null) {
	%>

	<div class="toast-container position-fixed top-0 end-0 p-3">

		<div class="toast show align-items-center text-bg-primary border-0">

			<div class="d-flex">

				<div class="toast-body">Employee Added Successfully</div>

				<button type="button" class="btn-close btn-close-white me-2 m-auto"
					data-bs-dismiss="toast"></button>

			</div>

		</div>

	</div>

	<%
	}
	%>
	<%
	if (updated != null) {
	%>

	<div class="toast-container position-fixed top-0 end-0 p-3">

		<div id="updateToast"
			class="toast show align-items-center text-bg-success border-0">

			<div class="d-flex">

				<div class="toast-body">Employee Updated Successfully</div>

				<button type="button" class="btn-close btn-close-white me-2 m-auto"
					data-bs-dismiss="toast"></button>

			</div>

		</div>

	</div>

	<%
	}
	%>
	<%
	if ("uploaded".equals(pictureStatus)) {
	%>

	<div class="toast-container position-fixed top-0 end-0 p-3">

		<div class="toast show align-items-center text-bg-success border-0">

			<div class="d-flex">

				<div class="toast-body">Profile Picture Uploaded Successfully

				</div>

				<button type="button" class="btn-close btn-close-white me-2 m-auto"
					data-bs-dismiss="toast"></button>

			</div>

		</div>

	</div>

	<%
	}
	%>
	<%
	if ("deleted".equals(pictureStatus)) {
	%>

	<div class="toast-container position-fixed top-0 end-0 p-3">

		<div class="toast show align-items-center text-bg-danger border-0">

			<div class="d-flex">

				<div class="toast-body">Profile Picture Removed Successfully</div>

				<button type="button" class="btn-close btn-close-white me-2 m-auto"
					data-bs-dismiss="toast"></button>

			</div>

		</div>

	</div>

	<%
	}
	%>
	<%
	if (deleted != null) {
	%>

	<div class="toast-container position-fixed top-0 end-0 p-3">

		<div class="toast show align-items-center text-bg-danger border-0">

			<div class="d-flex">

				<div class="toast-body">Employee Deleted Successfully</div>

				<button type="button" class="btn-close btn-close-white me-2 m-auto"
					data-bs-dismiss="toast"></button>

			</div>

		</div>

	</div>

	<%
	}
	%>

	<%
	if (announcementUpdated != null) {
	%>

	<div class="toast-container position-fixed top-0 end-0 p-3">

		<div class="toast show align-items-center text-bg-success border-0">

			<div class="d-flex">

				<div class="toast-body">Announcement Updated Successfully</div>

				<button type="button" class="btn-close btn-close-white me-2 m-auto"
					data-bs-dismiss="toast"></button>

			</div>

		</div>

	</div>

	<%
	}
	%>
	<%
	if ("success".equals(announcement)) {
	%>

	<div class="toast-container position-fixed top-0 end-0 p-3">

		<div class="toast show align-items-center text-bg-success border-0">

			<div class="d-flex">

				<div class="toast-body">Announcement Sent Successfully</div>

				<button type="button" class="btn-close btn-close-white me-2 m-auto"
					data-bs-dismiss="toast"></button>

			</div>

		</div>

	</div>

	<%
	}
	%>

	<div class="container px-3 px-md-4 mt-5">

		<h1 class="dashboard-title">Admin Dashboard</h1>

		<div class="top-bar">

			<div class="left-section">

				<ul class="nav nav-tabs" id="myTab" role="tablist">

					<li class="nav-item">

						<button id="addEmployee-tab" class="nav-link" data-bs-toggle="tab"
							data-bs-target="#addEmployee">Add Employee</button>

					</li>

					<li class="nav-item">

						<button id="viewEmployees-tab" class="nav-link"
							data-bs-toggle="tab" data-bs-target="#viewEmployees">

							View Employees</button>

					</li>

					<li class="nav-item">

						<button id="announcements-tab" class="nav-link"
							data-bs-toggle="tab" data-bs-target="#announcements">

							Announcements</button>

					</li>

				</ul>

			</div>

			<div class="center-section">

				<form action="adminDashboard.jsp#viewEmployees" method="get"
					class="d-flex align-items-center gap-2">

					<div class="search-box">

						<i class="bi bi-search"></i> <input type="text" id="searchInput"
							name="keyword" class="form-control search-input"
							placeholder="Search employees..."
							value="<%=(keyword != null) ? keyword : ""%>">

					</div>

					<a href="adminDashboard.jsp?page=1#viewEmployees"
						class="btn btn-outline-secondary clear-btn"> &times; </a>



					<button type="submit" class="btn btn-dark search-btn">

						Search</button>

				</form>

			</div>

			<div class="right-section">

				<div class="form-check form-switch m-0">

					<input class="form-check-input" type="checkbox" id="darkModeToggle">

					<label class="form-check-label ms-2"> Dark Mode </label>

				</div>

				<div class="dropdown">

					<button id="topProfileButton"
						class="btn btn-light rounded-circle profile-btn"
						data-bs-toggle="dropdown">

						<%
						if (profilePicturePath != null && !profilePicturePath.isEmpty()) {
						%>

						<img src="profileImage?file=<%=profilePicturePath%>"
							style="width: 50px; height: 50px; border-radius: 50%; object-fit: cover;">

						<%
						} else {
						%>

						<div
							style="width: 50px; height: 50px; display: flex; align-items: center; justify-content: center; font-size: 36px; color: black;">
							<i class="bi bi-person-circle"></i>
						</div>

						<%
						}
						%>

					</button>

					<ul class="dropdown-menu dropdown-menu-end">

						<li><a class="dropdown-item" data-bs-toggle="modal"
							data-bs-target="#profileModal" href="#"> Profile </a></li>

						<li><a class="dropdown-item" data-bs-toggle="modal"
							data-bs-target="#changePasswordModal" href="#"> Change
								Password </a></li>

						<li><a class="dropdown-item text-danger" href="logout">

								Logout </a></li>

					</ul>

				</div>

			</div>

		</div>


		<div class="tab-content mt-4">

			<!-- ADD EMPLOYEE TAB -->

			<div class="tab-pane fade" id="addEmployee">

				<div class="main-box theme-card">

					<h3 class="mb-4">Add Employee</h3>

					<form action="addEmployee" method="post" class="needs-validation"
						novalidate>

						<div class="mb-3">

							<label>Name</label> <input type="text" id="name" name="name"
								class="form-control theme-input" required>

						</div>

						<div class="mb-3">

							<label>Department</label> <select id="department"
								name="department" class="form-select theme-input" required>

								<option value="">Select Department</option>

								<option value="IT">IT</option>

								<option value="HR">HR</option>

								<option value="Finance">Finance</option>

								<option value="Marketing">Marketing</option>

								<option value="Operations">Operations</option>

								<option value="Sales">Sales</option>

								<option value="Customer Support">Customer Support</option>

								<option value="Administration">Administration</option>

								<option value="Research & Development">Research &
									Development</option>

								<option value="Legal">Legal</option>

							</select>

						</div>

						<div class="mb-3">

							<label>Salary</label> <input type="number" id="salary"
								step="0.01" name="salary" class="form-control theme-input"
								required>

						</div>

						<div class="mb-3">

							<label>Email</label> 
							<input type="email" id="email" name="email"
       						class="form-control theme-input <%= "emailExists".equals(error) ? "is-invalid" : "" %>"
       						required>
       						<%
if("emailExists".equals(error)){
%>

<div class="invalid-feedback d-block">
    Email Address Already Exists
</div>

<%
}
%>

						</div>

						<button class="btn btn-dark">Add Employee</button>

					</form>

				</div>

			</div>

			<!-- VIEW EMPLOYEE TAB -->

			<div class="tab-pane fade" id="viewEmployees">

				<div class="main-box theme-card">

					<div class="d-flex justify-content-between align-items-center mb-4">

						<div>

							<h3 class="mb-1">Employee Records</h3>

							<p class="sort-text">

								Currently Sorted By: <b> <%=(sort == null) ? "Time Added" : sort.substring(0, 1).toUpperCase() + sort.substring(1)%>

								</b>

							</p>

						</div>

						<form method="get" action="adminDashboard.jsp#viewEmployees">

							<select name="sort" class="form-select"
								onchange="this.form.submit()">

								<option value="">Sort By</option>

								<option value="id">Time Added</option>

								<option value="name">Name</option>

								<option value="department">Department</option>

								<option value="salary">Salary</option>

							</select>

						</form>

					</div>
					<div class="table-responsive">
						<table class="table table-bordered table-hover theme-table">

							<thead class="table-dark">

								<tr>

									<th>ID</th>
									<th>Name</th>
									<th>Department</th>
									<th>Salary</th>
									<th>Email</th>
									<th>Action</th>

								</tr>

							</thead>

							<tbody>

								<%
								int pageid = 1;

								if (request.getParameter("page") != null) {

									pageid = Integer.parseInt(request.getParameter("page"));

								}

								int total = 5;

								int start = 0;

								if (pageid > 1) {

									start = (pageid - 1) * total;

								}

								int count = EmployeeDAO.getEmployeeCount();

								int pageCount = (int) Math.ceil(count * 1.0 / total);

								List<Employee> list;

								if (keyword != null && !keyword.trim().equals("")) {

									list = EmployeeDAO.searchEmployees(keyword, start, total);

								} else if (sort != null && !sort.equals("")) {

									list = EmployeeDAO.sortEmployees(sort, start, total);

								} else {

									list = EmployeeDAO.getEmployeesByPage(start, total);

								}

								int serialNumber = 1;

								for (Employee emp : list) {
								%>

								<tr>

									<td><%=emp.getId()%></td>
									<td><%=emp.getName()%></td>
									<td><%=emp.getDepartment()%></td>
									<td><%=emp.getSalary()%></td>
									<td><%=emp.getEmail()%></td>

									<td><a href="editEmployee.jsp?id=<%=emp.getId()%>"
										class="btn btn-primary action-btn"> Edit </a> <a
										href="deleteEmployee?id=<%=emp.getId()%>"
										class="btn btn-danger action-btn"
										onclick="return confirm('Delete employee?')"> Delete </a></td>
								</tr>

								<%
								}
								%>

							</tbody>
							<%
							int pages = (int) Math.ceil((double) count / total);
							%>

							<nav>

								<ul class="pagination">

									<%
									for (int i = 1; i <= pageCount; i++) {
									%>

									<li class="page-item <%=(i == pageid) ? "active" : ""%>">

										<a class="page-link"
										href="adminDashboard.jsp?page=<%=i%><%=(sort != null ? "&sort=" + sort : "")%><%=(keyword != null ? "&keyword=" + keyword : "")%>#viewEmployees">

											<%=i%>

									</a>

									</li>

									<%
									}
									%>

								</ul>

							</nav>

						</table>

					</div>

				</div>

			</div>

			<!-- ANNOUNCEMENTS TAB -->

			<div class="tab-pane fade" id="announcements">



				<div class="main-box theme-card">

					<h3 class="mb-4">Company Announcements</h3>

					<p class="text-muted">Create announcements for employees.</p>

					<hr>

					<form action="createAnnouncement" method="post"
						onsubmit="return confirm('Send announcement?');">

						<div class="mb-3">

							<label class="form-label fw-bold"> Title </label> <input
								type="text" name="title" class="form-control theme-input"
								required>

						</div>

						<div class="mb-4">

							<label class="form-label fw-bold"> Message </label>

							<textarea name="message" class="form-control theme-input"
								rows="5" required>
</textarea>

						</div>
						<div class="mb-3">

							<label class="form-label fw-bold"> Audience </label> <select
								id="audienceType" name="audienceType" class="form-select">

								<option value="ALL">All Employees</option>

								<option value="DEPARTMENT">Department Wise</option>

								<option value="CUSTOM">Custom Employees</option>

								<option value="RANGE">Employee ID Range</option>

							</select>

						</div>

						<div id="departmentSection" class="border rounded p-3 mt-3"
							style="display: none;">

							<label class="form-label fw-bold"> Departments </label>

							<div class="form-check">
								<input class="form-check-input" type="checkbox"
									name="departments" value="IT"> <label
									class="form-check-label"> IT </label>
							</div>

							<div class="form-check">

								<input class="form-check-input" type="checkbox"
									name="departments" value="HR"> <label
									class="form-check-label"> HR </label>

							</div>

							<div class="form-check">
								<input class="form-check-input" type="checkbox"
									name="departments" value="Finance"> <label
									class="form-check-label"> Finance </label>
							</div>

							<div class="form-check">
								<input class="form-check-input" type="checkbox"
									name="departments" value="Marketing"> <label
									class="form-check-label"> Marketing </label>
							</div>

							<div class="form-check">
								<input class="form-check-input" type="checkbox"
									name="departments" value="Operations"> <label
									class="form-check-label"> Operations </label>
							</div>

							<div class="form-check">
								<input class="form-check-input" type="checkbox"
									name="departments" value="Sales"> <label
									class="form-check-label"> Sales </label>
							</div>

							<div class="form-check">
								<input class="form-check-input" type="checkbox"
									name="departments" value="Customer Support"> <label
									class="form-check-label"> Customer Support </label>
							</div>

							<div class="form-check">
								<input class="form-check-input" type="checkbox"
									name="departments" value="Administration"> <label
									class="form-check-label"> Administration </label>
							</div>

							<div class="form-check">
								<input class="form-check-input" type="checkbox"
									name="departments" value="Research & Development"> <label
									class="form-check-label"> Research & Development </label>
							</div>

							<div class="form-check">
								<input class="form-check-input" type="checkbox"
									name="departments" value="Legal"> <label
									class="form-check-label"> Legal </label>
							</div>

						</div>

						<div id="rangeSection" class="border rounded p-3 mt-3"
							style="display: none;">

							<div class="row">

								<div class="col">

									<label> From ID </label> <input type="number" name="rangeFrom"
										class="form-control">

								</div>

								<div class="col">

									<label> To ID </label> <input type="number" name="rangeTo"
										class="form-control">

								</div>

							</div>

						</div>

						<div id="customSection" class="border rounded p-3 mt-3"
							style="display: none;">

							<h5 class="mt-3">Select Employees</h5>

							<%
							List<Employee> allEmployees = EmployeeDAO.getAllEmployees();

							for (Employee employee : allEmployees) {
							%>

							<div class="form-check">

								<input class="form-check-input" type="checkbox"
									name="employeeIds" value="<%=employee.getId()%>"> <label
									class="form-check-label"> <%=employee.getId()%> - <%=employee.getName()%>
									( <%=employee.getDepartment()%> )

								</label>

							</div>

							<%
							}
							%>

						</div>
						<div class="text-end">

							<button class="btn btn-primary btn-lg">Announce</button>

						</div>

					</form>

					<hr class="my-5">

					<h4>Announcement History</h4>

					<div class="table-responsive">

						<table class="table table-bordered table-hover theme-table">

							<thead class="table-dark">

								<tr>

									<th>ID</th>
									<th>Title</th>
									<th>Message</th>
									<th>Created</th>
									<th>Last Edited</th>
									<th>Action</th>

								</tr>

							</thead>

							<tbody>

								<%
								List<Announcement> announcements = AnnouncementDAO.getAllAnnouncements();

								for (Announcement a : announcements) {
								%>

								<tr>

									<td><%=a.getId()%></td>

									<td><%=a.getTitle()%></td>

									<td><%=a.getMessage()%></td>

									<td><%=a.getCreatedAt()%></td>

									<td><%=a.getUpdatedAt() == null ? "-" : a.getUpdatedAt()%></td>

									<td><a href="editAnnouncement.jsp?id=<%=a.getId()%>"
										class="btn btn-primary action-btn"> Edit </a> <a
										href="deleteAnnouncement?id=<%=a.getId()%>"
										class="btn btn-danger action-btn"
										onclick="return confirm('Delete announcement?')"> Delete </a>

									</td>

								</tr>

								<%
								}
								%>

							</tbody>

						</table>

					</div>

				</div>

			</div>
		</div>
		<!-- tab-content -->
		<script
			src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>

document.addEventListener("DOMContentLoaded", function () {

    const hash =
        window.location.hash;

    let tabId =
        "addEmployee-tab";

    if(hash === "#viewEmployees"){

        tabId = "viewEmployees-tab";

    }
    else if(hash === "#announcements"){

        tabId = "announcements-tab";

    }

    const tabButton =
        document.getElementById(tabId);

    if(tabButton){

        bootstrap.Tab
            .getOrCreateInstance(tabButton)
            .show();

    }

});

</script>

		<script>

(() => {

'use strict'

const forms = document.querySelectorAll('.needs-validation')

Array.from(forms).forEach(form => {

form.addEventListener('submit', event => {

if (!form.checkValidity()) {

event.preventDefault()
event.stopPropagation()

}

form.classList.add('was-validated')

}, false)

})

})()

</script>
		<script>

const nameInput = document.getElementById("name");
const salaryInput = document.getElementById("salary");
const emailInput = document.getElementById("email");

function validateText(input){

    const regex = /^[A-Za-z ]+$/;

    if(regex.test(input.value)){

        input.classList.remove("is-invalid");
        input.classList.add("is-valid");

    } else {

        input.classList.remove("is-valid");
        input.classList.add("is-invalid");

    }
}

function validateSalary(){

    if(parseFloat(salaryInput.value) > 0){

        salaryInput.classList.remove("is-invalid");
        salaryInput.classList.add("is-valid");

    } else {

        salaryInput.classList.remove("is-valid");
        salaryInput.classList.add("is-invalid");

    }
}

function validateEmail(){

    const regex =
    /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[A-Za-z]{2,}$/;

    if(regex.test(emailInput.value)){

        emailInput.classList.remove("is-invalid");
        emailInput.classList.add("is-valid");

    } else {

        emailInput.classList.remove("is-valid");
        emailInput.classList.add("is-invalid");

    }
}

nameInput.addEventListener("input", () => {
    validateText(nameInput);
});



salaryInput.addEventListener("input", validateSalary);

emailInput.addEventListener("input", validateEmail);

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

const cards =
document.querySelectorAll(
'.theme-card'
);

const inputs =
document.querySelectorAll(
'.theme-input'
);

const tables =
document.querySelectorAll(
'.theme-table'
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

cards.forEach(card => {

card.classList.add(
'dark-card'
);

});

inputs.forEach(input => {

input.classList.add(
'dark-input'
);

});

tables.forEach(table => {

table.classList.add(
'dark-table'
);

});

}

function disableDarkMode(){

body.classList.remove(
'dark-mode'
);

cards.forEach(card => {

card.classList.remove(
'dark-card'
);

});

inputs.forEach(input => {

input.classList.remove(
'dark-input'
);

});

tables.forEach(table => {

table.classList.remove(
'dark-table'
);

});

}


</script>
		<script>

const audienceType =
document.getElementById(
"audienceType"
);

const departmentSection =
document.getElementById(
"departmentSection"
);

const customSection =
document.getElementById(
"customSection"
);

const rangeSection =
document.getElementById(
"rangeSection"
);

function updateAudienceUI(){

departmentSection.style.display =
"none";

customSection.style.display =
"none";

rangeSection.style.display =
"none";

if(
audienceType.value
=== "DEPARTMENT"
){

departmentSection.style.display =
"block";

}

if(
audienceType.value
=== "CUSTOM"
){

customSection.style.display =
"block";

}

if(
audienceType.value
=== "RANGE"
){

rangeSection.style.display =
"block";

}

}

audienceType.addEventListener(
"change",
updateAudienceUI
);

updateAudienceUI();

</script>

		<div class="modal fade" id="profileModal" tabindex="-1">

			<div class="modal-dialog">

				<div id="profileModalContent" class="modal-content">

					<div class="modal-header">

						<h5 class="modal-title">Employee Profile</h5>

						<button type="button" class="btn-close" data-bs-dismiss="modal">
						</button>

					</div>

					<div class="modal-body">

						<div class="text-center mb-3">

							<%
							if (profilePicturePath != null && !profilePicturePath.isEmpty()) {
							%>

							<img id="profileIcon"
								src="profileImage?file=<%=profilePicturePath%>&t=<%=System.currentTimeMillis()%>"
								style="width: 100px; height: 100px; border-radius: 50%; object-fit: cover;">

							<%
							} else {
							%>

							<i id="profileIcon"
   class="bi bi-person-circle text-dark"
   style="font-size:80px;">
</i>

							<%
							}
							%>

							<form id="uploadForm" class="mt-3">

								<input type="file" id="profilePictureInput" class="form-control"
									accept=".jpg,.jpeg,.png">

							</form>

							<div class="d-flex justify-content-center gap-2 mt-3">

								<button type="button" class="btn btn-primary"
									onclick="document.getElementById('profilePictureInput').click();">

									Upload Picture</button>

								<%
								if (profilePicturePath != null && !profilePicturePath.isEmpty()) {
								%>

								<form action="deleteProfilePicture" method="post"
									onsubmit="return confirm('Remove profile picture?');">

									<button type="submit" class="btn btn-danger">Remove
										Picture</button>

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
							<td><%=adminCode%></td>
						</tr>

						<tr>
							<td><strong>Name</strong></td>
							<td>Administrator</td>
						</tr>

						<tr>
							<td><strong>Department</strong></td>
							<td>Administration</td>
						</tr>

						<tr>
							<td><strong>Salary</strong></td>
							<td>-</td>
						</tr>

						<tr>
							<td><strong>Email</strong></td>
							<td>-</td>
						</tr>

						<tr>
							<td><strong>Username</strong></td>
							<td><span class="badge bg-dark"> <%=username%>
							</span></td>
						</tr>

					</table>

				</div>

				<div class="modal-footer">

					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Close</button>

				</div>

			</div>

		</div>


		<div class="modal fade" id="changePasswordModal" tabindex="-1"
			data-bs-backdrop="static" data-bs-keyboard="false">

			<div class="modal-dialog">

				<div class="modal-content">

					<div class="modal-header">

						<h5 class="modal-title">Change Password</h5>

						<button type="button" class="btn-close" data-bs-dismiss="modal">
						</button>

					</div>

					<div class="modal-body">

						<%
						if (passwordStatus != null && !"success".equals(passwordStatus)) {
						%>

						<div class="alert alert-danger">

							<%=passwordStatus.equals("mismatch")
		? "Passwords Do Not Match"
		: passwordStatus.equals("wrongcurrent")
				? "Current Password Incorrect"
				: passwordStatus.equals("weak")
						? "Password must contain 8 characters, 1 uppercase letter, 1 lowercase letter, 1 number and 1 special character"
						: "Password Update Failed"%>

						</div>

						<%
						}
						%>

						<form action="changePassword" method="post">

							<div class="mb-3">

								<label> Current Password </label>

								<div class="input-group">

									<input type="password" name="currentPassword"
										id="currentPassword" class="form-control" required>

									<button class="btn btn-outline-secondary" type="button"
										onclick="togglePassword('currentPassword', this)">

										<i class="bi bi-eye"></i>

									</button>

								</div>

							</div>

							<div class="mb-3">

								<label> New Password </label>

								<div class="input-group">

									<input type="password" name="newPassword" id="newPassword"
										class="form-control <%="mismatch".equals(passwordStatus) ? "is-invalid" : ""%>"
										required>

									<button class="btn btn-outline-secondary" type="button"
										onclick="togglePassword('newPassword', this)">

										<i class="bi bi-eye"></i>

									</button>

								</div>

							</div>

							<div class="mb-3">

								<label> Confirm Password </label>

								<div class="input-group">

									<input type="password" name="confirmPassword"
										id="confirmPassword"
										class="form-control <%="mismatch".equals(passwordStatus) ? "is-invalid" : ""%>"
										required>

									<button class="btn btn-outline-secondary" type="button"
										onclick="togglePassword('confirmPassword', this)">

										<i class="bi bi-eye"></i>

									</button>

								</div>

								<div id="passwordMessage" class="validation-message"></div>
							</div>

							<button type="submit" class="btn btn-primary w-100">

								Update Password</button>

						</form>

					</div>

				</div>

			</div>

		</div>
		<div class="modal fade" id="cropModal" tabindex="-1"
			data-bs-backdrop="static">

			<div class="modal-dialog modal-lg">

				<div class="modal-content">

					<div class="modal-header">

						<h5 class="modal-title">Crop Profile Picture</h5>

						<button type="button" class="btn-close" data-bs-dismiss="modal">
						</button>

					</div>

					<div class="modal-body text-center">

						<img id="cropImage" style="max-width: 100%;">

					</div>

					<div class="modal-footer">

						<button type="button" class="btn btn-primary" id="cropButton">

							Crop & Upload</button>

					</div>

				</div>

			</div>

		</div>

		<script
			src="https://cdnjs.cloudflare.com/ajax/libs/cropperjs/1.6.2/cropper.min.js">
</script>

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

console.log(
"FILE SELECTED"
);

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

const profileModal =
	bootstrap.Modal.getInstance(
	document.getElementById("profileModal")
	);

	if(profileModal){
	    profileModal.hide();
	}

	cropModal.show();

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

	    cropper.reset();
	    cropper.zoomTo(1);
	    cropper.center();

	},500);

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

	if(response.ok){

		window.location.href =
		"adminDashboard.jsp?picture=uploaded&profile=open";

		}else{

alert(
"Upload Failed"
);

}

});

},
"image/jpeg",
0.8
);

}
);

</script>
		<%
		if (passwordStatus != null && !"success".equals(passwordStatus)) {
		%>

		<script>

document.addEventListener(
"DOMContentLoaded",
function(){

new bootstrap.Modal(
document.getElementById(
"changePasswordModal"
)
).show();

});

</script>

		<%
		}
		%>
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

	newPassword.classList.remove(
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
</body>
</html>