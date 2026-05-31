<%@ page import="com.ems.dao.EmployeeDAO" %>
<%@ page import="com.ems.model.Employee" %>

<%

int id = Integer.parseInt(request.getParameter("id"));

Employee emp = EmployeeDAO.getEmployeeById(id);

%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>Edit Employee</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<style>

body{
    background:#f5f5f5;
}

.edit-box{
    width:500px;
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

<h2 class="mb-4">Edit Employee</h2>

<form action="updateEmployee" method="post">

<input type="hidden"
name="id"
value="<%= emp.getId() %>">

<div class="mb-3">

<label>Name</label>

<input type="text"
name="name"
class="form-control"
value="<%= emp.getName() %>">

</div>

<div class="mb-3">

<label>Department</label>

<select
name="department"
class="form-select">

<option value="IT"
<%= "IT".equals(emp.getDepartment()) ? "selected" : "" %>>
IT
</option>

<option value="HR"
<%= "HR".equals(emp.getDepartment()) ? "selected" : "" %>>
Human Resources
</option>

<option value="Finance"
<%= "Finance".equals(emp.getDepartment()) ? "selected" : "" %>>
Finance
</option>

<option value="Marketing"
<%= "Marketing".equals(emp.getDepartment()) ? "selected" : "" %>>
Marketing
</option>

<option value="Operations"
<%= "Operations".equals(emp.getDepartment()) ? "selected" : "" %>>
Operations
</option>

<option value="Sales"
<%= "Sales".equals(emp.getDepartment()) ? "selected" : "" %>>
Sales
</option>

<option value="Customer Support"
<%= "Customer Support".equals(emp.getDepartment()) ? "selected" : "" %>>
Customer Support
</option>

<option value="Administration"
<%= "Administration".equals(emp.getDepartment()) ? "selected" : "" %>>
Administration
</option>

<option value="Research & Development"
<%= "Research & Development".equals(emp.getDepartment()) ? "selected" : "" %>>
Research & Development
</option>

<option value="Legal"
<%= "Legal".equals(emp.getDepartment()) ? "selected" : "" %>>
Legal
</option>

</select>

</div>

<div class="mb-3">

<label>Salary</label>

<input type="number"
step="0.01"
name="salary"
class="form-control"
value="<%= emp.getSalary() %>">

</div>

<div class="mb-3">

<label>Email</label>

<input type="email"
name="email"
class="form-control"
value="<%= emp.getEmail() %>">

</div>

<button class="btn btn-dark">
Update Employee
</button>

</form>

</div>

</body>
</html>