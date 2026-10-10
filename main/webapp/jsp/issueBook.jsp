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

    <title>Issue Book | Library Management System</title>

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/Assets/CSS/issueBook.css">

</head>


<body>


    <!-- HEADER -->

    <jsp:include page="/jsp/includes/header.jsp" />


    <!-- MAIN LAYOUT -->

    <div class="dashboard-layout">


        <!-- SIDEBAR -->

        <jsp:include page="/jsp/includes/sidebar.jsp" />


        <!-- MAIN CONTENT -->

        <main class="issue-book-content">


            <!-- PAGE HEADER -->

            <div class="issue-book-header">

                <div class="page-title">

                    <div class="page-title-icon">
                        <i class="fa-solid fa-book-open"></i>
                    </div>

                    <div>

                        <h1>
                            Issue Book
                        </h1>

                        <p>
                            Issue a book to a library member
                        </p>

                    </div>

                </div>


                <a href="${pageContext.request.contextPath}/jsp/dashboard.jsp"
                   class="back-btn">

                    <i class="fa-solid fa-arrow-left"></i>

                    <span>
                        Back to Dashboard
                    </span>

                </a>

            </div>



            <!-- FORM CARD -->

            <section class="issue-book-card">


                <!-- CARD HEADER -->

                <div class="form-card-header">

                    <div class="form-header-icon">

                        <i class="fa-solid fa-book-open-reader"></i>

                    </div>

                    <div>

                        <h2>
                            Issue Book Information
                        </h2>

                        <p>
                            Select a member and book to create an issue transaction
                        </p>

                    </div>

                </div>



				<%
					String message = request.getParameter("message");
					%>
					
					<% if ("bookIssued".equals(message)) { %>
					
					    <div class="alert alert-success">
					        <i class="fa-solid fa-circle-check"></i>
					        Book issued successfully.
					    </div>
					
					<% } else if ("emptyFields".equals(message)) { %>
					
					    <div class="alert alert-error">
					        <i class="fa-solid fa-circle-exclamation"></i>
					        Please fill all required fields.
					    </div>
					
					<% } else if ("invalidDate".equals(message)) { %>
					
					    <div class="alert alert-error">
					        <i class="fa-solid fa-circle-exclamation"></i>
					        Due date cannot be before issue date.
					    </div>
					
					<% } else if ("issueFailed".equals(message)) { %>
					
					    <div class="alert alert-error">
					        <i class="fa-solid fa-circle-exclamation"></i>
					        Book could not be issued. The book may be unavailable or the member may already have this book.
					    </div>
					
					<% } %>



                <!-- FORM -->

                <form class="issue-book-form"
				      action="${pageContext.request.contextPath}/IssueBookController"
				      method="post">
				
				    <input type="hidden" name="action" value="issueBook">


                    <!-- TRANSACTION INFORMATION -->

                    <div class="form-section-title">

                        <i class="fa-solid fa-circle-info"></i>

                        <span>
                            Transaction Information
                        </span>

                    </div>



                    <div class="form-grid">


                        <!-- MEMBER -->

                        <div class="form-group">

                            <label for="member">

                                Select Member

                                <span>*</span>

                            </label>

                            <div class="input-wrapper">

                                <i class="fa-solid fa-user input-icon"></i>

                                <select id="member"
                                        name="member"
                                        required>

                                    <c:forEach var="member" items="${membersList}">
									    <c:if test="${member.status == 'Active'}">
									        <option value="${member.memberId}">
									            ${member.firstName} ${member.lastName} - ${member.email}
									        </option>
									    </c:if>
									</c:forEach>

                                </select>

                            </div>

                        </div>



                        <!-- BOOK -->

                        <div class="form-group">

                            <label for="book">

                                Select Book

                                <span>*</span>

                            </label>

                            <div class="input-wrapper">

                                <i class="fa-solid fa-book input-icon"></i>

                                <select id="book"
                                        name="book"
                                        required>

                                    <c:forEach var="book" items="${booksList}">
									    <c:if test="${book.availableCopies > 0}">
									        <option value="${book.bookId}">
									            ${book.title} - ${book.author}
									        </option>
									    </c:if>
									</c:forEach>

                                </select>

                            </div>

                        </div>



                        <!-- ISSUE DATE -->

                        <div class="form-group">

                            <label for="issueDate">

                                Issue Date

                                <span>*</span>

                            </label>

                            <div class="input-wrapper">

                                <i class="fa-solid fa-calendar-days input-icon"></i>

                                <input
                                    type="date"
                                    id="issueDate"
                                    name="issueDate"
                                    required>

                            </div>

                        </div>



                        <!-- DUE DATE -->

                        <div class="form-group">

                            <label for="dueDate">

                                Due Date

                                <span>*</span>

                            </label>

                            <div class="input-wrapper">

                                <i class="fa-solid fa-calendar-check input-icon"></i>

                                <input
                                    type="date"
                                    id="dueDate"
                                    name="dueDate"
                                    required>

                            </div>

                        </div>


                    </div>



                    <!-- ADDITIONAL INFORMATION -->

                    <div class="form-section-title details-section">

                        <i class="fa-solid fa-note-sticky"></i>

                        <span>
                            Additional Information
                        </span>

                    </div>



                    <div class="form-group full-width">

                        <label for="notes">
                            Notes
                        </label>

                        <div class="textarea-wrapper">

                            <i class="fa-solid fa-pen input-icon textarea-icon"></i>

                            <textarea
                                id="notes"
                                name="notes"
                                rows="5"
                                placeholder="Enter any additional notes..."></textarea>

                        </div>

                    </div>



                    <!-- BOOK ISSUE INFO -->

                    <div class="issue-info-box">

                        <div class="issue-info-icon">

                            <i class="fa-solid fa-circle-info"></i>

                        </div>

                        <div>

                            <strong>
                                Issue Information
                            </strong>

                            <p>
                                Please make sure the selected book is available
                                before issuing it to the member.
                            </p>

                        </div>

                    </div>



                    <!-- ACTIONS -->

                    <div class="form-actions">


                        <a
                            href="${pageContext.request.contextPath}/jsp/dashboard.jsp"
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
                            class="issue-btn">

                            <i class="fa-solid fa-book-open"></i>

                            Issue Book

                        </button>


                    </div>


                </form>


            </section>


        </main>


    </div>


    <!-- DATE SCRIPT -->

    <script>

        const issueDate =
            document.getElementById("issueDate");

        const dueDate =
            document.getElementById("dueDate");


        const today =
            new Date()
                .toISOString()
                .split("T")[0];


        issueDate.value = today;

        issueDate.min = today;

        dueDate.min = today;


        issueDate.addEventListener(
            "change",
            function () {

                dueDate.min = this.value;

                if (dueDate.value &&
                    dueDate.value < this.value) {

                    dueDate.value = this.value;

                }

            }
        );

    </script>


</body>

</html>