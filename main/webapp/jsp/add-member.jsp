<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Add Member - Library Management System</title>

    <!-- Dashboard CSS -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/Assets/CSS/dashboard.css">

    <!-- Add Member CSS -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/Assets/CSS/add-member.css">

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
                    <h1>Add Member</h1>
                    <p>Add a new member to the library</p>
                </div>

            </div>


            <!-- Add Member Card -->
            <div class="add-member-card">

                <div class="form-header">

                    <div class="form-icon">
                        <i class="fa-solid fa-user-plus"></i>
                    </div>

                    <div>
                        <h2>Member Information</h2>
                        <p>Enter the details of the new library member.</p>
                    </div>

                </div>
				
				
				<%
				    String message = request.getParameter("message");
				%>
				
				<% if ("emptyFields".equals(message)) { %>
				
				    <div class="form-message error-message">
				        <i class="fa-solid fa-circle-exclamation"></i>
				        Please fill all fields.
				    </div>
				
				<% } else if ("passwordMismatch".equals(message)) { %>
				
				    <div class="form-message error-message">
				        <i class="fa-solid fa-circle-exclamation"></i>
				        Password and Confirm Password do not match.
				    </div>
				
				<% } else if ("addFailed".equals(message)) { %>
				
				    <div class="form-message error-message">
				        <i class="fa-solid fa-circle-exclamation"></i>
				        Failed to add member. Email may already exist.
				    </div>
				
				<% } %>
								
				

                <!-- Add Member Form -->
                <form action="${pageContext.request.contextPath}/MemberController"
                      method="post">

                    <input type="hidden"
                           name="action"
                           value="saveMember">


                    <div class="form-grid">

                        <!-- First Name -->
                        <div class="form-group">

                            <label for="firstName">
                                First Name
                            </label>

                            <input type="text"
                                   id="firstName"
                                   name="firstName"
                                   placeholder="Enter first name"
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
                                   placeholder="Enter last name"
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
                                   placeholder="Enter email address"
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
                                   placeholder="Enter phone number"
                                   required>

                        </div>


                        <!-- Password -->
                        <div class="form-group">

                            <label for="password">
                                Password
                            </label>

                            <input type="password"
                                   id="password"
                                   name="password"
                                   placeholder="Enter password"
                                   required>

                        </div>


                        <!-- Confirm Password -->
                        <div class="form-group">

                            <label for="confirmPassword">
                                Confirm Password
                            </label>

                            <input type="password"
                                   id="confirmPassword"
                                   name="confirmPassword"
                                   placeholder="Confirm password"
                                   required>

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
                                class="save-button">

                            <i class="fa-solid fa-user-plus"></i>

                            Add Member

                        </button>

                    </div>

                </form>

            </div>

        </main>

    </div>

</body>

</html>