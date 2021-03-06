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
<script type="text/javascript">
	$(document).ready(function() {

		window.setTimeout(function() {
			$(".alert").fadeTo(1000, 0).slideUp(1000, function() {
				$(this).remove();
			});
		}, 2000);

	});
</script>
</head>
<body class="bg" id="main">
	<div class="container">
		<div class="mainopacbox" style="padding: 20px;">
			<h1 class="itgsdcenter">Information Technology Global Service
				Desk</h1>
			<div class="row">
				<div class="col-sm-10"></div>
				<div class="col-sm-1" style="color:#000000;">
					<button type="button" class="btn btn-primary btn-xs" data-toggle="modal"
						data-target="#profileUserModal">Profile</button>
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
		<c:if test="${ticketCreated == true}">
			<div class="alert alert-success alert-dismissible fade show"
				role="alert">
				<button type="button" class="close" data-dismiss="alert"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<strong>Congratulations!</strong> Ticket has been successfully
				created!
			</div>
		</c:if>
		<c:if test="${profileCreated == true}">
			<div class="alert alert-success alert-dismissible fade show"
				role="alert">
				<button type="button" class="close" data-dismiss="alert"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<strong>Congratulations!</strong> Welcome to ITGSD - One Stop Shop for your issues
			</div>
		</c:if>
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
		<div class="mainopacbox" style="padding: 20px;">
			<div class="container">
				<div class="row">
					<div class="col-sm-10">
						<h4>Welcome, ${user.firstName}</h4>
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
						<p>Ticket History</p>
						<table class="table table-bordered table-hovered"
							summary="A table of data">
							<tr class="bg-primary text-white" style="text-align: center;">
								<th>Subject</th>
								<th>Details</th>
								<th>Status</th>
								<th>Date Created</th>
							</tr>
							<c:forEach items="${tickets}" var="ticket">
								<tr>
									<td>${ticket.subject}</td>
									<td>${ticket.details}</td>
									<td>${ticket.status}</td>
									<td>${ticket.dateCreated}</td>
								</tr>
							</c:forEach>
						</table>

					</div>
				</c:when>
				<c:otherwise>
					<p>You haven't created any tickets.</p>
				</c:otherwise>
			</c:choose>
			<div>
				<c:if test="${user.type == 'ADMIN'}">
					<div id="menu4" class="tab-pane fade">
						<form action="assignrole" method="get" class="centerform">
							<h2>Assign User Role</h2>

							<div class="form-group">
								<div>
									<input type="email" class="form-control" name="email"
										placeholder="Email" required="required">
								</div>
							</div>
							<div class="form-check-inline">
								<label class="form-check-label"> <input type="radio"
									class="form-check-input" name="userRole">Supervisor
								</label>
							</div>
							<div class="form-check-inline">
								<label class="form-check-label"> <input type="radio"
									class="form-check-input" name="userRole">Technician
								</label>
							</div>
							<div class="form-check-inline">
								<label class="form-check-label"> <input type="radio"
									class="form-check-input" name="userRole">General
								</label>
							</div>
							<div class="form-check-inline">
								<label class="form-check-label"> <input type="radio"
									class="form-check-input" name="userRole">Admin
								</label>
							</div>
							<div class="form-group">
								<button type="submit" class="btn btn-success btn-lg btn-block">Assign</button>
							</div>
						</form>
					</div>
				</c:if>
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