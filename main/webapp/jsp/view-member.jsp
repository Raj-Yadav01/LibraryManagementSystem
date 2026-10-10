<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="com.lms.pojo.Member" %>

<%
    Member member = (Member) request.getAttribute("member");

    if (member == null) {
        response.sendRedirect(request.getContextPath() + "/MemberController");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>View Member - Library Management System</title>

    <!-- Dashboard CSS -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/Assets/CSS/dashboard.css">

    <!-- View Member CSS -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/Assets/CSS/view-member.css">

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
                    <h1>View Member</h1>
                    <p>View member details</p>
                </div>

            </div>


            <!-- Member Card -->
            <div class="member-view-card">

                <!-- Profile Section -->
                <div class="member-profile">

                    <div class="member-avatar">
                        <%= member.getFirstName().substring(0, 1).toUpperCase() %>
                    </div>

                    <div class="member-profile-info">

                        <h2>
                            <%= member.getFullName() %>
                        </h2>

                        <p>
                            Member #<%= member.getMemberId() %>
                        </p>

                    </div>

                </div>


                <!-- Member Details -->
                <div class="member-details">

                    <!-- First Name -->
                    <div class="detail-box">

                        <label>First Name</label>

                        <span>
                            <%= member.getFirstName() %>
                        </span>

                    </div>


                    <!-- Last Name -->
                    <div class="detail-box">

                        <label>Last Name</label>

                        <span>
                            <%= member.getLastName() %>
                        </span>

                    </div>


                    <!-- Email -->
                    <div class="detail-box">

                        <label>Email</label>

                        <span>
                            <%= member.getEmail() %>
                        </span>

                    </div>


                    <!-- Phone -->
                    <div class="detail-box">

                        <label>Phone Number</label>

                        <span>
                            <%= member.getPhoneNo() %>
                        </span>

                    </div>


                    <!-- Status -->
                    <div class="detail-box">

                        <label>Status</label>

                        <span class="<%= 
                            "Active".equalsIgnoreCase(member.getStatus())
                            ? "status-active"
                            : "status-inactive"
                        %>">

                            <%= member.getStatus() %>

                        </span>

                    </div>


                    <!-- Created At -->
                    <div class="detail-box">

                        <label>Created At</label>

                        <span>

                            <%= member.getCreatedAt() != null
                                ? member.getCreatedAt()
                                : "N/A" %>

                        </span>

                    </div>

                </div>


                <!-- Bottom Actions -->
                <div class="member-actions">

                    <a href="${pageContext.request.contextPath}/MemberController"
                       class="back-button">

                        <i class="fa-solid fa-arrow-left"></i>

                        Back to Members

                    </a>

                    <a href="${pageContext.request.contextPath}/MemberController?action=editMember&id=<%= member.getMemberId() %>"
                       class="edit-button">

                        <i class="fa-solid fa-pen"></i>

                        Edit Member

                    </a>

                </div>

            </div>

        </main>

    </div>

</body>

</html>