<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Members | Library Management System</title>

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/Assets/CSS/members.css">
</head>

<body>

    <%-- HEADER --%>
    <jsp:include page="/jsp/includes/header.jsp" />

    <div class="dashboard-layout">

        <%-- SIDEBAR --%>
        <jsp:include page="/jsp/includes/sidebar.jsp" />

        <main class="members-content">

            <%-- SUCCESS AND ERROR MESSAGES --%>
            <c:if test="${param.message eq 'deleted'}">
                <div class="alert alert-success">
                    Member permanently deleted successfully.
                </div>
            </c:if>

            <c:if test="${param.message eq 'deactivated'}">
                <div class="alert alert-success">
                    Member deactivated successfully.
                </div>
            </c:if>

            <c:if test="${param.message eq 'deleteFailed'}">
                <div class="alert alert-error">
                    Member could not be deleted. Check member status and borrowing records.
                </div>
            </c:if>

            <c:if test="${param.message eq 'deactivateFailed'}">
                <div class="alert alert-error">
                    Member could not be deactivated.
                </div>
            </c:if>

            <c:if test="${param.message eq 'hasBorrowings'}">
                <div class="alert alert-error">
                    This member has issued or overdue books. Please settle the borrowing records first.
                </div>
            </c:if>

            <c:if test="${param.message eq 'memberNotFound'}">
                <div class="alert alert-error">
                    Member not found.
                </div>
            </c:if>

            <%-- PAGE HEADER --%>
            <div class="members-page-header">

                <div class="page-title">
                    <div class="page-title-icon">
                        <i class="fa-solid fa-users"></i>
                    </div>

                    <div>
                        <h1>Members</h1>
                        <p>Manage library members and their accounts</p>
                    </div>
                </div>

               <a href="${pageContext.request.contextPath}/MemberController?action=addMember"
				   class="add-member-btn">
				
				    <i class="fa-solid fa-user-plus"></i>
				    <span>Add Member</span>
				
				</a>

            </div>

            <%-- SUMMARY CARDS --%>
            <section class="member-summary">

                <div class="member-summary-card">
                    <div class="summary-icon members">
                        <i class="fa-solid fa-users"></i>
                    </div>

                    <div>
                        <span>Total Members</span>
                        <strong>
                            <c:out value="${totalMembers}" default="0" />
                        </strong>
                    </div>
                </div>

                <div class="member-summary-card">
                    <div class="summary-icon active">
                        <i class="fa-solid fa-user-check"></i>
                    </div>

                    <div>
                        <span>Active Members</span>
                        <strong>
                            <c:out value="${activeMembers}" default="0" />
                        </strong>
                    </div>
                </div>

                <div class="member-summary-card">
                    <div class="summary-icon borrowing">
                        <i class="fa-solid fa-book-open-reader"></i>
                    </div>

                    <div>
                        <span>Currently Borrowing</span>
                        <strong>
                            <c:out value="${borrowingMembers}" default="0" />
                        </strong>
                    </div>
                </div>

            </section>

            <%-- MEMBERS TABLE --%>
            <section class="members-card">

                <div class="members-card-header">
                    <div>
                        <h2>All Members</h2>
                        <p>View and manage registered library members</p>
                    </div>

                    <div class="member-search">
                        <i class="fa-solid fa-magnifying-glass"></i>

                        <input type="text"
                               id="memberSearch"
                               placeholder="Search members..."
                               autocomplete="off">
                    </div>
                </div>

                <div class="members-table-wrapper">

                    <table class="members-table" id="membersTable">

                        <thead>
                            <tr>
                                <th>#</th>
                                <th>MEMBER</th>
                                <th>EMAIL</th>
                                <th>PHONE</th>
                                <th>STATUS</th>
                                <th>BOOKS</th>
                                <th>ACTIONS</th>
                            </tr>
                        </thead>

                        <tbody>

                            <c:forEach var="member"
                                       items="${membersList}"
                                       varStatus="loop">

                                <tr>

                                    <%-- SERIAL NUMBER --%>
                                    <td>
                                        <span class="member-id">
                                            <c:out value="${loop.count}" />
                                        </span>
                                    </td>

                                    <%-- MEMBER NAME --%>
                                    <td>
                                        <div class="member-info">

                                            <div class="member-avatar">
                                                <c:choose>
                                                    <c:when test="${not empty member.firstName}">
                                                        <c:out value="${fn:toUpperCase(fn:substring(member.firstName, 0, 1))}" />
                                                    </c:when>
                                                    <c:otherwise>U</c:otherwise>
                                                </c:choose>
                                            </div>

                                            <div>
                                                <strong>
                                                    <c:out value="${member.firstName}" />
                                                    <c:out value="${member.lastName}" />
                                                </strong>

                                                <small>
                                                    Member #
                                                    <c:out value="${member.memberId}" />
                                                </small>
                                            </div>

                                        </div>
                                    </td>

                                    <%-- EMAIL --%>
                                    <td>
                                        <c:out value="${member.email}" />
                                    </td>

                                    <%-- PHONE --%>
                                    <td>
                                        <c:out value="${member.phoneNo}" />
                                    </td>

                                    <%-- STATUS --%>
                                    <td>
                                        <c:choose>

                                            <c:when test="${member.status eq 'Active'}">
                                                <span class="status active-status">
                                                    <i class="fa-solid fa-circle"></i>
                                                    Active
                                                </span>
                                            </c:when>

                                            <c:otherwise>
                                                <span class="status inactive-status">
                                                    <i class="fa-solid fa-circle"></i>
                                                    Inactive
                                                </span>
                                            </c:otherwise>

                                        </c:choose>
                                    </td>

                                    <%-- BORROWED BOOKS --%>
                                    <td>
                                        <c:set var="borrowedCount"
                                               value="${requestScope['borrowedBooks_'.concat(member.memberId)]}" />

                                        <span class="books-count">
                                            <c:choose>
                                                <c:when test="${borrowedCount ne null}">
                                                    <c:out value="${borrowedCount}" />
                                                </c:when>
                                                <c:otherwise>0</c:otherwise>
                                            </c:choose>

                                            <c:choose>
                                                <c:when test="${borrowedCount eq 1}">
                                                    Book
                                                </c:when>
                                                <c:otherwise>
                                                    Books
                                                </c:otherwise>
                                            </c:choose>
                                        </span>
                                    </td>

                                    <%-- ACTIONS --%>
                                    <td>
                                        <div class="action-buttons">

                                            <%-- VIEW --%>
                                            <a href="${pageContext.request.contextPath}/MemberController?action=viewMember&amp;id=${member.memberId}"
                                               class="view-btn"
                                               title="View Member">
                                                <i class="fa-solid fa-eye"></i>
                                            </a>

                                            <%-- EDIT --%>
                                            <a href="${pageContext.request.contextPath}/MemberController?action=editMember&amp;id=${member.memberId}"
                                               class="edit-btn"
                                               title="Edit Member">
                                                <i class="fa-solid fa-pen"></i>
                                            </a>

                                            <%-- ACTIVE MEMBER: DEACTIVATE --%>
                                            <c:choose>

                                                <c:when test="${member.status eq 'Active'}">

                                                    <a href="${pageContext.request.contextPath}/MemberController?action=deactivateMember&amp;id=${member.memberId}"
                                                       class="delete-btn"
                                                       title="Deactivate Member"
                                                       onclick="return confirm('Are you sure you want to deactivate this member?');">

                                                        <i class="fa-solid fa-user-slash"></i>
                                                    </a>

                                                </c:when>

                                                <%-- INACTIVE MEMBER: PERMANENT DELETE --%>
                                                <c:otherwise>

                                                    <a href="${pageContext.request.contextPath}/MemberController?action=deleteMember&amp;id=${member.memberId}"
                                                       class="delete-btn"
                                                       title="Permanently Delete Member"
                                                       onclick="return confirm('Permanently delete this inactive member? This action cannot be undone.');">

                                                        <i class="fa-solid fa-trash"></i>
                                                    </a>

                                                </c:otherwise>

                                            </c:choose>

                                        </div>
                                    </td>

                                </tr>

                            </c:forEach>

                            <%-- EMPTY LIST --%>
                            <c:if test="${empty membersList}">
                                <tr>
                                    <td colspan="7"
                                        style="text-align: center; padding: 25px;">
                                        No members found.
                                    </td>
                                </tr>
                            </c:if>

                        </tbody>

                    </table>

                </div>

            </section>

        </main>

    </div>

    <%-- MEMBER SEARCH --%>
    <script>
        document.addEventListener("DOMContentLoaded", function () {

            const searchInput = document.getElementById("memberSearch");
            const table = document.getElementById("membersTable");

            if (!searchInput || !table) {
                return;
            }

            searchInput.addEventListener("input", function () {

                const searchValue = this.value.toLowerCase().trim();
                const rows = table.querySelectorAll("tbody tr");

                rows.forEach(function (row) {

                    if (row.querySelector("td[colspan]")) {
                        return;
                    }

                    const rowText = row.innerText.toLowerCase();

                    row.style.display =
                        rowText.includes(searchValue) ? "" : "none";
                });

            });

        });
    </script>

</body>
</html>