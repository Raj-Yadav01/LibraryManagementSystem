package com.lms.dao;

import com.lms.pojo.User;

public interface UserDao {

    User checkLogin(String usernameOrEmail, String password);

}