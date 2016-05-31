
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="includes/bootstrapMeta.jsp" />
<title>Employees</title>
<jsp:include page="includes/bootstrapCss.jsp" />
<link
	href="http://www.malot.fr/bootstrap-datetimepicker/bootstrap-datetimepicker/css/bootstrap-datetimepicker.css"
	rel="stylesheet">
</head>
<body>
	<div class="container" role="main">

		<!--  add or edit?  ----------------------------------------------------------- -->
		<c:choose>
			<c:when test="${not empty employee}">
				<c:set var="legend">Change Employee ${employee.ssn}</c:set>
				<c:set var="formAction">changeEmployee</c:set>
				<c:set var="readonly">readonly</c:set>
			</c:when>
			<c:otherwise>
				<c:set var="legend">New Employee</c:set>
				<c:set var="formAction">addEmployee</c:set>
				<c:set var="readonly"></c:set>
			</c:otherwise>
		</c:choose>
		<!--  add or edit?  ----------------------------------------------------------- -->

		<div class="row">
			<div class="col-md-8 col-md-offset-2">
				<form class="form-horizontal" method="post" action="${formAction}">
					<fieldset>
						<legend>${legend}</legend>

						<! ----------------  ssn ---------------- -->
						<div class="form-group">
							<label for="inputSSN" class="col-md-2 control-label">SSN</label>
							<div class="col-md-10">
								<input class="form-control" id="inputSSN" type="text" name="ssn"
									${readonly} value="<c:out value="${employee.ssn}"/>">
							</div>
						</div>

						<! ----------------  first Name ---------------- -->
						<div class="form-group">
							<label for="inputFirstName" class="col-md-2 control-label">First
								Name</label>
							<div class="col-md-10">
								<input class="form-control" id="inputFirstName" type="text"
									name="firstName" value="<c:out value="${employee.firstName}"/>">
							</div>
						</div>
						<! ----------------  last Name ---------------- -->
						<div class="form-group">
							<label for="inputLastName" class="col-md-2 control-label">Last
								Name</label>
							<div class="col-md-10">
								<input class="form-control" id="inputLastName" type="text"
									name="lastName" value="<c:out value="${employee.lastName}"/>">
							</div>
						</div>

						<! ----------------  dayOfBirth ---------------- -->
						<div class="form-group">
							<label for="inputDate" class="col-md-2 control-label">Date</label>
							<div class="col-md-10">
								<input class="form_datetime" id="inputDate" placeholder="Date"
									type="text" readonly name="dayOfBirth"
									value="<fmt:formatDate value="${employee.dayOfBirth}" pattern="dd.MM.yyyy"/>">
							</div>
						</div>

						<! ----------------  buttons ---------------- -->
						<div class="form-group">
							<div class="col-md-10 col-md-offset-2">
								<button type="submit" class="btn btn-primary">Submit</button>
								<a href="listEmployees">
									<button type="button" class="btn btn-default">Cancel</button>
								</a>
							</div>
						</div>

					</fieldset>
				</form>
			</div>
		</div>

	</div>
	<!--  End of container -->


<!-- JS for Bootstrap -->
	<%@include file="includes/bootstrapJs.jsp"%>
<!-- JS for Bootstrap -->


<!-- JS for Datetime picker -->

	<script type="text/javascript"
		src="http://www.malot.fr/bootstrap-datetimepicker/bootstrap-datetimepicker/js/bootstrap-datetimepicker.js"></script>

	<script>
		$(function() {

			$(".form_datetime").datetimepicker({
				format : "dd.mm.yyyy",
				autoclose : true,
				todayBtn : true,
				pickerPosition : "bottom-left",
				minView : 2
			});

		});
	</script>

</body>
</html>