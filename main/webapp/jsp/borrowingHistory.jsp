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

    <title>Borrowing History - Library Management System</title>

    <!-- Borrowing History CSS -->

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/Assets/CSS/borrowingHistory.css">

    <!-- Font Awesome -->

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

</head>


<body>

    <!-- Header -->

    <jsp:include page="/jsp/includes/header.jsp" />


    <!-- Main Layout -->

    <div class="dashboard-layout">

        <!-- Sidebar -->

        <jsp:include page="/jsp/includes/sidebar.jsp" />


        <!-- Main Content -->

        <main class="borrowing-history-content">


            <!-- Page Header -->

            <div class="history-header">

                <div class="page-title-area">

                    <div class="page-title-icon">

                        <i class="fa-solid fa-clock-rotate-left"></i>

                    </div>

                    <div>

                        <h1>Borrowing History</h1>

                        <p>Track issued, returned and overdue books</p>

                    </div>

                </div>


                <!-- Back to Dashboard -->

                <a href="${pageContext.request.contextPath}/DashboardController"
                   class="back-btn">

                    <i class="fa-solid fa-arrow-left"></i>

                    Back to Dashboard

                </a>

            </div>



            <!-- SUMMARY CARDS -->

            <section class="history-summary">


                <!-- Total Transactions -->

                <div class="summary-card">

                    <div class="summary-icon total-icon">

                        <i class="fa-solid fa-book"></i>

                    </div>

                    <div class="summary-info">

                        <span>Total Transactions</span>

                        <h2>${totalTransactions}</h2>

                    </div>

                </div>


                <!-- Currently Issued -->

                <div class="summary-card">

                    <div class="summary-icon issued-icon">

                        <i class="fa-solid fa-book-open"></i>

                    </div>

                    <div class="summary-info">

                        <span>Currently Issued</span>

                        <h2>${currentlyIssued}</h2>

                    </div>

                </div>


                <!-- Returned -->

                <div class="summary-card">

                    <div class="summary-icon returned-icon">

                        <i class="fa-solid fa-circle-check"></i>

                    </div>

                    <div class="summary-info">

                        <span>Returned</span>

                        <h2>${returnedBooks}</h2>

                    </div>

                </div>


                <!-- Overdue -->

                <div class="summary-card">

                    <div class="summary-icon overdue-icon">

                        <i class="fa-solid fa-triangle-exclamation"></i>

                    </div>

                    <div class="summary-info">

                        <span>Overdue</span>

                        <h2>${overdueBooks}</h2>

                    </div>

                </div>


            </section>



            <!-- TRANSACTION HISTORY -->

            <section class="history-card">


                <!-- Card Header -->

                <div class="card-header">

                    <div>

                        <h2>Transaction History</h2>

                        <p>All book borrowing records</p>

                    </div>

                </div>



                <!-- FILTERS -->

                <div class="history-filters">


                    <!-- Search -->

                    <div class="search-box">

                        <i class="fa-solid fa-magnifying-glass"></i>

                        <input type="text"
                               id="historySearch"
                               placeholder="Search member or book..."
                               autocomplete="off">

                    </div>


                    <!-- Status Filter -->

                    <div class="filter-box">

                        <i class="fa-solid fa-filter"></i>

                        <select id="statusFilter">

                            <option value="all">
                                All Status
                            </option>

                            <option value="issued">
                                Issued
                            </option>

                            <option value="returned">
                                Returned
                            </option>

                            <option value="overdue">
                                Overdue
                            </option>

                        </select>

                    </div>

                </div>



                <!-- TABLE -->

                <div class="table-wrapper">

                    <table class="history-table">


                        <!-- TABLE HEADER -->

                        <thead>

                            <tr>

                                <th>#</th>

                                <th>MEMBER</th>

                                <th>BOOK</th>

                                <th>ISSUE DATE</th>

                                <th>DUE DATE</th>

                                <th>RETURN DATE</th>

                                <th>STATUS</th>

                                <th>FINE</th>

                                <th>ACTIONS</th>

                            </tr>

                        </thead>



                        <!-- TABLE BODY -->

                        <tbody id="historyTableBody">


                            <!-- Dynamic Borrowing Records -->

                            <c:forEach var="borrowing"
                                       items="${borrowingsList}"
                                       varStatus="status">

                                <tr>


                                    <!-- Number -->

                                    <td>

                                        ${status.index + 1}

                                    </td>


                                    <!-- Member -->

                                    <td>

                                        <div class="member-info">


                                            <!-- Member Avatar -->

                                            <div class="member-avatar">

                                                <c:choose>

                                                    <c:when test="${not empty borrowing.memberName}">

                                                        ${borrowing.memberName.substring(0, 1).toUpperCase()}

                                                    </c:when>

                                                    <c:otherwise>

                                                        ?

                                                    </c:otherwise>

                                                </c:choose>

                                            </div>


                                            <!-- Member Details -->

                                            <div>

                                                <strong>

                                                    ${borrowing.memberName}

                                                </strong>

                                                <span>

                                                    Member ID:
                                                    ${borrowing.memberId}

                                                </span>

                                            </div>

                                        </div>

                                    </td>


                                    <!-- Book -->

                                    <td>

                                        <div class="book-info">

                                            <i class="fa-solid fa-book"></i>

                                            <span>

                                                ${borrowing.bookTitle}

                                            </span>

                                        </div>

                                    </td>


                                    <!-- Issue Date -->

                                    <td>

                                        ${borrowing.issueDate}

                                    </td>


                                    <!-- Due Date -->

                                    <td>

                                        ${borrowing.dueDate}

                                    </td>


                                    <!-- Return Date -->

                                    <td>

                                        <c:choose>

                                            <c:when test="${not empty borrowing.returnDate}">

                                                ${borrowing.returnDate}

                                            </c:when>

                                            <c:otherwise>

                                                —

                                            </c:otherwise>

                                        </c:choose>

                                    </td>


                                    <!-- Status -->

                                    <td>

                                        <c:choose>

                                            <c:when test="${borrowing.status == 'Issued'}">

                                                <span class="status-badge issued">

                                                    Issued

                                                </span>

                                            </c:when>

                                            <c:when test="${borrowing.status == 'Returned'}">

                                                <span class="status-badge returned">

                                                    Returned

                                                </span>

                                            </c:when>

                                            <c:when test="${borrowing.status == 'Overdue'}">

                                                <span class="status-badge overdue">

                                                    Overdue

                                                </span>

                                            </c:when>

                                            <c:otherwise>

                                                <span class="status-badge">

                                                    ${borrowing.status}

                                                </span>

                                            </c:otherwise>

                                        </c:choose>

                                    </td>


                                    <!-- Fine -->

                                    <td>

                                        ₹${borrowing.fine}

                                    </td>


                                    <!-- Actions -->

                                    <td>

                                        <a href="${pageContext.request.contextPath}/BorrowingController?action=view&id=${borrowing.borrowingId}"
                                           class="action-btn view-btn"
                                           title="View Details">

                                            <i class="fa-solid fa-eye"></i>

                                        </a>

                                    </td>


                                </tr>

                            </c:forEach>


                            <!-- No Records -->

                            <c:if test="${empty borrowingsList}">

                                <tr>

                                    <td colspan="9"
                                        style="text-align: center; padding: 30px;">

                                        <div>

                                            <i class="fa-solid fa-clock-rotate-left"
                                               style="font-size: 30px; margin-bottom: 10px;">
                                            </i>

                                            <p>
                                                No borrowing records found.
                                            </p>

                                        </div>

                                    </td>

                                </tr>

                            </c:if>


                        </tbody>

                    </table>

                </div>

            </section>

        </main>

    </div>



    <!-- SEARCH + STATUS FILTER -->

    <script>

        const searchInput =
            document.getElementById("historySearch");

        const statusFilter =
            document.getElementById("statusFilter");

        const tableBody =
            document.getElementById("historyTableBody");


        function filterHistory() {

            const searchValue =
                searchInput.value
                    .toLowerCase()
                    .trim();

            const statusValue =
                statusFilter.value
                    .toLowerCase();

            const rows =
                tableBody.querySelectorAll("tr");


            rows.forEach(row => {

                /*
                 * Ignore the "No records found"
                 * row when filtering.
                 */

                if (row.querySelector(".status-badge") === null) {

                    return;

                }


                /*
                 * Complete row text
                 */

                const rowText =
                    row.innerText.toLowerCase();


                /*
                 * Current row status
                 */

                const statusElement =
                    row.querySelector(".status-badge");


                const rowStatus =
                    statusElement
                        ? statusElement.innerText
                            .toLowerCase()
                            .trim()
                        : "";


                /*
                 * Search condition
                 */

                const matchesSearch =
                    rowText.includes(searchValue);


                /*
                 * Status condition
                 */

                const matchesStatus =
                    statusValue === "all"
                    || rowStatus === statusValue;


                /*
                 * Final result
                 */

                if (matchesSearch && matchesStatus) {

                    row.style.display = "";

                } else {

                    row.style.display = "none";

                }

            });

        }


        /*
         * Search event
         */

        searchInput.addEventListener(
            "input",
            filterHistory
        );


        /*
         * Status filter event
         */

        statusFilter.addEventListener(
            "change",
            filterHistory
        );

    </script>


</body>

</html>