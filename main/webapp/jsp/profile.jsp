<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Profile - Library Management System</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/Assets/CSS/profile.css">

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

</head>

<body>

    <!-- Header -->
    <jsp:include page="/jsp/includes/header.jsp" />


    <div class="dashboard-layout">

        <!-- Sidebar -->
        <jsp:include page="/jsp/includes/sidebar.jsp" />


        <!-- Main Content -->
        <main class="profile-content">


            <!-- Page Header -->
            <div class="profile-page-header">

                <div class="page-title-area">

                    <div class="page-title-icon">
                        <i class="fa-solid fa-user"></i>
                    </div>

                    <div>
                        <h1>Profile</h1>
                        <p>Manage your account information</p>
                    </div>

                </div>


                <a href="${pageContext.request.contextPath}/jsp/dashboard.jsp"
                   class="back-btn">

                    <i class="fa-solid fa-arrow-left"></i>

                    Back to Dashboard

                </a>

            </div>


            <!-- Profile Layout -->
            <div class="profile-layout">


                <!-- Profile Card -->
                <section class="profile-card">


                    <div class="profile-cover">

                        <div class="profile-avatar">
                            A
                        </div>

                    </div>


                    <div class="profile-details">

                        <h2>Admin</h2>

                        <p class="profile-role">
                            <i class="fa-solid fa-shield-halved"></i>
                            Administrator
                        </p>


                        <div class="profile-info">

                            <div class="info-item">

                                <i class="fa-solid fa-envelope"></i>

                                <div>
                                    <span>Email</span>
                                    <strong>admin@gmail.com</strong>
                                </div>

                            </div>


                            <div class="info-item">

                                <i class="fa-solid fa-phone"></i>

                                <div>
                                    <span>Phone</span>
                                    <strong>9876543210</strong>
                                </div>

                            </div>


                            <div class="info-item">

                                <i class="fa-solid fa-calendar"></i>

                                <div>
                                    <span>Member Since</span>
                                    <strong>September 2026</strong>
                                </div>

                            </div>

                        </div>

                    </div>

                </section>



                <!-- Edit Profile -->
                <section class="edit-profile-card">


                    <div class="card-header">

                        <div class="header-icon">
                            <i class="fa-solid fa-user-pen"></i>
                        </div>

                        <div>
                            <h2>Personal Information</h2>
                            <p>Update your profile details</p>
                        </div>

                    </div>


                    <form class="profile-form">


                        <div class="form-section-title">

                            <i class="fa-solid fa-user"></i>

                            Basic Information

                        </div>


                        <div class="form-grid">


                            <!-- First Name -->
                            <div class="form-group">

                                <label for="firstName">
                                    First Name
                                </label>

                                <div class="input-wrapper">

                                    <i class="fa-solid fa-user input-icon"></i>

                                    <input type="text"
                                           id="firstName"
                                           name="firstName"
                                           value="Admin"
                                           placeholder="Enter first name">

                                </div>

                            </div>


                            <!-- Last Name -->
                            <div class="form-group">

                                <label for="lastName">
                                    Last Name
                                </label>

                                <div class="input-wrapper">

                                    <i class="fa-solid fa-user input-icon"></i>

                                    <input type="text"
                                           id="lastName"
                                           name="lastName"
                                           value=""
                                           placeholder="Enter last name">

                                </div>

                            </div>


                            <!-- Email -->
                            <div class="form-group">

                                <label for="email">
                                    Email Address
                                </label>

                                <div class="input-wrapper">

                                    <i class="fa-solid fa-envelope input-icon"></i>

                                    <input type="email"
                                           id="email"
                                           name="email"
                                           value="admin@gmail.com"
                                           placeholder="Enter email">

                                </div>

                            </div>


                            <!-- Phone -->
                            <div class="form-group">

                                <label for="phone">
                                    Phone Number
                                </label>

                                <div class="input-wrapper">

                                    <i class="fa-solid fa-phone input-icon"></i>

                                    <input type="tel"
                                           id="phone"
                                           name="phone"
                                           value="9876543210"
                                           placeholder="Enter phone number">

                                </div>

                            </div>

                        </div>



                        <!-- Security Section -->
                        <div class="form-section-title security-title">

                            <i class="fa-solid fa-lock"></i>

                            Change Password

                        </div>


                        <div class="form-grid">


                            <!-- Current Password -->
                            <div class="form-group">

                                <label for="currentPassword">
                                    Current Password
                                </label>

                                <div class="input-wrapper">

                                    <i class="fa-solid fa-lock input-icon"></i>

                                    <input type="password"
                                           id="currentPassword"
                                           name="currentPassword"
                                           placeholder="Enter current password">

                                    <button type="button"
                                            class="password-toggle"
                                            onclick="togglePassword('currentPassword', this)">

                                        <i class="fa-solid fa-eye"></i>

                                    </button>

                                </div>

                            </div>


                            <!-- New Password -->
                            <div class="form-group">

                                <label for="newPassword">
                                    New Password
                                </label>

                                <div class="input-wrapper">

                                    <i class="fa-solid fa-lock input-icon"></i>

                                    <input type="password"
                                           id="newPassword"
                                           name="newPassword"
                                           placeholder="Enter new password">

                                    <button type="button"
                                            class="password-toggle"
                                            onclick="togglePassword('newPassword', this)">

                                        <i class="fa-solid fa-eye"></i>

                                    </button>

                                </div>

                            </div>


                            <!-- Confirm Password -->
                            <div class="form-group">

                                <label for="confirmPassword">
                                    Confirm Password
                                </label>

                                <div class="input-wrapper">

                                    <i class="fa-solid fa-lock input-icon"></i>

                                    <input type="password"
                                           id="confirmPassword"
                                           name="confirmPassword"
                                           placeholder="Confirm new password">

                                    <button type="button"
                                            class="password-toggle"
                                            onclick="togglePassword('confirmPassword', this)">

                                        <i class="fa-solid fa-eye"></i>

                                    </button>

                                </div>

                            </div>

                        </div>



                        <!-- Actions -->
                        <div class="form-actions">

                            <button type="reset"
                                    class="reset-btn">

                                <i class="fa-solid fa-rotate-left"></i>

                                Reset

                            </button>


                            <button type="submit"
                                    class="save-btn">

                                <i class="fa-solid fa-check"></i>

                                Save Changes

                            </button>

                        </div>


                    </form>

                </section>

            </div>

        </main>

    </div>



    <!-- Password Toggle -->
    <script>

        function togglePassword(inputId, button) {

            const input =
                document.getElementById(inputId);

            const icon =
                button.querySelector("i");


            if (input.type === "password") {

                input.type = "text";

                icon.classList.remove("fa-eye");

                icon.classList.add("fa-eye-slash");

            } else {

                input.type = "password";

                icon.classList.remove("fa-eye-slash");

                icon.classList.add("fa-eye");

            }

        }

    </script>


</body>

</html>