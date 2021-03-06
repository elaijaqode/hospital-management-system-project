<%--
  Created by IntelliJ IDEA.
  User: turnstone
  Date: 25/03/21
  Time: 09:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.lanmedics.lanmedics.patient.modal.Patient" import="com.lanmedics.lanmedics.modal.Appointment" import="com.lanmedics.lanmedics.staff.modal.Doctor"
         import="com.lanmedics.lanmedics.utils.DateUtils" %>
<%@ page import="java.util.ArrayList" %>

<html>
<head>
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
    <!-- Bootstrap core CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">
    <!-- Material Design Bootstrap -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.10.1/css/mdb.min.css" rel="stylesheet">

    <title>Book Appointment</title>
</head>
<body>
<% Patient patient = (Patient)request.getAttribute("patient"); %>

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
            <a class="navbar-brand" href="patient"><b>CarePath</b></a>
            <!-- Left links -->
            <ul class="navbar-nav ml-auto mb-2 mb-lg-0">
                 <li class="nav-item ">
                    <a class="nav-link text-secondary" href="openBookAppointment"><b>Book
                        Appointment</b></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="patient">Dashboard</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="updatePatientProfile">Edit Profile</a>
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
                                <img height="100" width="100" src="media/user.png">
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-12">
                            <br> <h5 class="text-primary"><b><%= patient.getFirstName() + " " + patient.getLastName() %></b></h5><br>
                            <img src="media/gender.png"><span class="details">
									<%= patient.getGender() +", " + patient.getAge() %></span><br> <img
                                src="media/bloodGroup.png"><span class="blood"> <%= patient.getBloodGroup() %></span><br>
                            <img src="media/Location.png"><span class="location">
									<%= patient.getAddress() %></span>
                        </div>
                    </div>
                </div>

                <% ArrayList<ArrayList<Appointment>> arrayList = (ArrayList<ArrayList<Appointment>>)request.getAttribute("appointments"); %>

                <li class="topic"><span class="upcoming">Upcoming
							Appointment</span> <% ArrayList<Appointment> appointments = arrayList.get(0);
                    for(int i=0; i<appointments.size(); i++)
                    { Appointment appointment = appointments.get(i);
                %>
                    <form class="form-signin" action="patientAppointmentDetails"
                          method="post">
                        <input type="hidden" class="form-control" name="appointmentId"
                               value="<%= appointment.getId() %>" />
                        <ul>
                            <li class="subtopic">
                                <button class="btn btn-default" type="submit">
                                    <div class="row">
                                        <div class="col-sm-12 text-left">
                                            <div>
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
                                    </div>
                                </button>
                            </li>
                        </ul>
                    </form>

                    <%  }

                    %>
                </li>
                <li class="topic">Recent Appointment <% ArrayList<Appointment> appointments2 = arrayList.get(1);
                    for(int i=0; i<appointments2.size(); i++)
                    { Appointment appointment = appointments2.get(i);
                %>
                    <form action="patientAppointmentDetails"
                          method="post">
                        <input type="hidden" class="form-control" name="appointmentId"
                               value="<%= appointment.getId() %>" />
                        <ul>
                            <li class="subtopic">
                                <button class="btn btn-default" type="submit">
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
            <div class="row">
                <div class="col-md">
                </div>
                <div class="col-md-4">
                    <h3 class="page-header text-primary text-center" style="margin-top: 20px"><b>Booking Appointment</b></h3>
                      <hr>
                    <form class="form-horizontal" method="post" action="bookAppointment">
                <div class="form-group">
                    <label class="form-label">Patient
                        Name</label>
                    <div class="col-sm-6">
                        <h6 class="form-control-static"><b><%= patient.getFirstName() +" " + patient.getLastName() %></b></h6>
                        <input type="hidden" name="patientId" value="1">
                    </div>
                </div>


                <div class="form-group">
                    <label  class="form-label">Appointment
                        Title</label>
                    <div class="form-group">
                        <input type="text" class="form-control"
                               placeholder="Acute Stomach Ache" name="title" required>
                    </div>
                </div>
                <div class="form-group">
                    <label class="form-label">Preferred
                        Date of Appointment</label>
                    <div class="form-group">
                        <input type="date" class="form-control"
                               placeholder="Date" name="preferredDate"
                               value="<%= DateUtils.getStringFromDate(System.currentTimeMillis()) %>">
                    </div>
                </div>
                <div class="form-group">
                    <label class="form-label">Symptoms</label>
                    <div class="form-group">
							<textarea class="form-control" rows="2"
                                      placeholder="chest pain, fatigue, hallucination, swelling"
                                      name="symptoms"></textarea>
                    </div>
                </div>
                <div class="form-group">
                    <label for="disease" class="form-label">Suspected
                        Disease</label>
                    <div class="form-group">
                        <input type="text" class="form-control" id="disease"
                               placeholder="Tuberculosis, Malaria, Acne, Diarrhea"
                               name="disease">
                    </div>
                </div>

                <!-- Submit button -->
                <button type="submit" class="btn btn-primary btn-block mb-4">Book Appointment</button>

            </form>

        </div>
        <div class="col-md">
        </div>
        </div>
    </div>
</div>
<!-- JQuery -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<!-- Bootstrap tooltips -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.4/umd/popper.min.js"></script>
<!-- Bootstrap core JavaScript -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.3.1/js/bootstrap.min.js"></script>
<!-- MDB core JavaScript -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.10.1/js/mdb.min.js"></script>

</body>
</html>
