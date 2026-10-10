package com.lms.util;

import com.lms.dao.UserDao;
import com.lms.daoImpl.UserDaoImpl;
import com.lms.pojo.User;

public class LoginTest {

    public static void main(String[] args) {

        UserDao userDao = new UserDaoImpl();

        User user = userDao.checkLogin("admin", "admin123");

        if (user != null) {

            System.out.println("LOGIN SUCCESS");
            System.out.println("Username: " + user.getUsername());
            System.out.println("Email: " + user.getEmail());

        } else {

            System.out.println("LOGIN FAILED");
        }
    }
}