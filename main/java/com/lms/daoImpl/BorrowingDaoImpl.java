package com.lms.daoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.lms.dao.BorrowingDao;
import com.lms.pojo.Borrowing;
import com.lms.util.DbUtil;

public class BorrowingDaoImpl implements BorrowingDao {

    // =========================================================
    // ISSUE BOOK
    // =========================================================

	private static final double FINE_PER_DAY = 10.0;
	
    @Override
    public boolean issueBook(Borrowing borrowing) {

        Connection con = null;

        try {

            con = DbUtil.getConnection();

            con.setAutoCommit(false);

            // -------------------------------------------------
            // Check book availability
            // -------------------------------------------------

            String checkBookSql =
                    "SELECT available_copies " +
                    "FROM books " +
                    "WHERE book_id = ? " +
                    "FOR UPDATE";

            try (PreparedStatement ps =
                         con.prepareStatement(checkBookSql)) {

                ps.setInt(1, borrowing.getBookId());

                try (ResultSet rs = ps.executeQuery()) {

                    if (!rs.next()) {
                        con.rollback();
                        return false;
                    }

                    int availableCopies =
                            rs.getInt("available_copies");

                    if (availableCopies <= 0) {
                        con.rollback();
                        return false;
                    }
                }
            }

            // -------------------------------------------------
            // Check member status
            // -------------------------------------------------

            String checkMemberSql =
                    "SELECT status " +
                    "FROM members " +
                    "WHERE member_id = ?";

            try (PreparedStatement ps =
                         con.prepareStatement(checkMemberSql)) {

                ps.setInt(1, borrowing.getMemberId());

                try (ResultSet rs = ps.executeQuery()) {

                    if (!rs.next()) {
                        con.rollback();
                        return false;
                    }

                    String status =
                            rs.getString("status");

                    if (!"Active".equalsIgnoreCase(status)) {
                        con.rollback();
                        return false;
                    }
                }
            }

            // -------------------------------------------------
            // Check whether member already has this book
            // -------------------------------------------------

            String checkExistingSql =
                    "SELECT COUNT(*) " +
                    "FROM borrowings " +
                    "WHERE member_id = ? " +
                    "AND book_id = ? " +
                    "AND status IN ('Issued', 'Overdue')";

            try (PreparedStatement ps =
                         con.prepareStatement(checkExistingSql)) {

                ps.setInt(1, borrowing.getMemberId());
                ps.setInt(2, borrowing.getBookId());

                try (ResultSet rs = ps.executeQuery()) {

                    if (rs.next() && rs.getInt(1) > 0) {
                        con.rollback();
                        return false;
                    }
                }
            }

            // -------------------------------------------------
            // Insert borrowing record
            // -------------------------------------------------

            String insertSql =
                    "INSERT INTO borrowings " +
                    "(member_id, book_id, issue_date, due_date, " +
                    "return_date, status, fine, notes) " +
                    "VALUES (?, ?, ?, ?, NULL, 'Issued', 0, ?)";

            try (PreparedStatement ps =
                         con.prepareStatement(insertSql)) {

                ps.setInt(1, borrowing.getMemberId());
                ps.setInt(2, borrowing.getBookId());
                ps.setDate(3, borrowing.getIssueDate());
                ps.setDate(4, borrowing.getDueDate());
                ps.setString(5, borrowing.getNotes());

                int rowsInserted =
                        ps.executeUpdate();

                if (rowsInserted <= 0) {
                    con.rollback();
                    return false;
                }
            }

            // -------------------------------------------------
            // Decrease available copies
            // -------------------------------------------------

            String updateBookSql =
                    "UPDATE books " +
                    "SET available_copies = available_copies - 1 " +
                    "WHERE book_id = ? " +
                    "AND available_copies > 0";

            try (PreparedStatement ps =
                         con.prepareStatement(updateBookSql)) {

                ps.setInt(1, borrowing.getBookId());

                int rowsUpdated =
                        ps.executeUpdate();

                if (rowsUpdated <= 0) {
                    con.rollback();
                    return false;
                }
            }

            // -------------------------------------------------
            // Commit transaction
            // -------------------------------------------------

            con.commit();

            return true;

        } catch (SQLException e) {

            if (con != null) {

                try {
                    con.rollback();
                } catch (SQLException rollbackException) {
                    rollbackException.printStackTrace();
                }
            }

            e.printStackTrace();

            return false;

        } finally {

            if (con != null) {

                try {
                    con.setAutoCommit(true);
                    con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }


    // =========================================================
    // GET ALL BORROWINGS
    // =========================================================

    @Override
    public List<Borrowing> getAllBorrowings() {

        List<Borrowing> borrowings = new ArrayList<>();

        String sql =
            "SELECT b.borrowing_id, " +
            "       b.member_id, " +
            "       b.book_id, " +
            "       b.issue_date, " +
            "       b.due_date, " +
            "       b.return_date, " +
            "       b.status, " +
            "       b.fine, " +
            "       b.notes, " +
            "       CONCAT(m.first_name, ' ', m.last_name) AS member_name, " +
            "       bk.title AS book_title " +
            "FROM borrowings b " +
            "LEFT JOIN members m " +
            "       ON b.member_id = m.member_id " +
            "LEFT JOIN books bk " +
            "       ON b.book_id = bk.book_id " +
            "ORDER BY b.borrowing_id DESC";

        try (
            Connection connection = DbUtil.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery()
        ) {

            while (rs.next()) {

                Borrowing borrowing = new Borrowing();

                borrowing.setBorrowingId(
                    rs.getInt("borrowing_id")
                );

                borrowing.setMemberId(
                    rs.getInt("member_id")
                );

                borrowing.setBookId(
                    rs.getInt("book_id")
                );

                borrowing.setIssueDate(
                    rs.getDate("issue_date")
                );

                borrowing.setDueDate(
                    rs.getDate("due_date")
                );

                borrowing.setReturnDate(
                    rs.getDate("return_date")
                );

                borrowing.setStatus(
                    rs.getString("status")
                );

                borrowing.setFine(
                    rs.getDouble("fine")
                );

                borrowing.setNotes(
                    rs.getString("notes")
                );

                borrowing.setMemberName(
                    rs.getString("member_name")
                );

                borrowing.setBookTitle(
                    rs.getString("book_title")
                );

                borrowings.add(borrowing);
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return borrowings;
    }


    // =========================================================
    // GET BORROWING BY ID
    // =========================================================

    @Override
    public Borrowing getBorrowingById(int borrowingId) {

        Borrowing borrowing = null;

        String sql =
            "SELECT b.borrowing_id, " +
            "       b.member_id, " +
            "       b.book_id, " +
            "       b.issue_date, " +
            "       b.due_date, " +
            "       b.return_date, " +
            "       b.status, " +
            "       b.fine, " +
            "       b.notes, " +
            "       CONCAT(m.first_name, ' ', m.last_name) AS member_name, " +
            "       bk.title AS book_title " +
            "FROM borrowings b " +
            "LEFT JOIN members m " +
            "       ON b.member_id = m.member_id " +
            "LEFT JOIN books bk " +
            "       ON b.book_id = bk.book_id " +
            "WHERE b.borrowing_id = ?";

        try (
            Connection connection = DbUtil.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql)
        ) {

            ps.setInt(1, borrowingId);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {

                    borrowing = new Borrowing();

                    borrowing.setBorrowingId(
                        rs.getInt("borrowing_id")
                    );

                    borrowing.setMemberId(
                        rs.getInt("member_id")
                    );

                    borrowing.setBookId(
                        rs.getInt("book_id")
                    );

                    borrowing.setIssueDate(
                        rs.getDate("issue_date")
                    );

                    borrowing.setDueDate(
                        rs.getDate("due_date")
                    );

                    borrowing.setReturnDate(
                        rs.getDate("return_date")
                    );

                    borrowing.setStatus(
                        rs.getString("status")
                    );

                    borrowing.setFine(
                        rs.getDouble("fine")
                    );

                    borrowing.setNotes(
                        rs.getString("notes")
                    );

                    borrowing.setMemberName(
                        rs.getString("member_name")
                    );

                    borrowing.setBookTitle(
                        rs.getString("book_title")
                    );
                }
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return borrowing;
    }


    // =========================================================
    // GET ACTIVE BORROWINGS
    // =========================================================

    @Override
    public List<Borrowing> getActiveBorrowings() {

        List<Borrowing> borrowings =
                new ArrayList<>();

        String sql =
                "SELECT borrowing_id, member_id, book_id, " +
                "issue_date, due_date, return_date, " +
                "status, fine, notes " +
                "FROM borrowings " +
                "WHERE status IN ('Issued', 'Overdue') " +
                "ORDER BY due_date ASC";

        try (Connection con =
                     DbUtil.getConnection();
             PreparedStatement ps =
                     con.prepareStatement(sql);
             ResultSet rs =
                     ps.executeQuery()) {

            while (rs.next()) {

                borrowings.add(
                        mapBorrowing(rs)
                );
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return borrowings;
    }


    // =========================================================
    // GET MEMBER BORROWING HISTORY
    // =========================================================

    @Override
    public List<Borrowing> getBorrowingsByMemberId(
            int memberId) {

        List<Borrowing> borrowings =
                new ArrayList<>();

        String sql =
                "SELECT borrowing_id, member_id, book_id, " +
                "issue_date, due_date, return_date, " +
                "status, fine, notes " +
                "FROM borrowings " +
                "WHERE member_id = ? " +
                "ORDER BY borrowing_id DESC";

        try (Connection con =
                     DbUtil.getConnection();
             PreparedStatement ps =
                     con.prepareStatement(sql)) {

            ps.setInt(1, memberId);

            try (ResultSet rs =
                         ps.executeQuery()) {

                while (rs.next()) {

                    borrowings.add(
                            mapBorrowing(rs)
                    );
                }
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return borrowings;
    }


    // =========================================================
    // GET ACTIVE BORROWINGS BY MEMBER ID
    // =========================================================

    @Override
    public List<Borrowing> getActiveBorrowingsByMemberId(
            int memberId) {

        List<Borrowing> borrowings =
                new ArrayList<>();

        String sql =
                "SELECT b.borrowing_id, b.member_id, b.book_id, " +
                "b.issue_date, b.due_date, b.return_date, " +
                "b.status, b.fine, b.notes, " +
                "bk.title AS book_title " +
                "FROM borrowings b " +
                "LEFT JOIN books bk " +
                "ON b.book_id = bk.book_id " +
                "WHERE b.member_id = ? " +
                "AND b.status IN ('Issued', 'Overdue') " +
                "ORDER BY b.issue_date DESC";

        try (Connection con =
                     DbUtil.getConnection();
             PreparedStatement ps =
                     con.prepareStatement(sql)) {

            ps.setInt(1, memberId);

            try (ResultSet rs =
                         ps.executeQuery()) {

                while (rs.next()) {

                    Borrowing borrowing =
                            mapBorrowing(rs);

                    borrowing.setBookTitle(
                            rs.getString("book_title")
                    );

                    borrowings.add(borrowing);
                }
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return borrowings;
    }


    // =========================================================
    // RETURN BOOK
    // =========================================================
    // =========================================================
	 // RETURN BOOK
	 // =========================================================
	
	 @Override
	 public boolean returnBook(
	         int borrowingId,
	         java.sql.Date returnDate) {
	
	     Connection con = null;
	
	     try {
	
	         con = DbUtil.getConnection();
	         con.setAutoCommit(false);
	
	         // -------------------------------------------------
	         // Find book ID and due date
	         // -------------------------------------------------
	
	         int bookId;
	         java.sql.Date dueDate;
	
	         String findSql =
	                 "SELECT book_id, due_date " +
	                 "FROM borrowings " +
	                 "WHERE borrowing_id = ? " +
	                 "AND status IN ('Issued', 'Overdue')";
	
	         try (PreparedStatement ps =
	                      con.prepareStatement(findSql)) {
	
	             ps.setInt(1, borrowingId);
	
	             try (ResultSet rs = ps.executeQuery()) {
	
	                 if (!rs.next()) {
	                     con.rollback();
	                     return false;
	                 }
	
	                 bookId = rs.getInt("book_id");
	                 dueDate = rs.getDate("due_date");
	             }
	         }
	
	         // -------------------------------------------------
	         // Calculate fine automatically
	         // ₹10 per overdue day
	         // -------------------------------------------------
	
	         long overdueDays = 0;
	
	         if (returnDate.after(dueDate)) {
	
	             long difference =
	                     returnDate.getTime() - dueDate.getTime();
	
	             overdueDays =
	                     difference / (1000L * 60 * 60 * 24);
	         }
	
	         double fine =
	                 overdueDays * FINE_PER_DAY;
	
	         // -------------------------------------------------
	         // Update borrowing
	         // -------------------------------------------------
	
	         String updateBorrowingSql =
	                 "UPDATE borrowings " +
	                 "SET return_date = ?, " +
	                 "status = 'Returned', " +
	                 "fine = ? " +
	                 "WHERE borrowing_id = ? " +
	                 "AND status IN ('Issued', 'Overdue')";
	
	         try (PreparedStatement ps =
	                      con.prepareStatement(updateBorrowingSql)) {
	
	             ps.setDate(1, returnDate);
	             ps.setDouble(2, fine);
	             ps.setInt(3, borrowingId);
	
	             int rowsUpdated =
	                     ps.executeUpdate();
	
	             if (rowsUpdated <= 0) {
	                 con.rollback();
	                 return false;
	             }
	         }
	
	         // -------------------------------------------------
	         // Increase available copies
	         // -------------------------------------------------
	
	         String updateBookSql =
	                 "UPDATE books " +
	                 "SET available_copies = available_copies + 1 " +
	                 "WHERE book_id = ?";
	
	         try (PreparedStatement ps =
	                      con.prepareStatement(updateBookSql)) {
	
	             ps.setInt(1, bookId);
	
	             int rowsUpdated =
	                     ps.executeUpdate();
	
	             if (rowsUpdated <= 0) {
	                 con.rollback();
	                 return false;
	             }
	         }
	
	         // -------------------------------------------------
	         // Commit transaction
	         // -------------------------------------------------
	
	         con.commit();
	
	         return true;
	
	     } catch (SQLException e) {
	
	         if (con != null) {
	
	             try {
	                 con.rollback();
	             } catch (SQLException rollbackException) {
	                 rollbackException.printStackTrace();
	             }
	         }
	
	         e.printStackTrace();
	
	         return false;
	
	     } finally {
	
	         if (con != null) {
	
	             try {
	                 con.setAutoCommit(true);
	                 con.close();
	             } catch (SQLException e) {
	                 e.printStackTrace();
	             }
	         }
	     }
	 }


    // =========================================================
    // ACTIVE BORROWING COUNT
    // =========================================================

    @Override
    public int getActiveBorrowingCount() {

        String sql =
                "SELECT COUNT(*) " +
                "FROM borrowings " +
                "WHERE status IN ('Issued', 'Overdue')";

        try (Connection con =
                     DbUtil.getConnection();
             PreparedStatement ps =
                     con.prepareStatement(sql);
             ResultSet rs =
                     ps.executeQuery()) {

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return 0;
    }


    // =========================================================
    // MEMBER ACTIVE BORROWING COUNT
    // =========================================================

    @Override
    public int getMemberActiveBorrowingCount(
            int memberId) {

        String sql =
                "SELECT COUNT(*) " +
                "FROM borrowings " +
                "WHERE member_id = ? " +
                "AND status IN ('Issued', 'Overdue')";

        try (Connection con =
                     DbUtil.getConnection();
             PreparedStatement ps =
                     con.prepareStatement(sql)) {

            ps.setInt(1, memberId);

            try (ResultSet rs =
                         ps.executeQuery()) {

                if (rs.next()) {
                    return rs.getInt(1);
                }
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return 0;
    }


    // =========================================================
    // MAP RESULTSET TO BORROWING OBJECT
    // =========================================================

    private Borrowing mapBorrowing(ResultSet rs)
            throws SQLException {

        Borrowing borrowing =
                new Borrowing();

        borrowing.setBorrowingId(
                rs.getInt("borrowing_id")
        );

        borrowing.setMemberId(
                rs.getInt("member_id")
        );

        borrowing.setBookId(
                rs.getInt("book_id")
        );

        borrowing.setIssueDate(
                rs.getDate("issue_date")
        );

        borrowing.setDueDate(
                rs.getDate("due_date")
        );

        borrowing.setReturnDate(
                rs.getDate("return_date")
        );

        borrowing.setStatus(
                rs.getString("status")
        );

        borrowing.setFine(
                rs.getDouble("fine")
        );

        borrowing.setNotes(
                rs.getString("notes")
        );

        return borrowing;
    }


    // =========================================================
    // RECENT ACTIVITIES
    // =========================================================

    @Override
    public List<Borrowing> getRecentActivities() {

        List<Borrowing> borrowings =
                new ArrayList<>();

        String sql =
                "SELECT b.borrowing_id, b.member_id, b.book_id, " +
                "b.issue_date, b.due_date, b.return_date, " +
                "b.status, b.fine, b.notes, " +
                "CONCAT(m.first_name, ' ', m.last_name) AS member_name, " +
                "bk.title AS book_title " +
                "FROM borrowings b " +
                "LEFT JOIN members m " +
                "ON b.member_id = m.member_id " +
                "LEFT JOIN books bk " +
                "ON b.book_id = bk.book_id " +
                "ORDER BY b.borrowing_id DESC " +
                "LIMIT 10";

        try (Connection con =
                     DbUtil.getConnection();
             PreparedStatement ps =
                     con.prepareStatement(sql);
             ResultSet rs =
                     ps.executeQuery()) {

            while (rs.next()) {

                Borrowing borrowing =
                        mapBorrowing(rs);

                borrowing.setMemberName(
                        rs.getString("member_name")
                );

                borrowing.setBookTitle(
                        rs.getString("book_title")
                );

                borrowings.add(borrowing);
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return borrowings;
    }
    
   
    @Override
    public void updateOverdueFines() {

        String sql =
            "UPDATE borrowings " +
            "SET status = 'Overdue', " +
            "    fine = DATEDIFF(CURDATE(), due_date) * ? " +
            "WHERE due_date < CURDATE() " +
            "AND status IN ('Issued', 'Overdue')";

        try (
            Connection connection = DbUtil.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql)
        ) {

            ps.setDouble(1, FINE_PER_DAY);

            ps.executeUpdate();

        } catch (Exception e) {

            e.printStackTrace();
        }
    }
}