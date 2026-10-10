package com.lms.service;

import com.lms.pojo.User;

public interface UserService {

	User checkLogin(String usernameOrEmail, String password);

}