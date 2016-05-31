<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"  %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="includes/bootstrapMeta.jsp" />
<title>Employees</title>
<jsp:include page="includes/bootstrapCss.jsp" />
</head>
<body>


	<div class="container" role="main">

		<div class="page-header">
        	<h1>Employee Management</h1>
      	</div>

		<!--  Error message ----------------------------------------------------------- -->
		<c:if test="${not empty errorMessage}">
			<div class="alert alert-danger" role="alert">${errorMessage}</div>
		</c:if>
		<!--  Error message ----------------------------------------------------------- -->

		<!--  Warning message ----------------------------------------------------------- -->
		<c:if test="${not empty warningMessage}">
			<div class="alert alert-warning" role="warning">
				${warningMessage}</div>
		</c:if>
		<!--  Warning message ----------------------------------------------------------- -->

		<!--   message ----------------------------------------------------------- -->
		<c:if test="${not empty message}">
			<div class="alert alert-success" role="warning">
				${message}</div>
		</c:if>
		<!--   message ----------------------------------------------------------- -->


		<!--  Search bar ----------------------------------------------------------- -->
		<jsp:include page="includes/searchNav.jsp" />
		<!--  Search bar ----------------------------------------------------------- -->

		<!--  2 simple buttons ----------------------------------------------------------- -->
		<div class="row">
			<div class="col-md-4 col-md-offset-4">
				<p>
					<a href="addEmployee">
						<button type="button" class="btn btn-success">Add new Employee</button>
					</a>
					
					<a href="fillEmployeeList">
						<button type="button" class="btn btn-success">Fill List</button>
					</a>
				</p>
			</div>
		</div>
		<!--  2 simple buttons ----------------------------------------------------------- -->

		
		<div class="row">
			<div class="col-md-10 col-md-offset-1">

				<table data-toggle="table" class="table table-striped">
					<thead>
						<tr>
							<th data-sortable="true">SSN</th>
							<th data-sortable="true">First Name</th>
							<th data-sortable="true">Last Name</th>
							<th data-sortable="true">Day of birth</th>
							<th>Actions</th>
						</tr>
					</thead>
					<tbody>
					<!--  list all employees ----------------------------------------------------------- -->
						<c:forEach items="${employees}" var="employee">
							<tr>
								<td>${employee.ssn}</td>
								<td>${employee.firstName}</td>
								<td>${employee.lastName}</td>
								<td><fmt:formatDate value="${employee.dayOfBirth}" pattern="dd.MM.yyyy"/></td>
								
								<td><a href="changeEmployee?ssn=${employee.ssn}">
										<button type="button" class="btn btn-xs btn-success">
											<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
											Edit
										</button>
								</a> <a href="deleteEmployee?ssn=${employee.ssn}">
										<button type="button" class="btn btn-xs btn-danger">
											<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
											Delete
										</button>
								</a></td>
							</tr>
						</c:forEach>
					<!--  list all employees ----------------------------------------------------------- -->
					</tbody>
				</table>
			</div>
		</div>
		
		
	</div>	<!--  End of container -->

	<jsp:include page="includes/bootstrapJs.jsp" />
</body>
</html>