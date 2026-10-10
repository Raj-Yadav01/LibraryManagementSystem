<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.util.List,com.lms.pojo.Borrowing" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Dashboard - Library Management System</title>

    <!-- Dashboard CSS -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/Assets/CSS/dashboard.css">

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
        <main class="dashboard-content">

            <!-- Page Header -->
            <div class="page-header">
                <div>
                    <h1>Dashboard</h1>
                    <p>Welcome to your Library Management System</p>
                </div>
            </div>

            <!-- Statistics -->
            <section class="stats-grid">

                <!-- Total Books -->
                <div class="stat-card">
                    <div class="stat-icon books-icon">
                        <i class="fa-solid fa-book"></i>
                    </div>

                    <div class="stat-info">
                        <span class="stat-title">Total Books</span>
                        <h2>${totalBooks}</h2>
                    </div>
                </div>

                <!-- Total Members -->
                <div class="stat-card">
                    <div class="stat-icon members-icon">
                        <i class="fa-solid fa-users"></i>
                    </div>

                    <div class="stat-info">
                        <span class="stat-title">Total Members</span>
                        <h2>${totalMembers}</h2>
                    </div>
                </div>

                <!-- Issued Books -->
                <div class="stat-card">
                    <div class="stat-icon issued-icon">
                        <i class="fa-solid fa-book-open"></i>
                    </div>

                    <div class="stat-info">
                        <span class="stat-title">Issued Books</span>
                        <h2>${issuedBooks}</h2>
                    </div>
                </div>

                <!-- Available Books -->
                <div class="stat-card">
                    <div class="stat-icon available-icon">
                        <i class="fa-solid fa-book-bookmark"></i>
                    </div>

                    <div class="stat-info">
                        <span class="stat-title">Available Copies</span>
                        <h2>${availableBooks}</h2>
                    </div>
                </div>

            </section>

            <!-- Quick Actions -->
            <section class="dashboard-section">

                <div class="section-header">
                    <div>
                        <h2>Quick Actions</h2>
                        <p>Frequently used library operations</p>
                    </div>
                </div>

                <div class="quick-actions">

                    
                    <!-- Add Book -->

					<a href="${pageContext.request.contextPath}/BookController?action=addBook"
					   class="action-card">
					
					    <div class="action-icon">
					        <i class="fa-solid fa-plus"></i>
					    </div>
					
					    <div>
					        <h3>Add Book</h3>
					        <p>Add a new book to the library</p>
					    </div>
					
					</a>

                    <!-- View Books -->
                    <a href="${pageContext.request.contextPath}/BookController"
   						class="action-card">

                        <div class="action-icon">
                            <i class="fa-solid fa-book"></i>
                        </div>

                        <div>
                            <h3>View Books</h3>
                            <p>View and manage all books</p>
                        </div>
                    </a>

                    <!-- Members -->
                    <a href="${pageContext.request.contextPath}/MemberController"
                       class="action-card">

                        <div class="action-icon">
                            <i class="fa-solid fa-user-group"></i>
                        </div>

                        <div>
                            <h3>Members</h3>
                            <p>Manage library members</p>
                        </div>
                    </a>

                    <!-- Issue Book -->
                    <a href="${pageContext.request.contextPath}/IssueBookController"
                       class="action-card">

                        <div class="action-icon">
                            <i class="fa-solid fa-arrow-right-from-bracket"></i>
                        </div>

                        <div>
                            <h3>Issue Book</h3>
                            <p>Issue a book to a member</p>
                        </div>
                    </a>

                </div>
            </section>

            <!-- Recent Activity -->
            <section class="dashboard-section">

                <div class="section-header">
                    <div>
                        <h2>Recent Activity</h2>
                        <p>Latest library activities</p>
                    </div>
                </div>

                <div class="activity-card">

                    <%
                        List<Borrowing> recentActivities =
                        	(List<Borrowing>) request.getAttribute("recentActivities");
                    %>

                    <% if (recentActivities != null
                            && !recentActivities.isEmpty()) { %>

                        <div class="activity-list">

                            <% for (Borrowing activity : recentActivities) { %>

                                <div class="activity-item">

                                    <div class="empty-icon">
                                        <i class="fa-solid fa-clock-rotate-left"></i>
                                    </div>

                                    <div class="activity-details">

                                        <h3>
                                            <%= activity.getMemberName() != null
                                                ? activity.getMemberName()
                                                : "Unknown Member" %>
                                        </h3>

                                        <p>
                                            Book:
                                            <%= activity.getBookTitle() != null
                                                ? activity.getBookTitle()
                                                : "Unknown Book" %>
                                        </p>

                                        <p>
                                            Status:
                                            <strong>
                                                <%= activity.getStatus() != null
                                                    ? activity.getStatus()
                                                    : "Unknown" %>
                                            </strong>
                                        </p>

                                        <p>
                                            Issue Date:
                                            <%= activity.getIssueDate() != null
                                                ? activity.getIssueDate()
                                                : "N/A" %>
                                        </p>

                                    </div>

                                </div>

                            <% } %>

                        </div>

                    <% } else { %>

                        <div class="empty-activity">

                            <div class="empty-icon">
                                <i class="fa-solid fa-clock-rotate-left"></i>
                            </div>

                            <h3>No Recent Activity</h3>

                            <p>
                                Recent library activities will appear here.
                            </p>

                        </div>

                    <% } %>

                </div>

            </section>

        </main>

    </div>

</body>
</html>