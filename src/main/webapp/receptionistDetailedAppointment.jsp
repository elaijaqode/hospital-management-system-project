<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.lanmedics.lanmedics.staff.modal.Staff" %>
<%@ page import="com.lanmedics.lanmedics.prescription.Prescription" %>
<%@ page import="com.lanmedics.lanmedics.prescription.Lab" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.lanmedics.lanmedics.modal.Appointment" %>
<%@ page import="com.lanmedics.lanmedics.staff.modal.Doctor" %>
<%@ page import="com.lanmedics.lanmedics.modal.AppointmentItems" %>

<%
		if(request.getAttribute("receptionist")==null || request.getAttribute("appointments")==null 
			|| request.getAttribute("appointment")==null){
			 response.sendRedirect("receptionist");
		}
		else{			
			Staff receptionist = (Staff)request.getAttribute("receptionist");
			ArrayList<Prescription> prescriptions = (ArrayList<Prescription>)request.getAttribute("prescriptions");
			ArrayList<Lab> labs = (ArrayList<Lab>)request.getAttribute("labs");
			ArrayList<ArrayList<Appointment>> arrayList = (ArrayList<ArrayList<Appointment>>)request.getAttribute("appointments");
			Appointment detailedAppointment	= (Appointment)request.getAttribute("appointment");
			if(detailedAppointment.getAllocatedDate() != 0 || request.getAttribute("doctors") != null)
			{ 
				ArrayList<Doctor> doctors = (ArrayList<Doctor>)request.getAttribute("doctors");
	%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Receptionist Dashboard</title>
	<!-- Font Awesome -->
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
	<!-- Bootstrap core CSS -->
	<link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">
	<!-- Material Design Bootstrap -->
	<link href="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.10.1/css/mdb.min.css" rel="stylesheet">

</head>
<body>

<nav class="navbar navbar-expand-lg navbar-light bg-light">
	<!-- Container wrapper -->
	<div class="container-fluid">
		<!-- Toggle button -->
		<button
				class="navbar-toggler"
				type="button"
				data-mdb-toggle="collapse"
				data-mdb-target="#navbarLeftAlignExample"
				aria-controls="navbarLeftAlignExample"
				aria-expanded="false"
				aria-label="Toggle navigation"
		>
			<i class="fas fa-bars"></i>
		</button>

		<!-- Collapsible wrapper -->
		<div class="collapse navbar-collapse" id="navbarLeftAlignExample">
			<a class="navbar-brand" href="receptionist"><b>CarePath</b></a>
			<!-- Left links -->
			<ul class="navbar-nav ml-auto mb-2 mb-lg-0">
				<li class="nav-item">
					<a class="nav-link active" aria-current="page" href="receptionist">Dashboard</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="updateReceptionistProfile">Edit Profile</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="logout"
					>Logout</a
					>
				</li>
			</ul>
			<!-- Left links -->
		</div>
		<!-- Collapsible wrapper -->
	</div>
	<!-- Container wrapper -->
</nav>


	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-3 sidebar">
				<ul class="nav nav-sidebar">
					<div style="display: block">
						<div class="row">
							<div class="col-sm-12">
								<div style="margin-top: 20px">
									<img height="100" width="100" src="media/receptionist.png">
								</div>
							</div>
						</div>

						<div class="row">
							<div class="col-sm-12">
								<br> <h5 class="text-primary"><b><%= receptionist.getFirstName() +" " + receptionist.getLastName() %></b></h5><br>
								<img src="media/gender.png"><span class="details">
									<%= receptionist.getGender() +", " + receptionist.getAge() %></span><br> <img
									src="media/degree.png"><span class="degree"> Receptionist</span><br>
								<img src="media/Location.png"><span class="location">
									<%= receptionist.getAddress() %></span>
							</div>
						</div>
					</div>
<%--					<li class="active">--%>

<%--				--%>
<%--					</li>--%>
					<li style="margin-top: 20px"><span class="upcoming"><b>Unallocated
						Appointment</b></span> <% ArrayList<Appointment> unallocatedAppointments = arrayList.get(0);
			        	for(int i=0; i<unallocatedAppointments.size(); i++)
			        	{ Appointment appointment = unallocatedAppointments.get(i);
	        			%>
						<form class="form-signin" action="receptionistAppointmentDetails"
							method="post">
							<input type="hidden" class="form-control" name="appointmentId"
								value="<%= appointment.getId() %>" />
							<ul>
								<li class="subtopic">
									<%
											if (detailedAppointment.getId() == appointment.getId()) {
										%>
									<button class="btn btn-default activeAppointment" type="submit">
										<%
												} else {
											%>
										<button class="btn btn-default" type="submit">
											<%
													}
												%>
										<div class="row">
											<div class="col-sm-12 text-left">
												<div>
													<b><%= appointment.getTitle() %> </b><br>
													<% if(appointment.getDisease()!=null) { %>
													<%= appointment.getDisease() + " | " %>
													<%  } %>
													<%= appointment.getStringDateCreated() %>
												</div>
											</div>
										</div>
									</button>
								</li>
							</ul>
						</form> <%  }
						        	
				        %></li>
					<li class="topic"><b>Allocated Appointment</b> <% ArrayList<Appointment> allocatedAppointments = arrayList.get(1);
			        	for(int i=0; i<allocatedAppointments.size(); i++)
			        	{ Appointment appointment = allocatedAppointments.get(i);
	        			%>
						<form class="form" action="receptionistAppointmentDetails"
							method="post">
							<input type="hidden" class="form-control" name="appointmentId"
								value="<%= appointment.getId() %>" />
							<ul>
								<li class="subtopic">
									<%
											if (detailedAppointment.getId() == appointment.getId()) {
										%>
									<button class="btn btn-default activeAppointment" type="submit">
										<%
												} else {
											%>
										<button class="btn btn-default" type="submit">
											<%
													}
												%>
											<div class="row">
												<div class="col-sm-12 text-left">
													<b><%= appointment.getTitle() %> </b><br>
													<% Doctor doctor = appointment.getDoctor();
													if(doctor==null){
												%>Waiting for doctor approval
													<% }else{ %>
													<%= doctor.getFirstName() %>
													<% } %>
													|
													<%= appointment.getStringDateCreated() %>
												</div>
											</div>
										</button>
									</li>
								</ul>
							</form> 
							<%  }
					        %>
					</li>
				</ul>
			</div>
			<div class="col-sm-9 col-sm-offset-3 main">
				<h3 class="page-header text-primary" style="margin-top: 20px"><b><%=detailedAppointment.getTitle()%></b></h3>
				<div class="content">
					<div class="row ">
						<div class="col-sm-3">
							<b>Appointment ID: <%=detailedAppointment.getId()%></b>
						</div>
						<% if(detailedAppointment.getAllocatedDate() == 0) { %>
						<div class="col-sm-5">
							<b>Preferred Date:</b>
							<%=detailedAppointment.getStringPreferredDate()%>
						</div>
						<% }else { %>
						<div class="col-sm-5">
							<b>Doctor Name: </b>
							<%
								if (detailedAppointment.getDoctor() != null) {
							%>
							<%=detailedAppointment.getDoctor().getFirstName() + " "
							+ detailedAppointment.getDoctor().getLastName()%>
							<%
								} else {
							%>
							Waiting for doctor approval
							<%
								}
							%>
						</div>
						<% } %>
						<div class="col-sm-4">
							<b>Date Created:</b>
							<%=detailedAppointment.getStringDateCreated()%>
						</div>
					</div>
					<br>
					<div class="row ">
						<div class="col-sm-8">
							<b>Symptoms: </b>
							<%=detailedAppointment.getSymptoms()%>
						</div>
						<div class="col-sm-4">
							<b>Suspected Disease </b><%=detailedAppointment.getDisease()%>
						</div>
					</div>

					<br>
					<% if(detailedAppointment.getAllocatedDate() == 0) { %>
					<form action="allocateDoctor" method="post">
						<input type="hidden" name="appointmentId"
							value="<%= detailedAppointment.getId() %>">
						<div class="row ">
							<div class="col-sm-4">
								<b>Allocated Doctor </b>
							</div>
							<div class="col-sm-8">
								<select class="form-control" name="doctorId" required>
									<option value="" selected disabled>Choose Doctor</option>
									<% for(int i=0; i<doctors.size(); i++) { 
												  		Doctor doctor = doctors.get(i); %>
									<option value="<%= doctor.getId() %>">
										<%= doctor.getFirstName() + " " + doctor.getLastName() + ", "  + doctor.getDegree() + ", " + doctor.getSpecialization()%></option>
									<% } %>
								</select>
							</div>
							<br>
							<div class="col-sm-4" style="margin-top: 10px">
								<b>Allocated Date </b>
							</div>
							<div class="col-sm-8">
								<input type="date" class="form-control" name="allocatedDate"
									id="date" required placeholder="Allocate Date"
									value="<%= detailedAppointment.getStringPreferredDate() %>">
							</div>
						</div>
						<br>
						<button class="btn btn-lg btn-primary btn-block" type="submit">Allocate</button>
					</form>
					<br>
					<%} %>
					<% if(detailedAppointment.getIsClosed()==0){ %>
						<div class="row">
							<form method="post" action="closeAppointment">
							<input type="hidden" name="appointmentId" value="<%=detailedAppointment.getId() %>" >
							<input
									type="hidden" name="by"
									value="<%="By Receptionist: - " + receptionist.getFirstName() %>" /> 
							<input
									type="hidden" name="requestDispatcher"
									value="receptionistAppointmentDetails" /> 
							<button type="submit" class="send btn btn-danger">Close</button>
						</form>
						</div>
					<%}else { %>
						<h3 style="text-align:center">Closed</h3>
					<% } %>
				</div>
				<%
					if (detailedAppointment.getItems() != null) {
				%>
				<%
					for (int i = 0; i < detailedAppointment.getItems().size(); i++) {
								AppointmentItems item = detailedAppointment.getItems().get(i);
				%>
				<div class="content" style="">
					<div class="row ">
						<div class="col-sm-2">
							<div class="messageFrom">
								<% if(item.getType()==1){ 	%>
								<%= detailedAppointment.getDoctor().getFirstName() %>
								<%}else if(item.getType()==2) {%>
								You
								<% }else if(item.getType()==3) { %>
								<%= detailedAppointment.getDoctor().getFirstName() %>
								-> Prescription
								<%}else if(item.getType()==4) {%>
								Lab Report -><% for(int k = 0; k< labs.size(); k++){ 
										if(labs.get(k).getItemId() == item.getItemId()){ %>
								<%= labs.get(k).getLabName() %>
								<%	} } %>
								<% }else if(item.getType()==5) { %>
								<%= detailedAppointment.getDoctor().getFirstName() %>
								<%}else if(item.getType()==6) {%>
								System
								<% } %>
							</div>
						</div>
						<div class="col-sm-10">
							<div class="message">
								<%if(item.getType()==1 || item.getType()==2 || item.getType()==5 || item.getType()==6){ %>
								<%= item.getDescription() %>
								<%}else if(item.getType()==3) {%>
								<% for(int k = 0; k< prescriptions.size(); k++){ 
										if(prescriptions.get(k).getItemId() == item.getItemId()){ %>
								<div>
									Take
									<%= prescriptions.get(k).getQuantity() %>
									<b><%= prescriptions.get(k).getMedicineName() %></b>
									<%= prescriptions.get(k).getTimes() %>
									times a day.
								</div>
								<%	} } %>
								<%}else if(item.getType()==4) {%>
								<% for(int k = 0; k< labs.size(); k++){ 
										if(labs.get(k).getItemId() == item.getItemId()){ %>
								<div>
									Your lab result for <b><%= labs.get(k).getTestFor() %></b> is <b><%= labs.get(k).getLabResult() %></b>.
								</div>
								<%	} } %>
								<%} %>
							</div>
						</div>
					</div>

					<div class="row">
						<div class="col-sm-10"></div>
						<div class="col-sm-2">
							<div class="" style="font-size: 11px;">
								<%=item.getStringDate()%>
							</div>
						</div>
					</div>
				</div>
				<%
					}
						}
				%>
			</div>
		</div>
	</div>

	<!-- Bootstrap core JavaScript
================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<!-- Bootstrap tooltips -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.4/umd/popper.min.js"></script>
	<!-- Bootstrap core JavaScript -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.3.1/js/bootstrap.min.js"></script>
	<!-- MDB core JavaScript -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.10.1/js/mdb.min.js"></script>

</body>
</html>
<%}else{
	response.sendRedirect("receptionist");
}
		}
%>