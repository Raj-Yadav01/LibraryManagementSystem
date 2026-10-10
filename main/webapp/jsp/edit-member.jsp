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

    <title>Edit Member - Library Management System</title>

    <!-- Dashboard CSS -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/Assets/CSS/dashboard.css">

    <!-- Edit Member CSS -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/Assets/CSS/edit-member.css">

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
                    <h1>Edit Member</h1>
                    <p>Update member information</p>
                </div>

            </div>


            <!-- Edit Member Card -->
            <div class="edit-member-card">

                <div class="form-header">

                    <div class="form-icon">
                        <i class="fa-solid fa-user-pen"></i>
                    </div>

                    <div>
                        <h2>Edit Member</h2>
                        <p>Update the details of this library member.</p>
                    </div>

                </div>


                <!-- Edit Form -->
                <form action="${pageContext.request.contextPath}/MemberController"
                      method="post">

                    <input type="hidden"
                           name="action"
                           value="updateMember">

                    <input type="hidden"
                           name="memberId"
                           value="<%= member.getMemberId() %>">


                    <div class="form-grid">

                        <!-- First Name -->
                        <div class="form-group">

                            <label for="firstName">
                                First Name
                            </label>

                            <input type="text"
                                   id="firstName"
                                   name="firstName"
                                   value="<%= member.getFirstName() != null
                                           ? member.getFirstName() : "" %>"
                                   required>

                        </div>


                        <!-- Last Name -->
                        <div class="form-group">

                            <label for="lastName">
                                Last Name
                            </label>

                            <input type="text"
                                   id="lastName"
                                   name="lastName"
                                   value="<%= member.getLastName() != null
                                           ? member.getLastName() : "" %>"
                                   required>

                        </div>


                        <!-- Email -->
                        <div class="form-group">

                            <label for="email">
                                Email
                            </label>

                            <input type="email"
                                   id="email"
                                   name="email"
                                   value="<%= member.getEmail() != null
                                           ? member.getEmail() : "" %>"
                                   required>

                        </div>


                        <!-- Phone -->
                        <div class="form-group">

                            <label for="phoneNo">
                                Phone Number
                            </label>

                            <input type="tel"
                                   id="phoneNo"
                                   name="phoneNo"
                                   value="<%= member.getPhoneNo() != null
                                           ? member.getPhoneNo() : "" %>"
                                   required>

                        </div>


                        <!-- Status -->
                        <div class="form-group">

                            <label for="status">
                                Status
                            </label>

                            <select id="status"
                                    name="status"
                                    required>

                                <option value="Active"
                                    <%= "Active".equalsIgnoreCase(member.getStatus())
                                        ? "selected" : "" %>>
                                    Active
                                </option>

                                <option value="Inactive"
                                    <%= "Inactive".equalsIgnoreCase(member.getStatus())
                                        ? "selected" : "" %>>
                                    Inactive
                                </option>

                            </select>

                        </div>


                        <!-- Member ID -->
                        <div class="form-group">

                            <label>
                                Member ID
                            </label>

                            <input type="text"
                                   value="<%= member.getMemberId() %>"
                                   readonly>

                        </div>

                    </div>


                    <!-- Buttons -->
                    <div class="form-actions">

                        <a href="${pageContext.request.contextPath}/MemberController"
                           class="cancel-button">

                            <i class="fa-solid fa-arrow-left"></i>

                            Cancel

                        </a>


                        <button type="submit"
                                class="update-button">

                            <i class="fa-solid fa-check"></i>

                            Update Member

                        </button>

                    </div>

                </form>

            </div>

        </main>

    </div>

</body>

</html>