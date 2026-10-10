<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!-- Header CSS -->
<link rel="stylesheet"
      href="${pageContext.request.contextPath}/Assets/CSS/header.css">


<header class="main-header">


    <!-- LEFT SIDE -->

    <div class="header-left">


        <!-- Logo -->

        <div class="header-logo">

            <i class="fa-solid fa-book-open"></i>

        </div>


        <!-- Title -->

        <div class="header-title">

            Library Management System

        </div>


    </div>


    <!-- RIGHT SIDE -->

    <div class="header-right">


        <!-- Welcome -->

        <div class="welcome-text">

            Welcome,

            <strong>Admin</strong>

        </div>


        <!-- Sign Out -->

        <a
            href="${pageContext.request.contextPath}/AuthenticationController?action=logout"
            class="signout-btn"
        >

            <i class="fa-solid fa-right-from-bracket"></i>

            <span>
                Sign Out
            </span>

        </a>


    </div>


</header>