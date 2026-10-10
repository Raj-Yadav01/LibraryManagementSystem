<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
        content="width=device-width, initial-scale=1.0">

    <title>Return Book | Library Management System</title>


    <!-- Font Awesome -->

    <link rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">


    <!-- Return Book CSS -->

    <link rel="stylesheet"
        href="${pageContext.request.contextPath}/Assets/CSS/returnBook.css">

</head>


<body>


    <!-- =========================
         HEADER
    ========================== -->

    <jsp:include page="/jsp/includes/header.jsp" />


    <!-- =========================
         MAIN LAYOUT
    ========================== -->

    <div class="dashboard-layout">


        <!-- SIDEBAR -->

        <jsp:include page="/jsp/includes/sidebar.jsp" />


        <!-- =========================
             MAIN CONTENT
        ========================== -->

        <main class="return-book-content">


            <!-- =========================
                 PAGE HEADER
            ========================== -->

            <div class="return-book-header">


                <div class="page-title">

                    <div class="page-title-icon">

                        <i class="fa-solid fa-rotate-left"></i>

                    </div>


                    <div>

                        <h1>
                            Return Book
                        </h1>

                        <p>
                            Process a book returned by a library member
                        </p>

                    </div>

                </div>


                <!-- BACK BUTTON -->

                <a
                    href="${pageContext.request.contextPath}/DashboardController"
                    class="back-btn">

                    <i class="fa-solid fa-arrow-left"></i>

                    <span>
                        Back to Dashboard
                    </span>

                </a>

            </div>


            <!-- =========================
                 SUCCESS / ERROR MESSAGES
            ========================== -->


            <c:if test="${param.message == 'bookReturned'}">

                <div class="alert alert-success">

                    <i class="fa-solid fa-circle-check"></i>

                    Book returned successfully.

                </div>

            </c:if>


            <c:if test="${param.message == 'emptyFields'}">

                <div class="alert alert-error">

                    <i class="fa-solid fa-circle-exclamation"></i>

                    Please fill all required fields.

                </div>

            </c:if>


            <c:if test="${param.message == 'returnFailed'}">

                <div class="alert alert-error">

                    <i class="fa-solid fa-circle-exclamation"></i>

                    Book return failed. Please try again.

                </div>

            </c:if>


            <!-- =========================
                 RETURN BOOK CARD
            ========================== -->

            <section class="return-book-card">


                <!-- CARD HEADER -->

                <div class="form-card-header">


                    <div class="form-header-icon">

                        <i class="fa-solid fa-book-open"></i>

                    </div>


                    <div>

                        <h2>
                            Return Book Information
                        </h2>

                        <p>
                            Select the issued book that you want to return
                        </p>

                    </div>

                </div>


                <!-- =========================
                     FORM
                ========================== -->

                <form
                    class="return-book-form"
                    action="${pageContext.request.contextPath}/ReturnBookController"
                    method="post">


                    <!-- ACTION -->

                    <input
                        type="hidden"
                        name="action"
                        value="returnBook">


                    <!-- BORROWING ID -->

                    <input
                        type="hidden"
                        id="borrowingId"
                        name="borrowingId"
                        value="">


                    <!-- =========================
                         SECTION TITLE
                    ========================== -->

                    <div class="form-section-title">

                        <i class="fa-solid fa-circle-info"></i>

                        <span>
                            Return Information
                        </span>

                    </div>


                    <!-- =========================
                         FORM GRID
                    ========================== -->

                    <div class="form-grid">


                        <!-- =========================
                             MEMBER SEARCH
                        ========================== -->

                        <div class="form-group">


                            <label for="memberSearch">

                                Select Member

                                <span>*</span>

                            </label>


                            <div class="input-wrapper">


                                <i class="fa-solid fa-user input-icon"></i>


                                <input
                                    type="text"
                                    id="memberSearch"
                                    list="memberList"
                                    placeholder="Type username or email..."
                                    autocomplete="off"
                                    required>


                                <!-- SEARCHABLE MEMBER LIST -->

                                <datalist id="memberList">


                                    <c:forEach
                                        var="member"
                                        items="${membersList}">


                                        <option
                                            value="${member.email}"
                                            data-member-id="${member.memberId}">

                                            ${member.firstName}
                                            ${member.lastName}
                                            -
                                            ${member.email}

                                        </option>


                                    </c:forEach>


                                </datalist>


                            </div>


                            <!-- ACTUAL MEMBER ID -->

                            <input
                                type="hidden"
                                id="member"
                                name="memberId"
                                value="">


                        </div>


                        <!-- =========================
                             ISSUED BOOK
                        ========================== -->

                        <div class="form-group">


                            <label for="book">

                                Select Issued Book

                                <span>*</span>

                            </label>


                            <div class="input-wrapper">


                                <i class="fa-solid fa-book input-icon"></i>


                                <select
                                    id="book"
                                    name="bookId"
                                    required
                                    disabled>


                                    <option value="">

                                        Select member first

                                    </option>


                                </select>


                            </div>


                        </div>


                        <!-- =========================
                             ISSUE DATE
                        ========================== -->

                        <div class="form-group">


                            <label for="issueDate">

                                Issue Date

                            </label>


                            <div class="input-wrapper">


                                <i
                                    class="fa-solid fa-calendar-days input-icon">
                                </i>


                                <input
                                    type="date"
                                    id="issueDate"
                                    name="issueDate"
                                    readonly>


                            </div>


                        </div>


                        <!-- =========================
                             DUE DATE
                        ========================== -->

                        <div class="form-group">


                            <label for="dueDate">

                                Due Date

                            </label>


                            <div class="input-wrapper">


                                <i
                                    class="fa-solid fa-calendar-check input-icon">
                                </i>


                                <input
                                    type="date"
                                    id="dueDate"
                                    name="dueDate"
                                    readonly>


                            </div>


                        </div>


                        <!-- =========================
                             RETURN DATE
                        ========================== -->

                        <div class="form-group">


                            <label for="returnDate">

                                Return Date

                                <span>*</span>

                            </label>


                            <div class="input-wrapper">


                                <i
                                    class="fa-solid fa-calendar-check input-icon">
                                </i>


                                <input
                                    type="date"
                                    id="returnDate"
                                    name="returnDate"
                                    required>


                            </div>


                        </div>


                    </div>


                    <!-- =========================
                         ADDITIONAL INFORMATION
                    ========================== -->

                    <div
                        class="form-section-title details-section">


                        <i class="fa-solid fa-note-sticky"></i>


                        <span>
                            Additional Information
                        </span>


                    </div>


                    <!-- NOTES -->

                    <div class="form-group full-width">


                        <label for="notes">

                            Notes

                        </label>


                        <div class="textarea-wrapper">


                            <i
                                class="fa-solid fa-pen input-icon textarea-icon">
                            </i>


                            <textarea
                                id="notes"
                                name="notes"
                                rows="5"
                                placeholder="Enter any additional notes..."></textarea>


                        </div>


                    </div>


                    <!-- =========================
                         RETURN INFORMATION BOX
                    ========================== -->

                    <div class="return-info-box">


                        <div class="return-info-icon">


                            <i
                                class="fa-solid fa-circle-check">
                            </i>


                        </div>


                        <div>


                            <strong>
                                Automatic Fine Calculation
                            </strong>


                            <p>

                                Fine will be calculated automatically at
                                ₹10 per day after the due date.

                            </p>


                        </div>


                    </div>


                    <!-- =========================
                         ACTION BUTTONS
                    ========================== -->

                    <div class="form-actions">


                        <!-- CANCEL -->

                        <a
                            href="${pageContext.request.contextPath}/DashboardController"
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


                        <!-- RETURN -->

                        <button
                            type="submit"
                            class="return-btn">

                            <i class="fa-solid fa-rotate-left"></i>

                            Return Book

                        </button>


                    </div>


                </form>


            </section>


        </main>


    </div>


    <!-- =========================
         JAVASCRIPT
    ========================== -->

    <script>


        /* =========================
           CONTEXT PATH
        ========================== */

        const contextPath =
            "${pageContext.request.contextPath}";


        /* =========================
           ELEMENTS
        ========================== */

        const memberSearch =
            document.getElementById("memberSearch");


        const memberHidden =
            document.getElementById("member");


        const bookSelect =
            document.getElementById("book");


        const issueDate =
            document.getElementById("issueDate");


        const dueDate =
            document.getElementById("dueDate");


        const returnDate =
            document.getElementById("returnDate");


        const borrowingId =
            document.getElementById("borrowingId");


        /* =========================
           SET TODAY
        ========================== */

        function setToday() {


            const today =
                new Date()
                    .toISOString()
                    .split("T")[0];


            returnDate.value =
                today;


            returnDate.min =
                today;

        }


        setToday();


        /* =========================
           MEMBER SEARCH / CHANGE
        ========================== */

        memberSearch.addEventListener(
            "input",
            function () {


                const typedValue =
                    this.value.trim();


                const options =
                    document.querySelectorAll(
                        "#memberList option"
                    );


                let selectedMemberId =
                    "";


                /* Find matching member */

                options.forEach(
                    function (option) {


                        if (
                            option.value
                                .toLowerCase() ===
                            typedValue
                                .toLowerCase()
                        ) {


                            selectedMemberId =
                                option.getAttribute(
                                    "data-member-id"
                                );

                        }

                    }
                );


                /* Store actual member ID */

                memberHidden.value =
                    selectedMemberId;


                /* =========================
                   RESET BOOK DETAILS
                ========================== */

                bookSelect.innerHTML =
                    '<option value="">Select issued book</option>';


                bookSelect.disabled =
                    true;


                issueDate.value =
                    "";


                dueDate.value =
                    "";


                borrowingId.value =
                    "";


                /* =========================
                   INVALID / EMPTY MEMBER
                ========================== */

                if (!selectedMemberId) {


                    if (typedValue.length > 0) {


                        bookSelect.innerHTML =
                            '<option value="">Select valid member</option>';

                    }

                    else {


                        bookSelect.innerHTML =
                            '<option value="">Select member first</option>';

                    }


                    return;

                }


                /* =========================
                   GET MEMBER BOOKS
                ========================== */

                fetch(
                    contextPath +
                    "/ReturnBookController?action=getMemberBooks&memberId=" +
                    encodeURIComponent(
                        selectedMemberId
                    )
                )


                .then(
                    response => {


                        if (!response.ok) {

                            throw new Error(
                                "Failed to load books"
                            );

                        }


                        return response.json();

                    }
                )


                .then(
                    data => {


                        bookSelect.innerHTML =
                            '<option value="">Select issued book</option>';


                        /* No active books */

                        if (
                            data.length === 0
                        ) {


                            bookSelect.innerHTML =
                                '<option value="">No issued books found</option>';


                            bookSelect.disabled =
                                true;


                            return;

                        }


                        /* =========================
                           ADD BOOK OPTIONS
                        ========================== */

                        data.forEach(
                            function (borrowing) {


                                const option =
                                    document.createElement(
                                        "option"
                                    );


                                /* Value = borrowing ID */

                                option.value =
                                    borrowing.borrowingId;


                                /* Book title + status */

                                option.textContent =
                                    borrowing.bookTitle +
                                    " - " +
                                    borrowing.status;


                                /* Store dates */

                                option.dataset.issueDate =
                                    borrowing.issueDate;


                                option.dataset.dueDate =
                                    borrowing.dueDate;


                                /* Store book ID */

                                option.dataset.bookId =
                                    borrowing.bookId;


                                bookSelect.appendChild(
                                    option
                                );

                            }
                        );


                        bookSelect.disabled =
                            false;

                    }
                )


                .catch(
                    error => {


                        console.error(
                            error
                        );


                        bookSelect.innerHTML =
                            '<option value="">Unable to load books</option>';


                        bookSelect.disabled =
                            true;

                    }
                );

            }
        );


        /* =========================
           BOOK CHANGE
        ========================== */

        bookSelect.addEventListener(
            "change",
            function () {


                const selectedOption =
                    this.options[
                        this.selectedIndex
                    ];


                /* Nothing selected */

                if (
                    !selectedOption ||
                    !selectedOption.value
                ) {


                    borrowingId.value =
                        "";


                    issueDate.value =
                        "";


                    dueDate.value =
                        "";


                    return;

                }


                /* Set borrowing ID */

                borrowingId.value =
                    selectedOption.value;


                /* Set issue date */

                issueDate.value =
                    selectedOption.dataset.issueDate ||
                    "";


                /* Set due date */

                dueDate.value =
                    selectedOption.dataset.dueDate ||
                    "";

            }
        );


        /* =========================
           FORM RESET
        ========================== */

        document
            .querySelector(".return-book-form")
            .addEventListener(
                "reset",
                function () {


                    setTimeout(
                        function () {


                            /* Clear member */

                            memberSearch.value =
                                "";


                            memberHidden.value =
                                "";


                            /* Clear book */

                            bookSelect.innerHTML =
                                '<option value="">Select member first</option>';


                            bookSelect.disabled =
                                true;


                            /* Clear dates */

                            issueDate.value =
                                "";


                            dueDate.value =
                                "";


                            /* Clear borrowing */

                            borrowingId.value =
                                "";


                            /* Set today's date */

                            setToday();


                        },
                        0
                    );

                }
            );


    </script>


</body>

</html>