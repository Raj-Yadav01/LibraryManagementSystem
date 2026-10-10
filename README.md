# Library Management System

A Java-based web application for managing library books, members, and
borrowing/return transactions. The project uses JSP, Servlets, JDBC, and
MySQL, and is designed to run as a Dynamic Web Project on Apache Tomcat
10.1.

## Features

-   **Authentication**: Login to the library management application.
-   **Dashboard**: View library transaction summaries and recent
    activity.
-   **Book management**: Add, view, update, and delete books; track
    total and available copies.
-   **Member management**: Add, view, update, and deactivate/delete
    members, subject to borrowing restrictions.
-   **Issue books**: Issue available books to active members and record
    issue and due dates.
-   **Return books**: Select a member's active borrowing, view issue/due
    dates, and record the return date.
-   **Borrowing history**: Review transactions, status, due dates,
    return dates, and fines.
-   **Overdue tracking**: Mark overdue borrowings and calculate fines at
    ₹10 per overdue day.
-   **Responsive interface**: JSP pages with CSS styling and shared
    navigation components.

## Technology Stack

-   Java 17
-   Jakarta Servlet / JSP
-   Apache Tomcat 10.1
-   MySQL
-   JDBC
-   JSTL 3 (`jakarta.tags.core`)
-   HTML, CSS, JavaScript
-   Eclipse / Spring Tools Suite (STS) Dynamic Web Project

## Project Structure

The exact structure may vary slightly depending on your workspace. The
project uses packages similar to:

``` text
src/main/java/
└── com/lms/
    ├── controller/       # Servlet controllers
    ├── dao/              # DAO interfaces
    ├── daoImpl/          # JDBC DAO implementations
    ├── pojo/             # Model/POJO classes
    ├── service/          # Service interfaces
    ├── serviceImpl/      # Service implementations
    └── util/             # Database utilities and application listeners

src/main/webapp/
├── Assets/
│   └── CSS/              # Stylesheets
├── jsp/
│   ├── includes/         # Shared JSP fragments
│   ├── login.jsp
│   ├── dashboard.jsp
│   ├── books.jsp
│   ├── members.jsp
│   ├── issueBook.jsp
│   ├── returnBook.jsp
│   └── borrowingHistory.jsp
└── WEB-INF/
    └── lib/              # JDBC/JSTL libraries, if not supplied by the server
```

## Main Modules

### Books

Manage book details such as title, author, category, ISBN, publisher,
total copies, and available copies.

### Members

Manage member details and status. Members with active or overdue
borrowings should not be deactivated or deleted until those transactions
are resolved.

### Issue Book

An issue transaction records the member, book, issue date, due date,
status, and fine. A book's available-copy count is decreased when it is
issued.

### Return Book

The return flow records the return date, marks the borrowing as
`Returned`, and increases the book's available-copy count. The return
logic calculates the fine from the due date at ₹10 per overdue day.

### Borrowing History

Displays borrowing transactions with member and book information,
issue/due/return dates, status, and fine.

## Prerequisites

Install the following before running the project:

1.  JDK 17.
2.  Apache Tomcat 10.1.
3.  MySQL Server and MySQL Workbench (or another MySQL client).
4.  Eclipse or Spring Tools Suite with Dynamic Web Project / Web Tools
    support.
5.  MySQL Connector/J JDBC driver.
6.  Jakarta JSTL 3 libraries if they are not already available to the
    application.

> This project uses Tomcat 10.1 and Jakarta APIs. Use
> `jakarta.servlet.*` imports, not the older `javax.servlet.*` imports.

## Database Setup

Create and select the database:

``` sql
CREATE DATABASE IF NOT EXISTS library_db;
USE library_db;
```

The application expects tables for users, books, members, and
borrowings. Column names should match the SQL used in the project's DAO
implementation. The core fields used by the application include:

-   `users`: user ID, first name, last name, email, password, phone
    number.
-   `books`: book ID, title, author, category, ISBN, publisher, total
    copies, available copies, and added timestamp.
-   `members`: member ID, first name, last name, email, phone number,
    password, status, and created timestamp.
-   `borrowings`: borrowing ID, member ID, book ID, issue date, due
    date, return date, status, fine, and notes.

**Important:** This README does not invent a complete `CREATE TABLE`
schema because the exact constraints and types must match the schema
already used in the project's DAO code. Use the actual SQL/schema from
your project, or export the schema from MySQL Workbench before setting
up a fresh database.

## Database Configuration

Check the database connection settings in `com.lms.util.DbUtil` (or the
equivalent database utility class). The current local development URL is
expected to look like:

``` text
jdbc:mysql://localhost:3306/library_db?allowPublicKeyRetrieval=true&useSSL=false
```

Set the correct MySQL username and password in your local configuration.
**Do not commit real database passwords or other secrets to GitHub.**

Ensure the MySQL Connector/J JAR is available to the web application,
commonly under `WEB-INF/lib` for a non-Maven Dynamic Web Project.

## JSTL Configuration

JSP pages use the Jakarta JSTL core tag library:

``` jsp
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
```

The JSTL API and implementation JARs must be available to the
application if they are not otherwise provided.

## Run the Project in STS / Eclipse

1.  Open the project in STS/Eclipse.

2.  Confirm the project uses Java 17 and has the Dynamic Web Project
    facets configured.

3.  Add/configure Apache Tomcat 10.1 in the **Servers** view.

4.  Confirm MySQL is running and the `library_db` database and required
    tables exist.

5.  Verify the JDBC URL, username, and password in the database utility
    class.

6.  Confirm required JARs are available, including MySQL Connector/J and
    JSTL.

7.  Clean/build the project and resolve any compilation errors.

8.  Add the project to Tomcat and start the server.

9.  Open the application in a browser. The context path used during
    development is:

    ``` text
    http://localhost:8080/LibraryManagementSystem/
    ```

    If the login page is not configured as the welcome page, open the
    login JSP directly:

    ``` text
    http://localhost:8080/LibraryManagementSystem/jsp/login.jsp
    ```

## Fine Calculation

The configured fine rate is **₹10 per overdue day**.

-   A borrowing is overdue when its due date is earlier than the current
    date and its status is `Issued` or `Overdue`.
-   Fine is calculated as the number of overdue days multiplied by ₹10.
-   Returning a book records the return date, updates the transaction
    status, and restores one available copy.

### Background scheduler note

The project includes an application-start listener and a scheduled task
intended to run `updateOverdueFines()` at startup and every 24 hours
while the web application is running. The scheduler's behavior depends
on the implementation of `BorrowingDaoImpl.updateOverdueFines()` and a
successful database connection. Verify the console and database records
during testing. The in-process scheduler does not run while Tomcat/the
web application is stopped.

## Basic Testing Checklist

-   [ ] Log in with a valid account.
-   [ ] Confirm invalid login details show an error.
-   [ ] Add a book and verify it appears in the book list.
-   [ ] Add a member and verify the member list.
-   [ ] Issue an available book to an active member.
-   [ ] Confirm the available-copy count decreases after issuing.
-   [ ] Confirm the borrowing appears in Borrowing History.
-   [ ] Verify overdue status and fine calculation.
-   [ ] Return a book and confirm the status becomes `Returned`.
-   [ ] Confirm the available-copy count increases after return.
-   [ ] Verify members with active borrowings cannot be
    deactivated/deleted.

## Troubleshooting

-   **`javax.servlet` errors:** The application targets Tomcat 10.1, so
    update imports to `jakarta.servlet.*`.
-   **JSTL tag errors:** Confirm JSTL 3 JARs are on the web
    application's classpath and use `uri="jakarta.tags.core"`.
-   **Database connection errors:** Check MySQL service status, database
    name, port, credentials, and JDBC driver.
-   **404 errors:** Check the Tomcat context path and servlet mapping,
    for example `/BorrowingController` or `/ReturnBookController`.
-   **Compilation errors after changes:** Use **Project → Clean** and
    inspect the first error in the Problems view.

## Security Notes

-   Use a strong password for the database account.
-   Keep credentials out of source control.
-   For production use, store passwords using a secure password-hashing
    algorithm rather than plain text.
-   Validate user input on the server as well as in the browser.
-   Configure authorization checks for each role and action before
    deploying publicly.

## Author / Academic Project

Developed as a learning project for a Java web application using JSP,
Servlets, JDBC, and MySQL.

------------------------------------------------------------------------

**Note:** Update this README if the project's actual table definitions,
class names, login route, or deployment context differ from the details
above.
