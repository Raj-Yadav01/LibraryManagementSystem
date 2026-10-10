package com.lms.controller;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

import com.lms.pojo.Book;
import com.lms.pojo.Borrowing;
import com.lms.pojo.Member;
import com.lms.service.BookService;
import com.lms.service.MemberService;
import com.lms.service.BorrowingService;
import com.lms.serviceImpl.BookServiceImpl;
import com.lms.serviceImpl.MemberServiceImpl;
import com.lms.serviceImpl.BorrowingServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/IssueBookController")
public class IssueBookController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final BorrowingService borrowingService =
            new BorrowingServiceImpl();

    private final MemberService memberService =
            new MemberServiceImpl();

    private final BookService bookService =
            new BookServiceImpl();


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

        if (session == null ||
                session.getAttribute("loggedInUser") == null) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/jsp/login.jsp"
            );

            return;
        }

        loadIssueBookPage(request, response);
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

        if ("issueBook".equalsIgnoreCase(action)) {

            issueBook(request, response);

            return;
        }

        response.sendRedirect(
                request.getContextPath()
                + "/IssueBookController"
        );
    }


    // =========================================================
    // LOAD ISSUE BOOK PAGE
    // =========================================================

    private void loadIssueBookPage(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        List<Member> members =
                memberService.getAllMembers();

        List<Book> books =
                bookService.getAllBooks();
        
        request.setAttribute(
                "membersList",
                members
        );

        request.setAttribute(
                "booksList",
                books
        );

        request.getRequestDispatcher(
                "/jsp/issueBook.jsp"
        ).forward(
                request,
                response
        );
    }


    // =========================================================
    // ISSUE BOOK
    // =========================================================

    private void issueBook(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        String contextPath =
                request.getContextPath();

        try {

            String memberIdParameter =
                    request.getParameter("member");

            String bookIdParameter =
                    request.getParameter("book");

            String issueDateParameter =
                    request.getParameter("issueDate");

            String dueDateParameter =
                    request.getParameter("dueDate");

            String notes =
                    request.getParameter("notes");


            // -------------------------------------------------
            // VALIDATION
            // -------------------------------------------------

            if (memberIdParameter == null ||
                    memberIdParameter.trim().isEmpty() ||

                bookIdParameter == null ||
                    bookIdParameter.trim().isEmpty() ||

                issueDateParameter == null ||
                    issueDateParameter.trim().isEmpty() ||

                dueDateParameter == null ||
                    dueDateParameter.trim().isEmpty()) {

                response.sendRedirect(
                        contextPath
                        + "/IssueBookController"
                        + "?message=emptyFields"
                );

                return;
            }


            int memberId =
                    Integer.parseInt(memberIdParameter);

            int bookId =
                    Integer.parseInt(bookIdParameter);


            Date issueDate =
                    Date.valueOf(issueDateParameter);

            Date dueDate =
                    Date.valueOf(dueDateParameter);


            // -------------------------------------------------
            // DUE DATE VALIDATION
            // -------------------------------------------------

            if (dueDate.before(issueDate)) {

                response.sendRedirect(
                        contextPath
                        + "/IssueBookController"
                        + "?message=invalidDate"
                );

                return;
            }


            // -------------------------------------------------
            // CREATE BORROWING
            // -------------------------------------------------

            Borrowing borrowing =
                    new Borrowing();

            borrowing.setMemberId(memberId);

            borrowing.setBookId(bookId);

            borrowing.setIssueDate(issueDate);

            borrowing.setDueDate(dueDate);

            borrowing.setReturnDate(null);

            borrowing.setStatus("Issued");

            borrowing.setFine(0);

            borrowing.setNotes(
                    notes == null
                    ? ""
                    : notes.trim()
            );


            // -------------------------------------------------
            // SAVE
            // -------------------------------------------------

            boolean issued =
                    borrowingService.issueBook(
                            borrowing
                    );


            if (issued) {

                response.sendRedirect(
                        contextPath
                        + "/IssueBookController"
                        + "?message=bookIssued"
                );

            } else {

                response.sendRedirect(
                        contextPath
                        + "/IssueBookController"
                        + "?message=issueFailed"
                );
            }


        } catch (NumberFormatException e) {

            response.sendRedirect(
                    contextPath
                    + "/IssueBookController"
                    + "?message=issueFailed"
            );

        } catch (IllegalArgumentException e) {

            response.sendRedirect(
                    contextPath
                    + "/IssueBookController"
                    + "?message=invalidDate"
            );
        }
    }
}