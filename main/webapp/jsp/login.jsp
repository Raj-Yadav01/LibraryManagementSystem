<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Login | Library Management System</title>

    <!-- Login CSS -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/Assets/CSS/login.css">

    <!-- Font Awesome Icons -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
</head>

<body>

    <div class="login-container">

        <!-- Login Card -->
        <div class="login-card">

            <!-- Logo / Icon -->
            <div class="login-icon">
                <i class="fa-solid fa-book-open"></i>
            </div>

            <!-- Heading -->
            <h1>Welcome Back!</h1>

            <p class="login-subtitle">
                Login to your Library Management System
            </p>

            <!-- Error Message -->
            <c:if test="${not empty errorMessage}">
                <div class="error-message" role="alert">
                    <i class="fa-solid fa-circle-exclamation"></i>
                    <span><c:out value="${errorMessage}" /></span>
                </div>
            </c:if>

            <!-- Login Form -->
            <form action="${pageContext.request.contextPath}/AuthenticationController"
                  method="post"
                  id="loginForm">

                <!-- Action -->
                <input type="hidden" name="action" value="checklogin">

                <!-- Username / Email -->
                <div class="form-group">

                    <label for="username">
                        Username or Email
                    </label>

                    <div class="input-wrapper">
                        <i class="fa-solid fa-user input-icon"></i>

                        <input
                            type="text"
                            id="username"
                            name="username"
                            placeholder="Enter username or email"
                            value="<c:out value='${param.username}'/>"
                            autocomplete="username"
                            required>
                    </div>

                </div>

                <!-- Password -->
                <div class="form-group">

                    <label for="password">
                        Password
                    </label>

                    <div class="input-wrapper">
                        <i class="fa-solid fa-lock input-icon"></i>

                        <input
                            type="password"
                            id="password"
                            name="password"
                            placeholder="Enter your password"
                            autocomplete="current-password"
                            required>

                        <button
                            type="button"
                            class="toggle-password"
                            id="togglePassword"
                            aria-label="Show password">

                            <i class="fa-solid fa-eye" id="eyeIcon"></i>

                        </button>
                    </div>

                </div>

                <!-- Remember / Forgot Password -->
                <div class="form-options">
                    <label class="remember-me">
                        <input type="checkbox" name="rememberMe">
                        <span>Remember me</span>
                    </label>

                    <a href="${pageContext.request.contextPath}/jsp/forgotPassword.jsp"
                       class="forgot-password">
                        Forgot Password?
                    </a>
                </div>

                <!-- Login Button -->
                <button type="submit" class="login-button">
                    <span>Login</span>
                    <i class="fa-solid fa-arrow-right"></i>
                </button>

            </form>

            <!-- Footer -->
            <div class="login-footer">
                <p>
                    <i class="fa-solid fa-book"></i>
                    Online Library Management System
                </p>
            </div>

        </div>

    </div>

    <!-- Password Show / Hide -->
    <script>
        const togglePassword = document.getElementById("togglePassword");
        const passwordInput = document.getElementById("password");
        const eyeIcon = document.getElementById("eyeIcon");

        togglePassword.addEventListener("click", function () {

            if (passwordInput.type === "password") {
                passwordInput.type = "text";
                eyeIcon.classList.remove("fa-eye");
                eyeIcon.classList.add("fa-eye-slash");
                togglePassword.setAttribute("aria-label", "Hide password");
            } else {
                passwordInput.type = "password";
                eyeIcon.classList.remove("fa-eye-slash");
                eyeIcon.classList.add("fa-eye");
                togglePassword.setAttribute("aria-label", "Show password");
            }

        });
    </script>

</body>
</html>