<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Books Management | Library Management System</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/Assets/CSS/books.css">

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
</head>

<body>

    <jsp:include page="/jsp/includes/header.jsp" />

    <div class="dashboard-layout">

        <jsp:include page="/jsp/includes/sidebar.jsp" />

        <main class="books-content">

            <!-- Page Header -->
            <div class="books-page-header">

                <div class="page-title">
                    <div class="page-title-icon">
                        <i class="fa-solid fa-book-open"></i>
                    </div>

                    <div>
                        <h1>Books Management</h1>
                        <p>Manage your library collection and available copies.</p>
                    </div>
                </div>

                <a href="${pageContext.request.contextPath}/jsp/addBook.jsp"
                   class="add-book-btn">
                    <i class="fa-solid fa-plus"></i>
                    Add New Book
                </a>

            </div>

            <!-- Soft Delete Success Message -->
            <c:if test="${param.message == 'deleted'}">
                <div class="book-message success-message">
                    <i class="fa-solid fa-circle-check"></i>
                    Book moved to inactive successfully.
                </div>
            </c:if>

            <!-- Book Linked Message -->
            <c:if test="${param.message == 'bookLinked'}">
                <div class="book-message error-message">
                    <i class="fa-solid fa-circle-exclamation"></i>
                    This book cannot be deactivated because borrowing records exist.
                </div>
            </c:if>

            <!-- Delete Failed Message -->
            <c:if test="${param.message == 'deleteFailed'}">
                <div class="book-message error-message">
                    <i class="fa-solid fa-circle-exclamation"></i>
                    Unable to deactivate this book. Please try again.
                </div>
            </c:if>

            <!-- Add Book Message -->
            <c:if test="${param.message == 'added'}">
                <div class="book-message success-message">
                    <i class="fa-solid fa-circle-check"></i>
                    Book added successfully.
                </div>
            </c:if>

            <!-- Update Book Message -->
            <c:if test="${param.message == 'updated'}">
                <div class="book-message success-message">
                    <i class="fa-solid fa-circle-check"></i>
                    Book updated successfully.
                </div>
            </c:if>

            <!-- General Error Message -->
            <c:if test="${not empty param.error}">
                <div class="book-message error-message">
                    <i class="fa-solid fa-circle-exclamation"></i>
                    <c:out value="${param.error}" />
                </div>
            </c:if>

            <!-- Book Summary -->
            <div class="book-summary">

                <div class="summary-card">
                    <div class="summary-icon books">
                        <i class="fa-solid fa-book"></i>
                    </div>

                    <div>
                        <span>Total Books</span>
                        <strong>
                            <c:out value="${totalBooks}" default="0" />
                        </strong>
                    </div>
                </div>

                <div class="summary-card">
                    <div class="summary-icon available">
                        <i class="fa-solid fa-book-open"></i>
                    </div>

                    <div>
                        <span>Available Copies</span>
                        <strong>
                            <c:out value="${availableCopies}" default="0" />
                        </strong>
                    </div>
                </div>

                <div class="summary-card">
                    <div class="summary-icon issued">
                        <i class="fa-solid fa-book-reader"></i>
                    </div>

                    <div>
                        <span>Issued Copies</span>
                        <strong>
                            <c:out value="${issuedCopies}" default="0" />
                        </strong>
                    </div>
                </div>

            </div>

            <!-- Books Table -->
            <section class="books-card">

                <div class="books-card-header">

                    <div>
                        <h2>All Books</h2>
                        <p>View and manage books in your library.</p>
                    </div>

                    <div class="book-search">
                        <i class="fa-solid fa-magnifying-glass"></i>

                        <input type="search"
                               id="bookSearch"
                               placeholder="Search by title, author, ISBN..."
                               autocomplete="off">
                    </div>

                </div>

                <div class="books-table-wrapper">

                    <table class="books-table" id="booksTable">

                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Book Details</th>
                                <th>Category</th>
                                <th>ISBN</th>
                                <th>Publisher</th>
                                <th>Total Pages</th>
                                <th>Total Copies</th>
                                <th>Available</th>
                                <th>Issued</th>
                                <th>Actions</th>
                            </tr>
                        </thead>

                        <tbody id="booksTableBody">

                            <c:choose>

                                <c:when test="${not empty booksList}">

                                    <c:forEach var="book" items="${booksList}">

                                        <tr class="book-row">

                                            <!-- Book ID -->
                                            <td>
                                                <span class="book-id">
                                                    <c:out value="${book.bookId}" />
                                                </span>
                                            </td>

                                            <!-- Book Details -->
                                            <td>
                                                <div class="book-info">

                                                    <div class="book-icon">
                                                        <i class="fa-solid fa-book"></i>
                                                    </div>

                                                    <div>
                                                        <strong>
                                                            <c:out value="${book.title}" />
                                                        </strong>

                                                        <small>
                                                            <c:out value="${book.author}" />
                                                        </small>
                                                    </div>

                                                </div>
                                            </td>

                                            <!-- Category -->
                                            <td>
                                                <span class="category">
                                                    <c:out value="${book.category}" />
                                                </span>
                                            </td>

                                            <!-- ISBN -->
                                            <td class="isbn">
                                                <c:out value="${book.isbn}" />
                                            </td>

                                            <!-- Publisher -->
                                            <td>
                                                <c:out value="${book.publisher}" />
                                            </td>

                                            <!-- Total Pages -->
                                            <td>
                                                <c:out value="${book.totalPages}" />
                                            </td>

                                            <!-- Total Copies -->
                                            <td>
                                                <c:out value="${book.totalCopies}" />
                                            </td>

                                            <!-- Available Copies -->
                                            <td>
                                                <span class="available-badge">
                                                    <c:out value="${book.availableCopies}" />
                                                </span>
                                            </td>

                                            <!-- Issued Copies -->
                                            <td>
                                                <span class="issued-badge">
                                                    ${book.totalCopies - book.availableCopies}
                                                </span>
                                            </td>

                                            <!-- Actions -->
                                            <td>
                                                <div class="action-buttons">

                                                    <!-- Edit Book -->
                                                    <a class="edit-btn"
                                                       title="Edit Book"
                                                       href="${pageContext.request.contextPath}/BookController?action=editBook&amp;id=${book.bookId}">
                                                        <i class="fa-solid fa-pen-to-square"></i>
                                                    </a>

                                                    <!-- Soft Delete Book -->
                                                    <a class="delete-btn"
                                                       title="Deactivate Book"
                                                       href="${pageContext.request.contextPath}/BookController?action=deleteBook&amp;id=${book.bookId}"
                                                       onclick="return confirm('Deactivate this book? The book will be hidden from the active list.');">
                                                        <i class="fa-solid fa-trash"></i>
                                                    </a>

                                                </div>
                                            </td>

                                        </tr>

                                    </c:forEach>

                                </c:when>

                                <c:otherwise>

                                    <tr id="emptyBooksRow">
                                        <td colspan="10">

                                            <div class="empty-state">
                                                <i class="fa-solid fa-book-open"></i>

                                                <h2>No Books Found</h2>

                                                <p>There are no active books available in the library.</p>

                                                <a href="${pageContext.request.contextPath}/jsp/addBook.jsp"
                                                   class="add-book-btn">
                                                    <i class="fa-solid fa-plus"></i>
                                                    Add Your First Book
                                                </a>
                                            </div>

                                        </td>
                                    </tr>

                                </c:otherwise>

                            </c:choose>

                            <!-- Search Empty State -->
                            <tr id="noSearchResults" style="display: none;">
                                <td colspan="10">

                                    <div class="empty-state">
                                        <i class="fa-solid fa-magnifying-glass"></i>

                                        <h2>No Matching Books</h2>

                                        <p>Try another title, author, or ISBN.</p>
                                    </div>

                                </td>
                            </tr>

                        </tbody>

                    </table>

                </div>

            </section>

        </main>

    </div>

    <!-- Book Search -->
    <script>
        document.addEventListener("DOMContentLoaded", function () {

            const searchInput = document.getElementById("bookSearch");
            const rows = document.querySelectorAll("#booksTableBody tr.book-row");
            const noSearchResults = document.getElementById("noSearchResults");

            searchInput.addEventListener("input", function () {

                const searchText = this.value.toLowerCase().trim();
                let visibleRows = 0;

                rows.forEach(function (row) {

                    const matches = row.textContent
                        .toLowerCase()
                        .includes(searchText);

                    row.style.display = matches ? "" : "none";

                    if (matches) {
                        visibleRows++;
                    }

                });

                noSearchResults.style.display =
                    searchText !== "" && visibleRows === 0 ? "" : "none";

            });

        });
    </script>

</body>
</html>