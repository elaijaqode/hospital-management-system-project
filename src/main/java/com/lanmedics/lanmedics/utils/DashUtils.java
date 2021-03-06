package com.lanmedics.lanmedics.utils;


import com.lanmedics.lanmedics.database.DatabaseHelper;
import com.lanmedics.lanmedics.modal.Appointment;
import com.lanmedics.lanmedics.patient.modal.Patient;
import com.lanmedics.lanmedics.staff.modal.Doctor;
import com.lanmedics.lanmedics.staff.modal.Staff;

import java.util.ArrayList;

public class DashUtils {
	
	public static double getBMI(double height, double weight) {
		if (height > 0 && weight > 0) {// convert height in meter
			double meterHeight = height / 100;
			// square height
			double squareHeight = meterHeight * meterHeight;
			return (int)(weight / squareHeight);
		} else {
			return 0;
		}
	}
	
	public static int getMedicineCount(int patientId){
		DatabaseHelper databaseHelper = new DatabaseHelper();
		ArrayList<Appointment> appointments = databaseHelper.getAppointment();
		int count = 0;
		for(int i = 0; i < appointments.size(); i++ ){
			if(appointments.get(i).getPatient().getId() == patientId){
				for(int j = 0; j < appointments.get(i).getItems().size(); j++){
					if(appointments.get(i).getItems().get(j).getType() == 3){
						count++;
					}
				}
			}
		}
		return count;
	}
	
	public static int getProfileRating(int userId, int type){
		DatabaseHelper databaseHelper = new DatabaseHelper();
		int res = 0, count = 0,rate;
		switch(type){
		case 1:
			rate = 10;
			Patient patient = databaseHelper.getPatient(userId);
			if(patient.getFirstName()!=null)count++;
			if(patient.getLastName()!=null)count++;
			if(patient.getGender()!=null)count++;
			if(patient.getAddress()!=null)count++;
			if(patient.getContactNumber()!=null)count++;
			if(patient.getBloodGroup()!=null)count++;
			if(patient.getHeight()!=0)count++;
			if(patient.getWeight()!=0)count++;
			if(patient.getEmail()!=null)count++;
			if(patient.getStringDob()!=null)count++;
			res= (count/rate)*100;
			break;
		case 2:
			rate = 9;
			Doctor doctor =  databaseHelper.getDoctor(userId);
			if(doctor.getFirstName()!=null)count++;
			if(doctor.getLastName()!=null)count++;
			if(doctor.getGender()!=null)count++;
			if(doctor.getAddress()!=null)count++;
			if(doctor.getContactNumber()!=null)count++;
			if(doctor.getSpecialization()!=null)count++;
			if(doctor.getDegree()!=null)count++;
			if(doctor.getEmail()!=null)count++;
			if(doctor.getStringDob()!=null)count++;
			res= (count/rate)*100;
			break;
		case 3:
			rate = 7;
			Staff admin = databaseHelper.getStaff(userId);
			if(admin.getFirstName()!=null)count++;
			if(admin.getLastName()!=null)count++;
			if(admin.getGender()!=null)count++;
			if(admin.getAddress()!=null)count++;
			if(admin.getContactNumber()!=null)count++;
			if(admin.getEmail()!=null)count++;
			if(admin.getStringDob()!=null)count++;
			res= (count/rate)*100;
			break;
		case 4:
			rate = 7;
			Staff labPerson = databaseHelper.getStaff(userId);
			if(labPerson.getFirstName()!=null)count++;
			if(labPerson.getLastName()!=null)count++;
			if(labPerson.getGender()!=null)count++;
			if(labPerson.getAddress()!=null)count++;
			if(labPerson.getContactNumber()!=null)count++;
			if(labPerson.getEmail()!=null)count++;
			if(labPerson.getStringDob()!=null)count++;
			res= (count/rate)*100;
			break;
		case 5:
			rate = 7;
			Staff receptionist = databaseHelper.getStaff(userId);
			if(receptionist.getFirstName()!=null)count++;
			if(receptionist.getLastName()!=null)count++;
			if(receptionist.getGender()!=null)count++;
			if(receptionist.getAddress()!=null)count++;
			if(receptionist.getContactNumber()!=null)count++;
			if(receptionist.getEmail()!=null)count++;
			if(receptionist.getStringDob()!=null)count++;
			res= (count/rate)*100;
			break;
			
		}
		return res;
	}
	
	public static int getTotalAppointment(){
		DatabaseHelper databaseHelper = new DatabaseHelper();
		ArrayList<Appointment> appointments = databaseHelper.getAppointment();
		return appointments.size();
	}
	
	public static int getUnapprovedAppointment(){
		DatabaseHelper databaseHelper = new DatabaseHelper();
		ArrayList<Appointment> appointments = databaseHelper.getAppointment();
		int count = 0;
		for(int i = 0; i < appointments.size(); i++ ){
			if(appointments.get(i).getAllocatedDate()==0){
				count++;
			}
		}
		return count;
	}
	
	
}
