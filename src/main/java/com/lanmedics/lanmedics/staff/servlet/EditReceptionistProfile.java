package com.lanmedics.lanmedics.staff.servlet;

import com.lanmedics.lanmedics.database.DatabaseHelper;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


/**
 * Servlet implementation class EditProfile
 */
@WebServlet("/editReceptionistProfile")
public class EditReceptionistProfile extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditReceptionistProfile() {
        super();
       
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//get admin
		try {
			HttpSession session = request.getSession();
			int receptionistId = (int) session.getAttribute("UserID");
			// get receptionist details
			DatabaseHelper databaseHelper = new DatabaseHelper();
			int status = databaseHelper.updateUser(receptionistId, request);
			if(status>0)
			{
				//successfully updated
				request.getRequestDispatcher("receptionist").forward(request, response);
				return;
			}else
			{
				// redirect to login
				redirectToLogin(request, response);
			}
			return;
		} catch (Exception e) {
			// redirect to login
			redirectToLogin(request, response);
		}
	}
	
	private void redirectToLogin(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		RequestDispatcher rs = request.getRequestDispatcher("login.jsp");
		request.setAttribute("error", "Please login again");
		rs.forward(request, response);
	}


}
