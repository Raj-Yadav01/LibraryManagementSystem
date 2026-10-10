<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<link rel="stylesheet"
      href="${pageContext.request.contextPath}/Assets/CSS/sidebar.css">

<%
    String currentPage = request.getRequestURI();
%>

<aside class="sidebar">

    <!-- Logo -->
    <div class="sidebar-logo">

        <div class="sidebar-logo-icon">
            <i class="fa-solid fa-book-open"></i>
        </div>

    </div>


    <!-- Navigation -->
    <nav class="sidebar-nav">

        <!-- Dashboard -->
        <a href="${pageContext.request.contextPath}/DashboardController"
		   class="sidebar-link <%= request.getRequestURI().endsWith("dashboard.jsp") 
		       || request.getRequestURI().endsWith("DashboardController") 
		       ? "active" : "" %>">
		
		    <i class="fa-solid fa-chart-pie"></i>
		    <span>Dashboard</span>
		
		</a>


        <!-- Books -->
        <a href="${pageContext.request.contextPath}/BookController"
		   class="sidebar-link <%= request.getRequestURI().endsWith("books.jsp")
		       || request.getRequestURI().endsWith("BookController")
		       ? "active" : "" %>">
		
		    <i class="fa-solid fa-book"></i>
		    <span>Books</span>
		
		</a>

        <!-- Add Book -->
        

		<a href="${pageContext.request.contextPath}/BookController?action=addBook"
		   class="sidebar-link <%= currentPage.endsWith("addBook.jsp") ? "active" : "" %>">
		
		    <i class="fa-solid fa-book-medical"></i>
		
		    <span>Add Book</span>
		
		</a>


        <!-- Members -->

	    <a href="${pageContext.request.contextPath}/MemberController"
		   class="sidebar-link <%= request.getRequestURI().endsWith("members.jsp")
		       || request.getRequestURI().endsWith("MemberController")
		       ? "active" : "" %>">
		
		    <i class="fa-solid fa-users"></i>
		    <span>Members</span>
		
		</a>



		<!-- Add Member -->

		<!-- Add Member -->

		<a href="${pageContext.request.contextPath}/MemberController?action=addMember"
		   class="sidebar-link">
		
		    <i class="fa-solid fa-user-plus"></i>
		
		    <span>Add Member</span>
		
		</a>


        <!-- Issue Book -->
        <a href="${pageContext.request.contextPath}/IssueBookController"
           class="sidebar-link <%= currentPage.endsWith("issueBook.jsp") ? "active" : "" %>">

            <i class="fa-solid fa-arrow-right-from-bracket"></i>

            <span>Issue Book</span>

        </a>


        <!-- Return Book -->

		<a href="${pageContext.request.contextPath}/ReturnBookController"
		   class="sidebar-link <%= currentPage.endsWith("returnBook.jsp") ? "active" : "" %>">
		
		    <i class="fa-solid fa-arrow-left"></i>
		
		    <span>Return Book</span>
		
		</a>


        <!-- Borrowing History -->

		<a href="${pageContext.request.contextPath}/BorrowingController"
		   class="sidebar-link <%= currentPage.endsWith("borrowingHistory.jsp") ? "active" : "" %>">
		
		    <i class="fa-solid fa-clock-rotate-left"></i>
		
		    <span>Borrowing History</span>
		
		</a>


        <!-- Profile -->
        <a href="${pageContext.request.contextPath}/jsp/profile.jsp"
           class="sidebar-link <%= currentPage.endsWith("profile.jsp") ? "active" : "" %>">

            <i class="fa-solid fa-user"></i>

            <span>Profile</span>

        </a>

    </nav>


    <!-- Sidebar Bottom -->
    <div class="sidebar-bottom">

        <div class="sidebar-divider"></div>

        <div class="sidebar-user">

            <div class="sidebar-user-avatar">
                A
            </div>

            <div class="sidebar-user-info">

                <strong>Admin</strong>

                <span>Administrator</span>

            </div>

        </div>

    </div>

</aside>