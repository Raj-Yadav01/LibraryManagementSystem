package com.lms.controller;

import java.io.IOException;

import com.lms.pojo.User;
import com.lms.service.UserService;
import com.lms.serviceImpl.UserServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/AuthenticationController")
public class AuthenticationController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final UserService userService = new UserServiceImpl();

    // ==============================
    // LOGIN
    // ==============================
    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");

        // Check action
        if (!"checklogin".equalsIgnoreCase(action)) {
            response.sendRedirect(
                request.getContextPath() + "/jsp/login.jsp"
            );
            return;
        }

        // Get form values
        String usernameOrEmail = request.getParameter("username");
        String password = request.getParameter("password");

        // Validate empty fields
        if (usernameOrEmail == null
                || password == null
                || usernameOrEmail.trim().isEmpty()
                || password.isEmpty()) {

            request.setAttribute(
                "errorMessage",
                "Please enter username/email and password."
            );

            request.getRequestDispatcher(
                "/jsp/login.jsp"
            ).forward(request, response);

            return;
        }

        try {

            // Authenticate user
            User user = userService.checkLogin(
                usernameOrEmail.trim(),
                password
            );

            if (user != null) {

                // Create session
                HttpSession session = request.getSession();

                // Save logged-in user
                session.setAttribute("loggedInUser", user);

                // Redirect to dashboard
             // Redirect to DashboardController
                response.sendRedirect(
                    request.getContextPath() + "/DashboardController"
                );

            } else {

                // Invalid credentials
                request.setAttribute(
                    "errorMessage",
                    "Invalid Username/Email or Password."
                );

                request.getRequestDispatcher(
                    "/jsp/login.jsp"
                ).forward(request, response);
            }

        } catch (Exception e) {

            // Log error in server console
            getServletContext().log(
                "Error while processing login",
                e
            );

            request.setAttribute(
                "errorMessage",
                "Unable to process login. Please try again."
            );

            request.getRequestDispatcher(
                "/jsp/login.jsp"
            ).forward(request, response);
        }
    }

    // ==============================
    // LOGOUT
    // ==============================
    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("logout".equalsIgnoreCase(action)) {

            HttpSession session = request.getSession(false);

            if (session != null) {
                session.invalidate();
            }
        }

        response.sendRedirect(
            request.getContextPath() + "/jsp/login.jsp"
        );
    }
}