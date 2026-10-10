<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Borrowing Details - Library Management System</title>

    <!-- Font Awesome -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

    <!-- Main CSS -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/Assets/CSS/dashboard.css">

    <style>

        .details-container {
            margin-left: 270px;
            margin-top: 70px;
            padding: 30px;
            min-height: calc(100vh - 70px);
            background: #f5f7fb;
        }

        .details-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }

        .details-header h1 {
            margin: 0;
            color: #172033;
            font-size: 28px;
        }

        .back-btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 18px;
            background: #0f766e;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            transition: 0.3s;
        }

        .back-btn:hover {
            background: #0b5f59;
        }

        .details-card {
            background: white;
            border-radius: 14px;
            padding: 30px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
            max-width: 1000px;
        }

        .details-title {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 25px;
            padding-bottom: 18px;
            border-bottom: 1px solid #e5e7eb;
        }

        .details-title i {
            width: 45px;
            height: 45px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: #e6fffa;
            color: #0f766e;
            border-radius: 10px;
            font-size: 20px;
        }

        .details-title h2 {
            margin: 0;
            color: #172033;
            font-size: 21px;
        }

        .details-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
        }

        .detail-item {
            padding: 18px;
            background: #f8fafc;
            border-radius: 10px;
            border: 1px solid #eef1f5;
        }

        .detail-label {
            display: block;
            font-size: 13px;
            color: #6b7280;
            margin-bottom: 7px;
        }

        .detail-value {
            font-size: 16px;
            font-weight: 600;
            color: #172033;
        }

        .status-badge {
            display: inline-block;
            padding: 6px 13px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
        }

        .status-issued {
            background: #dbeafe;
            color: #1d4ed8;
        }

        .status-returned {
            background: #dcfce7;
            color: #15803d;
        }

        .status-overdue {
            background: #fee2e2;
            color: #dc2626;
        }

        .fine-value {
            color: #dc2626;
        }

        .notes-box {
            margin-top: 20px;
            padding: 18px;
            background: #f8fafc;
            border-radius: 10px;
            border: 1px solid #eef1f5;
        }

        .notes-box .detail-label {
            margin-bottom: 8px;
        }

        .notes-text {
            color: #374151;
            line-height: 1.6;
        }

        .no-notes {
            color: #9ca3af;
            font-style: italic;
        }

        @media (max-width: 768px) {

            .details-container {
                margin-left: 0;
                padding: 20px;
            }

            .details-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }

            .details-grid {
                grid-template-columns: 1fr;
            }

            .details-card {
                padding: 20px;
            }
        }

    </style>

</head>

<body>

    <!-- Header -->
    <jsp:include page="includes/header.jsp" />

    <!-- Sidebar -->
    <jsp:include page="includes/sidebar.jsp" />


    <!-- Main Content -->

    <main class="details-container">

        <!-- Page Header -->

        <div class="details-header">

            <h1>
                <i class="fa-solid fa-file-lines"></i>
                Borrowing Details
            </h1>

            <a href="${pageContext.request.contextPath}/BorrowingController"
               class="back-btn">

                <i class="fa-solid fa-arrow-left"></i>

                Back to History

            </a>

        </div>


        <!-- Details Card -->

        <div class="details-card">

            <div class="details-title">

                <i class="fa-solid fa-book-open"></i>

                <h2>
                    Transaction Information
                </h2>

            </div>


            <div class="details-grid">


                <!-- Borrowing ID -->

                <div class="detail-item">

                    <span class="detail-label">
                        Borrowing ID
                    </span>

                    <span class="detail-value">

                        #${borrowing.borrowingId}

                    </span>

                </div>


                <!-- Member -->

                <div class="detail-item">

                    <span class="detail-label">
                        Member
                    </span>

                    <span class="detail-value">

                        ${borrowing.memberName}

                    </span>

                </div>


                <!-- Book -->

                <div class="detail-item">

                    <span class="detail-label">
                        Book
                    </span>

                    <span class="detail-value">

                        ${borrowing.bookTitle}

                    </span>

                </div>


                <!-- Issue Date -->

                <div class="detail-item">

                    <span class="detail-label">
                        Issue Date
                    </span>

                    <span class="detail-value">

                        ${borrowing.issueDate}

                    </span>

                </div>


                <!-- Due Date -->

                <div class="detail-item">

                    <span class="detail-label">
                        Due Date
                    </span>

                    <span class="detail-value">

                        ${borrowing.dueDate}

                    </span>

                </div>


                <!-- Return Date -->

                <div class="detail-item">

                    <span class="detail-label">
                        Return Date
                    </span>

                    <span class="detail-value">

                        <c:choose>

                            <c:when test="${not empty borrowing.returnDate}">

                                ${borrowing.returnDate}

                            </c:when>

                            <c:otherwise>

                                <span style="color:#9ca3af;">
                                    Not Returned
                                </span>

                            </c:otherwise>

                        </c:choose>

                    </span>

                </div>


                <!-- Status -->

                <div class="detail-item">

                    <span class="detail-label">
                        Status
                    </span>

                    <span class="detail-value">

                        <c:choose>

                            <c:when test="${borrowing.status == 'Issued'}">

                                <span class="status-badge status-issued">
                                    Issued
                                </span>

                            </c:when>

                            <c:when test="${borrowing.status == 'Returned'}">

                                <span class="status-badge status-returned">
                                    Returned
                                </span>

                            </c:when>

                            <c:when test="${borrowing.status == 'Overdue'}">

                                <span class="status-badge status-overdue">
                                    Overdue
                                </span>

                            </c:when>

                            <c:otherwise>

                                <span class="status-badge">
                                    ${borrowing.status}
                                </span>

                            </c:otherwise>

                        </c:choose>

                    </span>

                </div>


                <!-- Fine -->

                <div class="detail-item">

                    <span class="detail-label">
                        Fine
                    </span>

                    <span class="detail-value fine-value">

                        ₹${borrowing.fine}

                    </span>

                </div>

            </div>


            <!-- Notes -->

            <div class="notes-box">

                <span class="detail-label">
                    Notes
                </span>

                <div class="notes-text">

                    <c:choose>

                        <c:when test="${not empty borrowing.notes}">

                            ${borrowing.notes}

                        </c:when>

                        <c:otherwise>

                            <span class="no-notes">
                                No notes available.
                            </span>

                        </c:otherwise>

                    </c:choose>

                </div>

            </div>

        </div>

    </main>

</body>

</html>