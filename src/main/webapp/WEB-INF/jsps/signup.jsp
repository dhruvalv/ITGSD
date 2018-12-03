<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>ITGSD</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/open-iconic/1.1.1/font/css/open-iconic-bootstrap.min.css" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
<style>
#header {
	padding: 20px;
	text-align: center;
	color: #e0a800;
	border-bottom: 2px solid #FFFFFF;
	background-color: rgba(0, 0, 0, 0.7);
}

.centerform {
	display: block;
	text-align: center;
	padding-left: 250px;
	padding-right: 250px;
}

#bodypage {
	background-color: rgba(0, 0, 0, 0.7);
	padding-left: 150px;
	padding-right: 150px;
	padding-bottom: 150px;
	color: #FFFFFF
}

#main {
	background-attachment: fixed;
	background-position: auto;
	background-size: cover;
	background-image: url("imgs/bg.jpg");
}

.myrightpadding {
	padding-right: 30px;
}

.myleftpadding {
	padding-left: 30px;
}
</style>
</head>
<body id='main'>
	<div id='header'>
		<h1>Information Technology Global Service Desk</h1>
	</div>
	<div id='bodypage'>
		<br>
		<div class="container">
			<form action="signup" method="post" class="centerform">
				<h2>Create User</h2>
				<p class="hint-text">Create your account. It's free and only
					takes a minute.</p>
				<div class="form-group">

					<input type="text" class="form-control" name="firstName"
						placeholder="First Name" required="required">

				</div>
				<div class="form-group">

					<input type="text" class="form-control" name="lastName"
						placeholder="Last Name" required="required">

				</div>
				<div class="form-group">
					<div>
						<input type="email" class="form-control" name="email"
							placeholder="Email" required="required">
					</div>
				</div>
				<div class="form-group">
					<div>
						<input type="text" class="form-control" name="username"
							placeholder="Username (will be used for login)"
							required="required">
					</div>
				</div>
				<div class="form-group">

					<input type="password" class="form-control" name="password"
						placeholder="Password" required="required">

				</div>
				<div class="form-group">

					<input type="password" class="form-control" name="confirm_password"
						placeholder="Confirm Password" required="required">

				</div>
				<div class="form-group">

					<input type="number" class="form-control" name="phone"
						placeholder="Phone" required="required">

				</div>
				<div class="form-group">
					<label class="checkbox-inline"><input type="checkbox"
						required="required"> I accept the <a href="#">Terms of
							Use</a> &amp; <a href="#">Privacy Policy</a></label>
				</div>
				<div class="form-group">

					<button type="submit" class="btn btn-success btn-lg btn-block">Register
						Now</button>

				</div>
			</form>
		</div>

	</div>
</body>
</html>
