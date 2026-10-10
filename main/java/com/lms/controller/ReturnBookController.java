package com.lms.controller;

import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import com.lms.pojo.Borrowing;
import com.lms.pojo.Member;
import com.lms.service.BorrowingService;
import com.lms.service.MemberService;
import com.lms.serviceImpl.BorrowingServiceImpl;
import com.lms.serviceImpl.MemberServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/ReturnBookController")
public class ReturnBookController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final BorrowingService borrowingService =
            new BorrowingServiceImpl();

    private final MemberService memberService =
            new MemberServiceImpl();


    // =========================================================
    // GET
    // =========================================================

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        // Login check
        if (session == null ||
                session.getAttribute("loggedInUser") == null) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/jsp/login.jsp"
            );

            return;
        }


        String action =
                request.getParameter("action");


        // =====================================================
        // GET MEMBER BOOKS
        // =====================================================

        if ("getMemberBooks".equalsIgnoreCase(action)) {

            getMemberBooks(request, response);

            return;
        }


        // =====================================================
        // LOAD RETURN BOOK PAGE
        // =====================================================

        loadReturnBookPage(request, response);
    }


    // =========================================================
    // POST
    // =========================================================

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);


        // Login check
        if (session == null ||
                session.getAttribute("loggedInUser") == null) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/jsp/login.jsp"
            );

            return;
        }


        String action =
                request.getParameter("action");


        // =====================================================
        // RETURN BOOK
        // =====================================================

        if ("returnBook".equalsIgnoreCase(action)) {

            returnBook(request, response);

            return;
        }


        response.sendRedirect(
                request.getContextPath()
                        + "/ReturnBookController"
        );
    }


    // =========================================================
    // LOAD RETURN BOOK PAGE
    // Only members having active books will be shown
    // =========================================================

    private void loadReturnBookPage(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {


        // Get all members

        List<Member> allMembers =
                memberService.getAllMembers();


        // Members who currently have
        // Issued / Overdue books

        List<Member> membersWithBooks =
                new ArrayList<>();


        for (Member member : allMembers) {

            int borrowedCount =
                    borrowingService
                            .getMemberActiveBorrowingCount(
                                    member.getMemberId()
                            );


            if (borrowedCount > 0) {

                membersWithBooks.add(member);
            }
        }


        // Send filtered members to JSP

        request.setAttribute(
                "membersList",
                membersWithBooks
        );


        // Open Return Book page

        request.getRequestDispatcher(
                "/jsp/returnBook.jsp"
        ).forward(
                request,
                response
        );
    }


    // =========================================================
    // GET MEMBER BOOKS
    // Returns only selected member's Issued / Overdue books
    // =========================================================

    private void getMemberBooks(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {


        response.setContentType(
                "application/json"
        );

        response.setCharacterEncoding(
                "UTF-8"
        );


        String memberIdParameter =
                request.getParameter("memberId");


        // No member selected

        if (memberIdParameter == null ||
                memberIdParameter.trim().isEmpty()) {

            response.getWriter().write("[]");

            return;
        }


        try {

            int memberId =
                    Integer.parseInt(
                            memberIdParameter
                    );


            // Get only this member's active books

            List<Borrowing> borrowings =
                    borrowingService
                            .getActiveBorrowingsByMemberId(
                                    memberId
                            );


            StringBuilder json =
                    new StringBuilder();


            json.append("[");


            for (int i = 0;
                    i < borrowings.size();
                    i++) {


                Borrowing borrowing =
                        borrowings.get(i);


                if (i > 0) {

                    json.append(",");
                }


                json.append("{");


                // Borrowing ID

                json.append("\"borrowingId\":")
                        .append(
                                borrowing.getBorrowingId()
                        )
                        .append(",");


                // Book ID

                json.append("\"bookId\":")
                        .append(
                                borrowing.getBookId()
                        )
                        .append(",");


                // Book Title

                json.append("\"bookTitle\":\"")
                        .append(
                                escapeJson(
                                        borrowing.getBookTitle()
                                )
                        )
                        .append("\",");


                // Issue Date

                json.append("\"issueDate\":\"")
                        .append(
                                borrowing.getIssueDate()
                        )
                        .append("\",");


                // Due Date

                json.append("\"dueDate\":\"")
                        .append(
                                borrowing.getDueDate()
                        )
                        .append("\",");


                // Status

                json.append("\"status\":\"")
                        .append(
                                escapeJson(
                                        borrowing.getStatus()
                                )
                        )
                        .append("\"");


                json.append("}");
            }


            json.append("]");


            response.getWriter().write(
                    json.toString()
            );


        } catch (NumberFormatException e) {

            response.getWriter().write("[]");
        }
    }


    // =========================================================
    // RETURN BOOK
    // Fine is calculated automatically by backend
    // =========================================================

    private void returnBook(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {


        String contextPath =
                request.getContextPath();


        try {


            // =================================================
            // BORROWING ID
            // =================================================

            String borrowingIdParameter =
                    request.getParameter(
                            "borrowingId"
                    );


            // =================================================
            // RETURN DATE
            // =================================================

            String returnDateParameter =
                    request.getParameter(
                            "returnDate"
                    );


            // =================================================
            // VALIDATION
            // =================================================

            if (borrowingIdParameter == null ||
                    borrowingIdParameter.trim().isEmpty() ||
                    returnDateParameter == null ||
                    returnDateParameter.trim().isEmpty()) {


                response.sendRedirect(
                        contextPath
                                + "/ReturnBookController"
                                + "?message=emptyFields"
                );

                return;
            }


            // =================================================
            // CONVERT VALUES
            // =================================================

            int borrowingId =
                    Integer.parseInt(
                            borrowingIdParameter
                    );


            Date returnDate =
                    Date.valueOf(
                            returnDateParameter
                    );


            // =================================================
            // RETURN BOOK
            //
            // Fine is NOT received from JSP.
            // Backend will calculate fine automatically.
            // =================================================

            boolean returned =
                    borrowingService.returnBook(
                            borrowingId,
                            returnDate
            );

            // =================================================
            // SUCCESS
            // =================================================

            if (returned) {

                response.sendRedirect(
                        contextPath
                                + "/ReturnBookController"
                                + "?message=bookReturned"
                );
            }


            // =================================================
            // FAILED
            // =================================================

            else {

                response.sendRedirect(
                        contextPath
                                + "/ReturnBookController"
                                + "?message=returnFailed"
                );
            }


        } catch (NumberFormatException e) {

            e.printStackTrace();

            response.sendRedirect(
                    contextPath
                            + "/ReturnBookController"
                            + "?message=returnFailed"
            );


        } catch (IllegalArgumentException e) {

            e.printStackTrace();

            response.sendRedirect(
                    contextPath
                            + "/ReturnBookController"
                            + "?message=returnFailed"
            );
        }
    }


    // =========================================================
    // ESCAPE JSON
    // =========================================================

    private String escapeJson(String value) {

        if (value == null) {

            return "";
        }


        return value
                .replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\r", "\\r")
                .replace("\n", "\\n");
    }

}