<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Add Member | Library Management System</title>


    <!-- Font Awesome -->

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">


    <!-- Add Member CSS -->

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/Assets/CSS/addMember.css">

</head>


<body>


    <!-- =========================================
         HEADER
    ========================================== -->

    <jsp:include page="/jsp/includes/header.jsp" />


    <!-- =========================================
         MAIN LAYOUT
    ========================================== -->

    <div class="dashboard-layout">


        <!-- SIDEBAR -->

        <jsp:include page="/jsp/includes/sidebar.jsp" />


        <!-- =====================================
             MAIN CONTENT
        ====================================== -->

        <main class="add-member-content">


            <!-- =================================
                 PAGE HEADER
            ================================== -->

            <div class="add-member-header">


                <div class="page-title">

                    <div class="page-title-icon">

                        <i class="fa-solid fa-user-plus"></i>

                    </div>


                    <div>

                        <h1>
                            Add New Member
                        </h1>

                        <p>
                            Add a new member to your library
                        </p>

                    </div>

                </div>


                <!-- BACK BUTTON -->

                <a href="${pageContext.request.contextPath}/jsp/members.jsp"
                   class="back-btn">

                    <i class="fa-solid fa-arrow-left"></i>

                    <span>
                        Back to Members
                    </span>

                </a>


            </div>



            <!-- =================================
                 FORM CARD
            ================================== -->

            <section class="add-member-card">


                <!-- FORM HEADER -->

                <div class="form-card-header">


                    <div class="form-header-icon">

                        <i class="fa-solid fa-user"></i>

                    </div>


                    <div>

                        <h2>
                            Member Information
                        </h2>

                        <p>
                            Enter the details of the new member
                        </p>

                    </div>


                </div>



                <!-- =================================
                     MEMBER FORM
                ================================== -->

                <form
                    action="${pageContext.request.contextPath}/MemberController"
                    method="post"
                    class="member-form">


                    <!-- ACTION -->

                    <input
                        type="hidden"
                        name="action"
                        value="addMember">



                    <!-- =================================
                         PERSONAL INFORMATION
                    ================================== -->

                    <div class="form-section-title">

                        <i class="fa-solid fa-user"></i>

                        <span>
                            Personal Information
                        </span>

                    </div>



                    <div class="form-grid">


                        <!-- FIRST NAME -->

                        <div class="form-group">

                            <label for="firstName">

                                First Name

                                <span>*</span>

                            </label>


                            <div class="input-wrapper">

                                <i class="fa-solid fa-user input-icon"></i>

                                <input
                                    type="text"
                                    id="firstName"
                                    name="firstName"
                                    placeholder="Enter first name"
                                    required>

                            </div>

                        </div>



                        <!-- LAST NAME -->

                        <div class="form-group">

                            <label for="lastName">

                                Last Name

                            </label>


                            <div class="input-wrapper">

                                <i class="fa-solid fa-user input-icon"></i>

                                <input
                                    type="text"
                                    id="lastName"
                                    name="lastName"
                                    placeholder="Enter last name">

                            </div>

                        </div>



                        <!-- EMAIL -->

                        <div class="form-group">

                            <label for="email">

                                Email Address

                                <span>*</span>

                            </label>


                            <div class="input-wrapper">

                                <i class="fa-solid fa-envelope input-icon"></i>

                                <input
                                    type="email"
                                    id="email"
                                    name="email"
                                    placeholder="Enter email address"
                                    autocomplete="email"
                                    required>

                            </div>

                        </div>



                        <!-- PHONE -->

                        <div class="form-group">

                            <label for="phoneNo">

                                Phone Number

                                <span>*</span>

                            </label>


                            <div class="input-wrapper">

                                <i class="fa-solid fa-phone input-icon"></i>

                                <input
                                    type="tel"
                                    id="phoneNo"
                                    name="phoneNo"
                                    placeholder="Enter phone number"
                                    maxlength="10"
                                    required>

                            </div>

                        </div>


                    </div>



                    <!-- =================================
                         ACCOUNT INFORMATION
                    ================================== -->

                    <div class="form-section-title account-section">

                        <i class="fa-solid fa-lock"></i>

                        <span>
                            Account Information
                        </span>

                    </div>



                    <div class="form-grid">


                        <!-- PASSWORD -->

                        <div class="form-group">

                            <label for="password">

                                Password

                                <span>*</span>

                            </label>


                            <div class="input-wrapper">

                                <i class="fa-solid fa-lock input-icon"></i>


                                <input
                                    type="password"
                                    id="password"
                                    name="password"
                                    placeholder="Enter password"
                                    autocomplete="new-password"
                                    required>


                                <button
                                    type="button"
                                    class="password-toggle"
                                    id="togglePassword"
                                    aria-label="Show password">

                                    <i
                                        class="fa-regular fa-eye"
                                        id="eyeIcon">
                                    </i>

                                </button>

                            </div>

                        </div>



                        <!-- CONFIRM PASSWORD -->

                        <div class="form-group">

                            <label for="confirmPassword">

                                Confirm Password

                                <span>*</span>

                            </label>


                            <div class="input-wrapper">

                                <i class="fa-solid fa-lock input-icon"></i>


                                <input
                                    type="password"
                                    id="confirmPassword"
                                    name="confirmPassword"
                                    placeholder="Confirm password"
                                    autocomplete="new-password"
                                    required>


                                <button
                                    type="button"
                                    class="password-toggle"
                                    id="toggleConfirmPassword"
                                    aria-label="Show password">

                                    <i
                                        class="fa-regular fa-eye"
                                        id="confirmEyeIcon">
                                    </i>

                                </button>

                            </div>

                        </div>


                    </div>



                    <!-- =================================
                         FORM ACTIONS
                    ================================== -->

                    <div class="form-actions">


                        <!-- CANCEL -->

                        <a
                            href="${pageContext.request.contextPath}/jsp/members.jsp"
                            class="cancel-btn">

                            <i class="fa-solid fa-xmark"></i>

                            Cancel

                        </a>



                        <!-- RESET -->

                        <button
                            type="reset"
                            class="reset-btn">

                            <i class="fa-solid fa-rotate-left"></i>

                            Reset

                        </button>



                        <!-- ADD MEMBER -->

                        <button
                            type="submit"
                            class="save-btn">

                            <i class="fa-solid fa-user-plus"></i>

                            Add Member

                        </button>


                    </div>


                </form>


            </section>


        </main>


    </div>



    <!-- =========================================
         PASSWORD TOGGLE SCRIPT
    ========================================== -->

    <script>


        /* PASSWORD */

        const password =
            document.getElementById("password");


        const togglePassword =
            document.getElementById("togglePassword");


        const eyeIcon =
            document.getElementById("eyeIcon");


        togglePassword.addEventListener(
            "click",
            function () {

                if (password.type === "password") {

                    password.type = "text";

                    eyeIcon.classList.remove(
                        "fa-eye"
                    );

                    eyeIcon.classList.add(
                        "fa-eye-slash"
                    );

                    togglePassword.setAttribute(
                        "aria-label",
                        "Hide password"
                    );

                } else {

                    password.type = "password";

                    eyeIcon.classList.remove(
                        "fa-eye-slash"
                    );

                    eyeIcon.classList.add(
                        "fa-eye"
                    );

                    togglePassword.setAttribute(
                        "aria-label",
                        "Show password"
                    );

                }

            }
        );



        /* CONFIRM PASSWORD */

        const confirmPassword =
            document.getElementById("confirmPassword");


        const toggleConfirmPassword =
            document.getElementById(
                "toggleConfirmPassword"
            );


        const confirmEyeIcon =
            document.getElementById(
                "confirmEyeIcon"
            );


        toggleConfirmPassword.addEventListener(
            "click",
            function () {

                if (
                    confirmPassword.type ===
                    "password"
                ) {

                    confirmPassword.type =
                        "text";

                    confirmEyeIcon.classList.remove(
                        "fa-eye"
                    );

                    confirmEyeIcon.classList.add(
                        "fa-eye-slash"
                    );

                    toggleConfirmPassword.setAttribute(
                        "aria-label",
                        "Hide password"
                    );

                } else {

                    confirmPassword.type =
                        "password";

                    confirmEyeIcon.classList.remove(
                        "fa-eye-slash"
                    );

                    confirmEyeIcon.classList.add(
                        "fa-eye"
                    );

                    toggleConfirmPassword.setAttribute(
                        "aria-label",
                        "Show password"
                    );

                }

            }
        );


    </script>


</body>

</html>