package com.lms.daoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.lms.dao.UserDao;
import com.lms.pojo.User;
import com.lms.util.DbUtil;

public class UserDaoImpl implements UserDao {

    @Override
    public User checkLogin(String usernameOrEmail, String password) {

        User user = null;
        
        System.out.println("===== DAO LOGIN DEBUG =====");
        System.out.println("Username/Email: " + usernameOrEmail);

        String sql = "SELECT * FROM users "
                   + "WHERE (username = ? OR email = ?) "
                   + "AND password = ?";

        try (Connection con = DbUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            // Username ya email — dono ke liye same input
            ps.setString(1, usernameOrEmail);
            ps.setString(2, usernameOrEmail);

            // Password
            ps.setString(3, password);

            try (ResultSet rs = ps.executeQuery()) {

            	if (rs.next()) {

            	    System.out.println("DAO: User record found");

            	    user = new User();

            	    user.setUserId(rs.getInt("user_id"));
            	    user.setUsername(rs.getString("username"));
            	    user.setFirstName(rs.getString("first_name"));
            	    user.setLastName(rs.getString("last_name"));
            	    user.setEmail(rs.getString("email"));
            	    user.setPassword(rs.getString("password"));
            	    user.setPhoneNo(rs.getString("phone_no"));

            	} else {
            	    System.out.println("DAO: No matching user found");
            	}
            }

        } catch (Exception e) {
            System.out.println("DAO: Database error");
            e.printStackTrace();
        }

        return user;
    }
}