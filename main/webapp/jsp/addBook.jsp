<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>
        ${empty book ? 'Add Book' : 'Edit Book'} | Library Management System
    </title>

    <!-- Font Awesome -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

    <!-- Add Book CSS -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/Assets/CSS/addBook.css">

</head>

<body>

    <!-- HEADER -->
    <jsp:include page="/jsp/includes/header.jsp" />

    <!-- MAIN LAYOUT -->
    <div class="dashboard-layout">

        <!-- SIDEBAR -->
        <jsp:include page="/jsp/includes/sidebar.jsp" />

        <!-- MAIN CONTENT -->
        <main class="add-book-content">

            <!-- PAGE HEADER -->
            <div class="add-book-header">

                <div class="page-title">

                    <div class="page-title-icon">
                        <i class="fa-solid fa-book-medical"></i>
                    </div>

                    <div>
                        <h1>
                            ${empty book ? 'Add New Book' : 'Edit Book'}
                        </h1>

                        <p>
                            ${empty book
                                ? 'Add a new book to your library collection'
                                : 'Update the selected book information'}
                        </p>
                    </div>

                </div>

                <!-- BACK BUTTON -->
                <a href="${pageContext.request.contextPath}/BookController"
                   class="back-btn">

                    <i class="fa-solid fa-arrow-left"></i>

                    <span>Back to Books</span>

                </a>

            </div>

            <!-- FORM CARD -->
            <section class="add-book-card">

                <!-- CARD HEADER -->
                <div class="form-card-header">

                    <div class="form-header-icon">
                        <i class="fa-solid fa-book-open"></i>
                    </div>

                    <div>
                        <h2>Book Information</h2>

                        <p>
                            ${empty book
                                ? 'Enter the details of the new book'
                                : 'Edit the details you want to change'}
                        </p>
                    </div>

                </div>

                <!-- FORM -->
                <form
                    action="${pageContext.request.contextPath}/BookController"
                    method="post"
                    class="book-form">

                    <!-- ACTION -->
                    <input
                        type="hidden"
                        name="action"
                        value="${empty book ? 'addBook' : 'updateBook'}">

                    <!-- BOOK ID FOR EDIT -->
                    <c:if test="${not empty book}">
                        <input
                            type="hidden"
                            name="bookId"
                            value="${book.bookId}">
                    </c:if>

                    <!-- BASIC INFORMATION -->
                    <div class="form-section-title">

                        <i class="fa-solid fa-circle-info"></i>

                        <span>Basic Information</span>

                    </div>

                    <div class="form-grid">

                        <!-- TITLE -->
                        <div class="form-group full-width">

                            <label for="title">
                                Book Title <span>*</span>
                            </label>

                            <div class="input-wrapper">

                                <i class="fa-solid fa-book input-icon"></i>

                                <input
                                    type="text"
                                    id="title"
                                    name="title"
                                    placeholder="Enter book title"
                                    value="<c:out value='${book.title}'/>"
                                    required>

                            </div>

                        </div>

                        <!-- AUTHOR -->
                        <div class="form-group">

                            <label for="author">
                                Author <span>*</span>
                            </label>

                            <div class="input-wrapper">

                                <i class="fa-solid fa-user-pen input-icon"></i>

                                <input
                                    type="text"
                                    id="author"
                                    name="author"
                                    placeholder="Enter author name"
                                    value="<c:out value='${book.author}'/>"
                                    required>

                            </div>

                        </div>

                        <!-- CATEGORY -->
                        <div class="form-group">

                            <label for="category">
                                Category <span>*</span>
                            </label>

                            <div class="input-wrapper">

                                <i class="fa-solid fa-layer-group input-icon"></i>

                                <select
                                    id="category"
                                    name="category"
                                    required>

                                    <option value=""
                                        ${empty book.category ? 'selected' : ''}>
                                        Select category
                                    </option>

                                    <option value="Fiction"
                                        ${book.category == 'Fiction' ? 'selected' : ''}>
                                        Fiction
                                    </option>

                                    <option value="Technology"
                                        ${book.category == 'Technology' ? 'selected' : ''}>
                                        Technology
                                    </option>

                                    <option value="Programming"
                                        ${book.category == 'Programming' ? 'selected' : ''}>
                                        Programming
                                    </option>

                                    <option value="Database"
                                        ${book.category == 'Database' ? 'selected' : ''}>
                                        Database
                                    </option>

                                    <option value="Science"
                                        ${book.category == 'Science' ? 'selected' : ''}>
                                        Science
                                    </option>

                                    <option value="History"
                                        ${book.category == 'History' ? 'selected' : ''}>
                                        History
                                    </option>

                                    <option value="Other"
                                        ${book.category == 'Other' ? 'selected' : ''}>
                                        Other
                                    </option>

                                </select>

                            </div>

                        </div>

                        <!-- ISBN -->
                        <div class="form-group">

                            <label for="isbn">
                                ISBN <span>*</span>
                            </label>

                            <div class="input-wrapper">

                                <i class="fa-solid fa-barcode input-icon"></i>

                                <input
                                    type="text"
                                    id="isbn"
                                    name="isbn"
                                    placeholder="Enter ISBN number"
                                    value="<c:out value='${book.isbn}'/>"
                                    required>

                            </div>

                        </div>

                        <!-- PUBLISHER -->
                        <div class="form-group">

                            <label for="publisher">
                                Publisher
                            </label>

                            <div class="input-wrapper">

                                <i class="fa-solid fa-building input-icon"></i>

                                <input
                                    type="text"
                                    id="publisher"
                                    name="publisher"
                                    placeholder="Enter publisher name"
                                    value="<c:out value='${book.publisher}'/>">

                            </div>

                        </div>

                    </div>

                    <!-- BOOK DETAILS -->
                    <div class="form-section-title book-details-title">

                        <i class="fa-solid fa-list-ol"></i>

                        <span>Book Details</span>

                    </div>

                    <div class="form-grid">

                        <!-- TOTAL PAGES -->
                        <div class="form-group">

                            <label for="totalPages">
                                Total Pages <span>*</span>
                            </label>

                            <div class="input-wrapper">

                                <i class="fa-solid fa-file-lines input-icon"></i>

                                <input
                                    type="number"
                                    id="totalPages"
                                    name="totalPages"
                                    min="1"
                                    placeholder="e.g. 350"
                                    value="${book.totalPages > 0 ? book.totalPages : ''}"
                                    required>

                            </div>

                        </div>

                        <!-- TOTAL COPIES -->
                        <div class="form-group">

                            <label for="totalCopies">
                                Total Copies <span>*</span>
                            </label>

                            <div class="input-wrapper">

                                <i class="fa-solid fa-copy input-icon"></i>

                                <input
                                    type="number"
                                    id="totalCopies"
                                    name="totalCopies"
                                    min="1"
                                    placeholder="e.g. 5"
                                    value="${book.totalCopies > 0 ? book.totalCopies : ''}"
                                    required>

                            </div>

                        </div>

                    </div>

                    <!-- FORM ACTIONS -->
                    <div class="form-actions">

                        <a
                            href="${pageContext.request.contextPath}/BookController"
                            class="cancel-btn">

                            <i class="fa-solid fa-xmark"></i>

                            Cancel

                        </a>

                        <button
                            type="reset"
                            class="reset-btn">

                            <i class="fa-solid fa-rotate-left"></i>

                            Reset

                        </button>

                        <button
                            type="submit"
                            class="save-btn">

                            <i class="fa-solid ${empty book ? 'fa-plus' : 'fa-floppy-disk'}"></i>

                            ${empty book ? 'Add Book' : 'Update Book'}

                        </button>

                    </div>

                </form>

            </section>

        </main>

    </div>

</body>

</html>