package com.lms.daoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.lms.dao.DashboardDao;
import com.lms.util.DbUtil;

public class DashboardDaoImpl implements DashboardDao {

    @Override
    public int getTotalBooks() {
        return getCount("SELECT COUNT(*) FROM books");
    }

    @Override
    public int getTotalMembers() {
        return getCount("SELECT COUNT(*) FROM members");
    }

    @Override
    public int getIssuedBooks() {
        return getCount(
            "SELECT COUNT(*) FROM borrowings WHERE status = 'Issued'"
        );
    }

    @Override
    public int getOverdueBooks() {
        return getCount(
            "SELECT COUNT(*) FROM borrowings WHERE status = 'Overdue'"
        );
    }

    private int getCount(String sql) {

        int count = 0;

        try (
            Connection con = DbUtil.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery()
        ) {

            if (rs.next()) {
                count = rs.getInt(1);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return count;
    }
    
    @Override
    public int getAvailableBooks() {
        return getCount("SELECT COALESCE(SUM(available_copies), 0) FROM books");
    }
    
}