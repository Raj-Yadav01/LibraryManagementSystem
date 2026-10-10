package com.lms.daoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.lms.dao.MemberDao;
import com.lms.pojo.Member;
import com.lms.util.DbUtil;

public class MemberDaoImpl implements MemberDao {

    // =========================================================
    // GET ALL MEMBERS
    // =========================================================
    @Override
    public List<Member> getAllMembers() {

        List<Member> members = new ArrayList<>();

        String sql = "SELECT member_id, first_name, last_name, email, "
                   + "phone_no, status, created_at "
                   + "FROM members ORDER BY member_id DESC";

        try (Connection con = DbUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                Member member = mapMember(rs);
                members.add(member);
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return members;
    }


    // =========================================================
    // GET MEMBER BY ID
    // =========================================================
    @Override
    public Member getMemberById(int memberId) {

        String sql = "SELECT member_id, first_name, last_name, email, "
                   + "phone_no, status, created_at "
                   + "FROM members WHERE member_id = ?";

        try (Connection con = DbUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, memberId);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {

                    return mapMember(rs);
                }
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return null;
    }


    // =========================================================
    // ADD MEMBER
    // =========================================================
    @Override
    public boolean addMember(Member member) {

        String sql = "INSERT INTO members "
                   + "(first_name, last_name, email, phone_no, password, status) "
                   + "VALUES (?, ?, ?, ?, ?, 'Active')";

        try (Connection con = DbUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, member.getFirstName());
            ps.setString(2, member.getLastName());
            ps.setString(3, member.getEmail());
            ps.setString(4, member.getPhoneNo());
            ps.setString(5, member.getPassword());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {

            e.printStackTrace();
            return false;
        }
    }


    // =========================================================
    // UPDATE MEMBER
    // =========================================================
    @Override
    public boolean updateMember(Member member) {

        String sql = "UPDATE members SET "
                   + "first_name = ?, "
                   + "last_name = ?, "
                   + "email = ?, "
                   + "phone_no = ?, "
                   + "status = ? "
                   + "WHERE member_id = ?";

        try (Connection con = DbUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, member.getFirstName());
            ps.setString(2, member.getLastName());
            ps.setString(3, member.getEmail());
            ps.setString(4, member.getPhoneNo());
            ps.setString(5, member.getStatus());
            ps.setInt(6, member.getMemberId());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {

            e.printStackTrace();
            return false;
        }
    }


    // =========================================================
    // DELETE MEMBER
    //
    // RULES:
    // 1. Member must be Inactive
    // 2. Member must NOT have Issued/Overdue books
    // 3. Old borrowing records are deleted first
    // 4. Then member is permanently deleted
    // =========================================================
    @Override
    public boolean deleteMember(int memberId) {

        Connection con = null;

        try {

            con = DbUtil.getConnection();

            // -------------------------------------------------
            // START TRANSACTION
            // -------------------------------------------------
            con.setAutoCommit(false);


            // -------------------------------------------------
            // STEP 1: CHECK MEMBER STATUS
            // -------------------------------------------------
            String checkMemberSql =
                    "SELECT status FROM members WHERE member_id = ?";

            try (PreparedStatement ps =
                         con.prepareStatement(checkMemberSql)) {

                ps.setInt(1, memberId);

                try (ResultSet rs = ps.executeQuery()) {

                    if (!rs.next()) {

                        con.rollback();
                        return false;
                    }

                    String status = rs.getString("status");

                    // Only Inactive member can be permanently deleted
                    if (!"Inactive".equalsIgnoreCase(status)) {

                        con.rollback();
                        return false;
                    }
                }
            }


            // -------------------------------------------------
            // STEP 2: CHECK CURRENT BORROWINGS
            // Issued / Overdue = member cannot be deleted
            // -------------------------------------------------
            String checkBorrowingSql =
                    "SELECT COUNT(*) "
                  + "FROM borrowings "
                  + "WHERE member_id = ? "
                  + "AND status IN ('Issued', 'Overdue')";

            try (PreparedStatement ps =
                         con.prepareStatement(checkBorrowingSql)) {

                ps.setInt(1, memberId);

                try (ResultSet rs = ps.executeQuery()) {

                    if (rs.next()) {

                        int currentBorrowings = rs.getInt(1);

                        if (currentBorrowings > 0) {

                            con.rollback();
                            return false;
                        }
                    }
                }
            }


            // -------------------------------------------------
            // STEP 3: DELETE OLD BORROWING HISTORY
            //
            // This removes Returned borrowing records so that
            // foreign-key constraint does not block member delete.
            // -------------------------------------------------
            String deleteBorrowingsSql =
                    "DELETE FROM borrowings WHERE member_id = ?";

            try (PreparedStatement ps =
                         con.prepareStatement(deleteBorrowingsSql)) {

                ps.setInt(1, memberId);

                ps.executeUpdate();
            }


            // -------------------------------------------------
            // STEP 4: DELETE MEMBER
            // -------------------------------------------------
            String deleteMemberSql =
                    "DELETE FROM members "
                  + "WHERE member_id = ? "
                  + "AND status = 'Inactive'";

            try (PreparedStatement ps =
                         con.prepareStatement(deleteMemberSql)) {

                ps.setInt(1, memberId);

                int rowsDeleted = ps.executeUpdate();

                if (rowsDeleted > 0) {

                    // Everything successful
                    con.commit();

                    return true;

                } else {

                    con.rollback();

                    return false;
                }
            }

        } catch (SQLException e) {

            // -------------------------------------------------
            // ROLLBACK IF ANY ERROR OCCURS
            // -------------------------------------------------
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

            // -------------------------------------------------
            // CLOSE CONNECTION
            // -------------------------------------------------
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
    // TOTAL MEMBERS
    // =========================================================
    @Override
    public int getTotalMembers() {

        return getCount(
                "SELECT COUNT(*) FROM members"
        );
    }


    // =========================================================
    // ACTIVE MEMBERS
    // =========================================================
    @Override
    public int getActiveMembers() {

        return getCount(
                "SELECT COUNT(*) "
              + "FROM members "
              + "WHERE status = 'Active'"
        );
    }


    // =========================================================
    // CURRENTLY BORROWING MEMBERS
    //
    // Counts members having:
    // Issued OR Overdue books
    // =========================================================
    @Override
    public int getBorrowingMembers() {

        return getCount(
                "SELECT COUNT(DISTINCT member_id) "
              + "FROM borrowings "
              + "WHERE status IN ('Issued', 'Overdue')"
        );
    }


    // =========================================================
    // GET BORROWED BOOK COUNT FOR ONE MEMBER
    // =========================================================
    @Override
    public int getBorrowedBookCount(int memberId) {

        String sql =
                "SELECT COUNT(*) "
              + "FROM borrowings "
              + "WHERE member_id = ? "
              + "AND status IN ('Issued', 'Overdue')";

        try (Connection con = DbUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, memberId);

            try (ResultSet rs = ps.executeQuery()) {

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
    // COMMON COUNT METHOD
    // =========================================================
    private int getCount(String sql) {

        try (Connection con = DbUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {

                return rs.getInt(1);
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return 0;
    }


    // =========================================================
    // MAP RESULTSET TO MEMBER OBJECT
    // =========================================================
    private Member mapMember(ResultSet rs) throws SQLException {

        Member member = new Member();

        member.setMemberId(
                rs.getInt("member_id")
        );

        member.setFirstName(
                rs.getString("first_name")
        );

        member.setLastName(
                rs.getString("last_name")
        );

        member.setEmail(
                rs.getString("email")
        );

        member.setPhoneNo(
                rs.getString("phone_no")
        );

        member.setStatus(
                rs.getString("status")
        );

        member.setCreatedAt(
                rs.getTimestamp("created_at")
        );

        return member;
    }
}