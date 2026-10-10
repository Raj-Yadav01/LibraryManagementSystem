package com.lms.controller;

import java.io.IOException;
import java.util.List;

import com.lms.pojo.Book;
import com.lms.service.BookService;
import com.lms.serviceImpl.BookServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/BookController")
public class BookController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final BookService bookService = new BookServiceImpl();

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

        String action = request.getParameter("action");

        // ==============================
        // ADD BOOK PAGE
        // ==============================
        if ("addBook".equalsIgnoreCase(action)) {

            request.getRequestDispatcher(
                "/jsp/addBook.jsp"
            ).forward(request, response);

            return;
        }

        // ==============================
        // DELETE BOOK
        // ==============================
        if ("deleteBook".equalsIgnoreCase(action)) {

            deleteBook(request, response);

            return;
        }

        // ==============================
        // EDIT BOOK
        // ==============================
        if ("editBook".equalsIgnoreCase(action)) {

            editBook(request, response);

            return;
        }

        // ==============================
        // DEFAULT → SHOW BOOKS
        // ==============================
        showBooks(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request,
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

        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");

        // ==============================
        // ADD BOOK
        // ==============================
        if ("addBook".equalsIgnoreCase(action)) {

            addBook(request, response);

        }

        // ==============================
        // UPDATE BOOK
        // ==============================
        else if ("updateBook".equalsIgnoreCase(action)) {

            updateBook(request, response);

        }

        // ==============================
        // DEFAULT
        // ==============================
        else {

            response.sendRedirect(
                request.getContextPath()
                + "/BookController"
            );
        }
    }


    // =========================================================
    // DISPLAY ALL BOOKS
    // =========================================================

    private void showBooks(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        List<Book> books = bookService.getAllBooks();

        request.setAttribute("booksList", books);

        request.setAttribute(
            "totalBooks",
            bookService.getTotalBooks()
        );

        request.setAttribute(
            "availableCopies",
            bookService.getAvailableCopies()
        );

        request.setAttribute(
            "issuedCopies",
            bookService.getIssuedCopies()
        );

        request.getRequestDispatcher(
            "/jsp/books.jsp"
        ).forward(request, response);
    }


    // =========================================================
    // OPEN ADD BOOK PAGE
    // =========================================================

    // GET:
    // /BookController?action=addBook
    //
    // This is handled directly inside doGet().
    // POST addBook is handled below.


    // =========================================================
    // ADD NEW BOOK
    // =========================================================

    private void addBook(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String contextPath = request.getContextPath();

        try {

            String title =
                request.getParameter("title");

            String author =
                request.getParameter("author");

            String category =
                request.getParameter("category");

            String isbn =
                request.getParameter("isbn");

            String publisher =
                request.getParameter("publisher");


            int totalPages =
                Integer.parseInt(
                    request.getParameter("totalPages")
                );


            int totalCopies =
                Integer.parseInt(
                    request.getParameter("totalCopies")
                );


            // Validation
            if (title == null
                    || title.trim().isEmpty()

                    || author == null
                    || author.trim().isEmpty()

                    || category == null
                    || category.trim().isEmpty()

                    || isbn == null
                    || isbn.trim().isEmpty()

                    || totalPages <= 0

                    || totalCopies <= 0) {

                response.sendRedirect(
                    contextPath
                    + "/BookController?action=addBook&error=invalid"
                );

                return;
            }


            // Create Book object
            Book book = new Book();

            book.setTitle(
                title.trim()
            );

            book.setAuthor(
                author.trim()
            );

            book.setCategory(
                category.trim()
            );

            book.setIsbn(
                isbn.trim()
            );

            book.setPublisher(
                publisher == null
                    ? ""
                    : publisher.trim()
            );

            book.setTotalPages(
                totalPages
            );

            book.setTotalCopies(
                totalCopies
            );

            book.setAvailableCopies(
                totalCopies
            );


            // Save book
            boolean saved =
                bookService.addBook(book);


            if (saved) {

                response.sendRedirect(
                    contextPath
                    + "/BookController?message=added"
                );

            } else {

                response.sendRedirect(
                    contextPath
                    + "/BookController?action=addBook&error=save"
                );
            }


        } catch (NumberFormatException e) {

            response.sendRedirect(
                contextPath
                + "/BookController?action=addBook&error=invalid"
            );
        }
    }


    // =========================================================
    // LOAD BOOK FOR EDIT
    // =========================================================

    private void editBook(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        try {

            int bookId =
                Integer.parseInt(
                    request.getParameter("id")
                );


            Book book =
                bookService.getBookById(bookId);


            if (book == null) {

                response.sendRedirect(
                    request.getContextPath()
                    + "/BookController?error=notfound"
                );

                return;
            }


            request.setAttribute(
                "book",
                book
            );


            request.getRequestDispatcher(
                "/jsp/addBook.jsp"
            ).forward(
                request,
                response
            );


        } catch (NumberFormatException e) {

            response.sendRedirect(
                request.getContextPath()
                + "/BookController"
            );
        }
    }


    // =========================================================
    // UPDATE BOOK
    // =========================================================

    private void updateBook(HttpServletRequest request,
                            HttpServletResponse response)
            throws ServletException, IOException {

        String contextPath =
            request.getContextPath();


        try {

            int bookId =
                Integer.parseInt(
                    request.getParameter("bookId")
                );


            int totalPages =
                Integer.parseInt(
                    request.getParameter("totalPages")
                );


            int totalCopies =
                Integer.parseInt(
                    request.getParameter("totalCopies")
                );


            Book oldBook =
                bookService.getBookById(bookId);


            if (oldBook == null) {

                response.sendRedirect(
                    contextPath
                    + "/BookController?error=notfound"
                );

                return;
            }


            // Already issued copies
            int oldIssuedCopies =
                oldBook.getTotalCopies()
                - oldBook.getAvailableCopies();


            // Validation
            if (totalCopies < oldIssuedCopies
                    || totalPages <= 0
                    || totalCopies <= 0) {

                response.sendRedirect(
                    contextPath
                    + "/BookController?error=invalid"
                );

                return;
            }


            String title =
                request.getParameter("title");

            String author =
                request.getParameter("author");

            String category =
                request.getParameter("category");

            String isbn =
                request.getParameter("isbn");

            String publisher =
                request.getParameter("publisher");


            if (title == null
                    || title.trim().isEmpty()

                    || author == null
                    || author.trim().isEmpty()

                    || category == null
                    || category.trim().isEmpty()

                    || isbn == null
                    || isbn.trim().isEmpty()) {

                response.sendRedirect(
                    contextPath
                    + "/BookController?error=invalid"
                );

                return;
            }


            // Create updated Book
            Book book = new Book();

            book.setBookId(
                bookId
            );

            book.setTitle(
                title.trim()
            );

            book.setAuthor(
                author.trim()
            );

            book.setCategory(
                category.trim()
            );

            book.setIsbn(
                isbn.trim()
            );

            book.setPublisher(
                publisher == null
                    ? ""
                    : publisher.trim()
            );

            book.setTotalPages(
                totalPages
            );

            book.setTotalCopies(
                totalCopies
            );

            // Preserve already issued copies
            book.setAvailableCopies(
                totalCopies - oldIssuedCopies
            );


            boolean updated =
                bookService.updateBook(book);


            if (updated) {

                response.sendRedirect(
                    contextPath
                    + "/BookController?message=updated"
                );

            } else {

                response.sendRedirect(
                    contextPath
                    + "/BookController?error=update"
                );
            }


        } catch (NumberFormatException e) {

            response.sendRedirect(
                contextPath
                + "/BookController?error=invalid"
            );
        }
    }


    // =========================================================
    // DELETE BOOK
    // =========================================================

    private void deleteBook(HttpServletRequest request,
                            HttpServletResponse response)
            throws ServletException, IOException {

        String contextPath =
            request.getContextPath();


        try {

            int bookId =
                Integer.parseInt(
                    request.getParameter("id")
                );


            Book book =
                bookService.getBookById(bookId);


            if (book == null) {

                response.sendRedirect(
                    contextPath
                    + "/BookController?message=deleteFailed"
                );

                return;
            }


            boolean deleted =
                bookService.deleteBook(bookId);


            if (deleted) {

                response.sendRedirect(
                    contextPath
                    + "/BookController?message=deleted"
                );

            } else {

                response.sendRedirect(
                    contextPath
                    + "/BookController?message=bookLinked"
                );
            }


        } catch (NumberFormatException e) {

            response.sendRedirect(
                contextPath
                + "/BookController?message=deleteFailed"
            );
        }
    }
}