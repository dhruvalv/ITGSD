<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Home Page</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script type="text/javascript">
	$(document).ready(function() {

		window.setTimeout(function() {
			$(".alert").fadeTo(1000, 0).slideUp(1000, function() {
				$(this).remove();
			});
		}, 1000);

		$("#role").change(function() {
			if ($(this).val() == "ADMIN" || $(this).val() == "REGULAR") {
				$("#unit").hide();
			} else {
				$("#unit").show();
			}
		});
	});
</script>
</head>
<body class="bg" id="main">
	<div class="container">
		<div class="mainopacbox" style="padding: 20px;">
			<h1 class="itgsdcenter" style="color: #e0a800;">Information
				Technology Global Service Desk</h1>
			<div class="row">
				<div class="col-sm-10"></div>
				<div class="col-sm-1" style="color: #000000;">
					<button type="button" class="btn btn-primary btn-xs"
						data-toggle="modal" data-target="#profileUserModal">Profile</button>
					<div class="modal fade" id="profileUserModal" tabindex="-1"
						role="dialog" aria-labelledby="exampleModalLabel"
						aria-hidden="true">
						<div class="modal-dialog" role="document">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title" id="exampleModalLabel">Profile
										Details</h5>
									<button type="button" class="close" data-dismiss="modal"
										aria-label="Close">
										<span aria-hidden="true">&times;</span>
									</button>
								</div>
								<div class="modal-body">
									<form role="form" method="POST" action="updateProfile"
										name="updateProfile">
										<div class="form-group">
											<label class="control-label">First Name:</label>
											<div>
												<input type="text" class="form-control input-lg"
													name="firstName" value="${user.firstName}">
											</div>
										</div>
										<div class="form-group">
											<label class="control-label">Last Name:</label>
											<div>
												<input type="text" class="form-control input-lg"
													name="lastName" value="${user.lastName}">
											</div>
										</div>
										<div class="form-group">
											<label class="control-label">Email:</label>
											<div>
												<input type="text" class="form-control input-lg"
													name="email" value="${user.email}">
											</div>
										</div>
										<div class="form-group">
											<label class="control-label">Phone:</label>
											<div>
												<input type="text" class="form-control input-lg"
													name="phone" value="${user.phone}">
											</div>
										</div>
										<div class="form-group">
											<div>
												<button type="submit" class="btn btn-success">Update</button>
											</div>
										</div>
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="col-sm-1">
					<a href="logout" class="btn btn-primary btn-xs">Logout</a>

				</div>
			</div>
		</div>
		<c:if test="${profileUpdated == true}">
			<div class="alert alert-success alert-dismissible fade show"
				role="alert">
				<button type="button" class="close" data-dismiss="alert"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<strong>Congratulations!</strong> Profile has been successfully
				updated!
			</div>
		</c:if>
		<c:if test="${ticketAssigned == true}">
			<div class="alert alert-success alert-dismissible fade show"
				role="alert">
				<button type="button" class="close" data-dismiss="alert"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<strong>Congratulations!</strong> Ticket has been successfully
				assigned!
			</div>
		</c:if>
		<c:if test="${ticketDeleted == true}">
			<div class="alert alert-success alert-dismissible fade show"
				role="alert">
				<button type="button" class="close" data-dismiss="alert"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<strong>Congratulations!</strong> Ticket has been successfully
				deleted!
			</div>
		</c:if>
		<c:if test="${assignedRole == true}">
			<div class="alert alert-success alert-dismissible fade show"
				role="alert">
				<button type="button" class="close" data-dismiss="alert"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<strong>Congratulations!</strong> Role has been successfully
				assigned!
			</div>
		</c:if>
		<c:if test="${unitUpdated == true}">
			<div class="alert alert-success alert-dismissible fade show"
				role="alert">
				<button type="button" class="close" data-dismiss="alert"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<strong>Congratulations!</strong> Unit has been successfully
				Created!
			</div>
		</c:if>
		<div class="mainopacbox" style="padding: 20px;">
			<div class="container">
				<div class="row">
					<div class="col-sm-8">
						<h4>Welcome, ${user.firstName}, Admin of ITGSD</h4>
					</div>
					<div class="col-sm-2" style="color: #000000;">
						<!-- Button trigger modal -->
						<button type="button" class="btn btn-primary" data-toggle="modal"
							data-target="#assignRoleModal">Assign Role</button>

						<!-- Modal -->
						<div class="modal fade" id="assignRoleModal" tabindex="-1"
							role="dialog" aria-labelledby="exampleModalLabel"
							aria-hidden="true">
							<div class="modal-dialog" role="document">
								<div class="modal-content">
									<div class="modal-header">
										<h5 class="modal-title" id="exampleModalLabel">Assign
											Role</h5>
										<button type="button" class="close" data-dismiss="modal"
											aria-label="Close">
											<span aria-hidden="true">&times;</span>
										</button>
									</div>
									<div class="modal-body">
										<form role="form" method="POST" action="assignRole">
											<div class="form-group">
												<label for="users">Choose User:</label> <select
													class="form-control" id="user" name="user">
													<c:forEach items="${userList}" var="users">
														<option value="${users.id}">${users.firstName}-
															${users.email}</option>
													</c:forEach>
												</select>
											</div>
											<div class="form-group">
												<label for="users">Choose Role:</label> <select
													class="form-control" id="role" name="role">
													<option value="TECHNICIAN">TECHNICIAN</option>
													<option value="SUPERVISOR">SUPERVISOR</option>
													<option value="ADMIN">ADMIN</option>
													<option value="REGULAR">REGULAR</option>
												</select>
											</div>
											<div class="form-group" id="unit">
												<label for="users">Choose Unit:</label> <select
													class="form-control" name="unit">
													<c:forEach items="${units}" var="unit">
														<option value="${unit.id}">${unit.name}</option>
													</c:forEach>
												</select>
											</div>
											<div class="form-group">
												<div>
													<button type="submit" class="btn btn-success">Assign</button>
												</div>
											</div>
										</form>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-sm-2">
						<!-- Button trigger modal -->
						<button type="button" class="btn btn-primary" data-toggle="modal"
							data-target="#createTicketModal">Create Ticket</button>

						<!-- Modal -->
						<div class="modal fade" id="createTicketModal" tabindex="-1"
							role="dialog" aria-labelledby="exampleModalLabel"
							aria-hidden="true">
							<div class="modal-dialog" role="document">
								<div class="modal-content">
									<div class="modal-header">
										<h5 class="modal-title" id="exampleModalLabel">Create New
											Ticket</h5>
										<button type="button" class="close" data-dismiss="modal"
											aria-label="Close">
											<span aria-hidden="true">&times;</span>
										</button>
									</div>
									<div class="modal-body">
										<form role="form" method="POST" action="createTicket">
											<div class="form-group">
												<label class="control-label">Subject:</label>
												<div>
													<input type="text" class="form-control input-lg"
														name="subject">
												</div>
											</div>
											<div class="form-group">
												<label class="control-label">Description:</label>
												<div>
													<input type="text" class="form-control input-lg"
														name="description">
												</div>
											</div>
											<div class="form-group">
												<label for="units">Choose Unit:</label> <select
													class="form-control" id="unit" name="unit">
													<c:forEach items="${units}" var="unit">
														<option value="${unit.name}">${unit.name}</option>
													</c:forEach>
												</select>
											</div>
											<div class="form-group">
												<div>
													<button type="submit" class="btn btn-success">Create</button>
												</div>
											</div>
										</form>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<br>
			<c:choose>
				<c:when test="${fn:length(tickets) gt 0}">
					<div>
						<p>
							There are <span class="badge">${fn:length(tickets)}</span>
							ticket(s)
						</p>
						<table class="table table-bordered table-hovered"
							summary="A table of data">
							<tr class="bg-primary text-white" style="text-align: center;">
								<th>Subject</th>
								<th>Details</th>
								<th>Created By</th>
								<th>Status</th>
								<th>Priority</th>
								<th>Date Created</th>
								<th>Date Assigned</th>
								<th>Date Updated</th>
								<th>Date Closed</th>
								<th>Techinicians</th>
								<th></th>
							</tr>
							<c:forEach items="${tickets}" var="ticket">
								<tr>
									<td>${ticket.subject}</td>
									<td>${ticket.details}</td>
									<td>${ticket.createdForEmail}</td>
									<td>${ticket.status}</td>
									<td>${ticket.priority}</td>
									<td>${ticket.dateCreated}</td>
									<td>${ticket.dateAssigned}</td>
									<td>${ticket.dateUpdated}</td>
									<td>${ticket.dateClosed}</td>
									<td><c:choose>
											<c:when test="${fn:length(ticket.technicians) gt 0}">
												<c:forEach items="${ticket.technicians}" var="technician">
													<p>${technician.email}</p>
												</c:forEach>
											</c:when>
											<c:otherwise>
												<!-- Button trigger modal -->
												<button type="button" class="btn btn-success"
													data-toggle="modal" data-target="#assignTicketModal">Assign</button>

												<!-- Modal -->
												<div class="modal fade" id="assignTicketModal" tabindex="-1"
													role="dialog" aria-labelledby="exampleModalLabel"
													aria-hidden="true" style="color: #000000;">
													<div class="modal-dialog" role="document">
														<div class="modal-content">
															<div class="modal-header">
																<h5 class="modal-title" id="exampleModalLabel">Assign
																	Ticket</h5>
																<button type="button" class="close" data-dismiss="modal"
																	aria-label="Close">
																	<span aria-hidden="true">&times;</span>
																</button>
															</div>
															<div class="modal-body">
																<form role="form" method="POST" action="assignTicket">
																	<div class="form-group">
																		<label for="units">Choose Technician:</label> <select
																			class="form-control" id="technician"
																			name="technician">
																			<c:forEach items="${user.unit.technicians}"
																				var="technician">
																				<option value="${technician.email}">${technician.email}</option>
																			</c:forEach>
																		</select>
																	</div>
																	<input type="hidden" name="ticketId"
																		value="${ticket.id}" />
																	<div class="form-group">
																		<div>
																			<button type="submit" class="btn btn-success">Assign</button>
																		</div>
																	</div>
																</form>
															</div>
														</div>
											</c:otherwise>
										</c:choose></td>
									<td><a data-toggle="modal" href="#editTicketModal""><i
											class="fa fa-edit" style="font-size: 24px; color: red"></i></a>
										<div class="modal fade" id="editTicketModal" tabindex="-1"
											role="dialog" aria-labelledby="exampleModalLabel"
											aria-hidden="true" style="color: #000000;">
											<div class="modal-dialog" role="document">
												<div class="modal-content">
													<div class="modal-header">
														<h5 class="modal-title" id="exampleModalLabel">Edit
															Ticket</h5>
														<button type="button" class="close" data-dismiss="modal"
															aria-label="Close">
															<span aria-hidden="true">&times;</span>
														</button>
													</div>
													<div class="modal-body">
														<form role="form" method="POST" action="editTicket">
															<div class="form-group">
																<label for="units">Choose Priority:</label> <select
																	class="form-control" name="priority">
																	<option value="LOW"
																		${'LOW' == ticket.priority ? 'selected="selected"' : ''}>LOW</option>
																	<option value="MEDIUM"
																		${'MEDIUM' == ticket.priority ? 'selected="selected"' : ''}>MEDIUM</option>
																	<option value="HIGH"
																		${'HIGH' == ticket.priority ? 'selected="selected"' : ''}>HIGH</option>
																</select>
															</div>
															<div class="form-group">
																<label for="units">Choose Status:</label> <select
																	class="form-control" name="status">
																	<option value="OPEN"
																		${'OPEN' == ticket.status ? 'selected="selected"' : ''}>OPEN</option>
																	<option value="ASSIGNED"
																		${'ASSIGNED' == ticket.status ? 'selected="selected"' : ''}>ASSIGNED</option>
																	<option value="ONHOLD"
																		${'ONHOLD' == ticket.status ? 'selected="selected"' : ''}>ONHOLD</option>
																	<option value="COMPLETED"
																		${'COMPLETED' == ticket.status ? 'selected="selected"' : ''}>COMPLETED</option>
																	<option value="CLOSED"
																		${'CLOSED' == ticket.status ? 'selected="selected"' : ''}>CLOSED</option>

																</select>
															</div>
															<input type="hidden" name="ticketId" value="${ticket.id}" />
															<div class="form-group">
																<div>
																	<button type="submit" class="btn btn-success">Update</button>
																</div>
															</div>
														</form>
													</div>
												</div>

											</div>
										</div> &nbsp;&nbsp; <a href="deleteTicket?ticketId=${ticket.id}"><i
											class="fa fa-trash-o" style="font-size: 24px; color: red"></i></a></td>
								</tr>
							</c:forEach>
						</table>

					</div>
				</c:when>
				<c:otherwise>
					<p>No tickets to show</p>
				</c:otherwise>
			</c:choose>
		</div>


		<div class="mainopacbox" style="padding: 20px; color: white">
			<div id="unitsTable">
				<p>
					There are <span class="badge">${fn:length(units)}</span> units
				</p>
				<table class="table table-bordered table-hovered"
					summary="A table of data">
					<tr class="bg-primary text-white" style="text-align: center;">
						<th>Name</th>
						<th>Description</th>
						<th>Email</th>
						<th>Phone</th>
						<th>Location</th>
						<th>Supervisor(s)</th>
						<th>Technician(s)</th>
						<th></th>
					</tr>
					<c:forEach items="${units}" var="unit">
						<tr>
							<td>${unit.name}</td>
							<td>${unit.description}</td>
							<td>${unit.email}</td>
							<td>${unit.phone}</td>
							<td>${unit.location}</td>
							<td><c:forEach items="${unit.supervisors}" var="supervisor">Name: ${supervisor.firstName}, ${supervisor.lastName}<br>Username: ${supervisor.username}<br>Email: ${supervisor.email}<hr></c:forEach></td>
							<td><c:forEach items="${unit.technicians}" var="technician">Name: ${technician.firstName}, ${technician.lastName}<br>Username: ${technician.username}<br>Email: ${technician.email}<hr></c:forEach></td>
							<td><a data-toggle="modal" href="#editUnitModal""><i
									class="fa fa-edit" style="font-size: 24px; color: red"></i></a>
								<div class="modal fade" id="editUnitModal" tabindex="-1"
									role="dialog" aria-labelledby="exampleModalLabel"
									aria-hidden="true" style="color: #000000;">
									<div class="modal-dialog" role="document">
										<div class="modal-content">
											<div class="modal-header">
												<h5 class="modal-title" id="exampleModalLabel">Edit
													Unit</h5>
												<button type="button" class="close" data-dismiss="modal"
													aria-label="Close">
													<span aria-hidden="true">&times;</span>
												</button>
											</div>
											<div class="modal-body">
												<form role="form" method="POST" action="editUnit"
													name="editUnitForm">
													<div class="form-group">
														<label class="control-label">Name:</label>
														<div>
															<input type="text" class="form-control input-lg"
																name="name" value="${unit.name}">
														</div>
													</div>
													<div class="form-group">
														<label class="control-label">Description:</label>
														<div>
															<input type="text" class="form-control input-lg"
																name="description" value="${unit.description}">
														</div>
													</div>
													<div class="form-group">
														<label class="control-label">Email:</label>
														<div>
															<input type="text" class="form-control input-lg"
																name="email" value="${unit.email}">
														</div>
													</div>
													<div class="form-group">
														<label class="control-label">Phone:</label>
														<div>
															<input type="text" class="form-control input-lg"
																name="phone" value="${unit.phone}">
														</div>
													</div>
													<div class="form-group">
														<label class="control-label">Location:</label>
														<div>
															<input type="text" class="form-control input-lg"
																name="location" value="${unit.location}">
														</div>
													</div>
													<input type="hidden" name="unitId" value="${unit.id}" />
													<div class="form-group">
														<div>
															<button type="submit" class="btn btn-success">Update</button>
														</div>
													</div>
												</form>
											</div>
										</div>

									</div>
								</div></td>
						</tr>
					</c:forEach>
				</table>

			</div>
		</div>
	</div>
	<style type="text/css">
.mainopacbox {
	margin-top: 20px;
	margin-bottom: 20px;
	background-color: rgba(0, 0, 0, 0.6);
	border: 1px solid black;
	filter: alpha(opacity = 60); /* For IE8 and earlier */
	color: white;
}

#createTicketModal {
	color: black;
}

#main {
	background-attachment: fixed;
	background-position: auto;
	background-size: cover;
	background-image: url("imgs/bg.jpg");
}

.bg {
	/* The image used */
	background-image: url("acs-slide3.jpg");
	/* Full height */
	height: 100%;
	/* Center and scale the image nicely */
	background-position: center;
	background-repeat: no-repeat;
	background-size: cover;
}

.itgsdcenter {
	text-align: center;
}

.itgsdright {
	text-align: right;
}

.centerform {
	display: block;
	text-align: center;
	padding-left: 250px;
	padding-right: 250px;
}
</style>
</body>
</html>