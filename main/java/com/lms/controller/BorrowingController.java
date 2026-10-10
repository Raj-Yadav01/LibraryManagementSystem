package com.lms.controller;

import java.io.IOException;
import java.util.List;

import com.lms.pojo.Borrowing;
import com.lms.service.BorrowingService;
import com.lms.serviceImpl.BorrowingServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/BorrowingController")
public class BorrowingController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final BorrowingService borrowingService =
            new BorrowingServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Login check
        if (session == null
                || session.getAttribute("loggedInUser") == null) {

            response.sendRedirect(
                    request.getContextPath() + "/jsp/login.jsp"
            );

            return;
        }

        // Check action
        String action = request.getParameter("action");

        // View Borrowing Details
        if ("view".equalsIgnoreCase(action)) {

            viewBorrowing(request, response);

            return;
        }
        
        borrowingService.updateOverdueFines();
        
        // ==============================
        // Borrowing History
        // ==============================

        List<Borrowing> borrowings =
                borrowingService.getAllBorrowings();

        int totalTransactions = 0;
        int currentlyIssued = 0;
        int returnedBooks = 0;
        int overdueBooks = 0;

        if (borrowings != null) {

            totalTransactions = borrowings.size();

            for (Borrowing borrowing : borrowings) {

                String status = borrowing.getStatus();

                if (status == null) {
                    continue;
                }

                if ("Issued".equalsIgnoreCase(status)) {

                    currentlyIssued++;

                } else if ("Returned".equalsIgnoreCase(status)) {

                    returnedBooks++;

                } else if ("Overdue".equalsIgnoreCase(status)) {

                    overdueBooks++;
                }
            }
        }

        // Send data to JSP
        request.setAttribute("borrowingsList", borrowings);

        request.setAttribute(
                "totalTransactions",
                totalTransactions
        );

        request.setAttribute(
                "currentlyIssued",
                currentlyIssued
        );

        request.setAttribute(
                "returnedBooks",
                returnedBooks
        );

        request.setAttribute(
                "overdueBooks",
                overdueBooks
        );

        // Open Borrowing History
        request.getRequestDispatcher(
                "/jsp/borrowingHistory.jsp"
        ).forward(request, response);
    }


    // ==========================================
    // View Borrowing Details
    // ==========================================

    private void viewBorrowing(HttpServletRequest request,
                               HttpServletResponse response)
            throws ServletException, IOException {

        try {

            String idParameter =
                    request.getParameter("id");

            if (idParameter == null
                    || idParameter.trim().isEmpty()) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/BorrowingController?error=invalid"
                );

                return;
            }

            int borrowingId =
                    Integer.parseInt(idParameter);

            // Get borrowing record
            Borrowing borrowing =
                    borrowingService.getBorrowingById(
                            borrowingId
                    );

            // Record not found
            if (borrowing == null) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/BorrowingController?error=notfound"
                );

                return;
            }

            // Send borrowing to JSP
            request.setAttribute(
                    "borrowing",
                    borrowing
            );

            // Open View Details page
            request.getRequestDispatcher(
                    "/jsp/view-borrowing.jsp"
            ).forward(request, response);

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/BorrowingController?error=invalid"
            );
        }
    }
}