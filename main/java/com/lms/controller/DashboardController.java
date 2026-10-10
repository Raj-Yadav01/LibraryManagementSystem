package com.lms.controller;

import java.io.IOException;

import java.util.List;
import com.lms.pojo.Borrowing;

import com.lms.service.DashboardService;
import com.lms.serviceImpl.DashboardServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/DashboardController")
public class DashboardController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final DashboardService dashboardService =
            new DashboardServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        // Check whether the user is logged in
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("loggedInUser") == null) {
            response.sendRedirect(
                request.getContextPath() + "/jsp/login.jsp"
            );
            return;
        }

        // Fetch dashboard statistics from database
        request.setAttribute(
            "totalBooks", dashboardService.getTotalBooks()
        );

        request.setAttribute(
            "totalMembers", dashboardService.getTotalMembers()
        );

        request.setAttribute(
            "issuedBooks", dashboardService.getIssuedBooks()
        );

        request.setAttribute(
            "overdueBooks", dashboardService.getOverdueBooks()
        );
        
        request.setAttribute(
        	    "availableBooks",
        	    dashboardService.getAvailableBooks()
        	);
        
        List<Borrowing> recentActivities =
                dashboardService.getRecentActivities();

        request.setAttribute("recentActivities", recentActivities);

        // Open dashboard JSP
        request.getRequestDispatcher("/jsp/dashboard.jsp")
               .forward(request, response);
        
//        
    }
}