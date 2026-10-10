package com.lms.serviceImpl;

import com.lms.dao.UserDao;
import com.lms.daoImpl.UserDaoImpl;
import com.lms.pojo.User;
import com.lms.service.UserService;

public class UserServiceImpl implements UserService {

    private final UserDao userDao = new UserDaoImpl();

    @Override
    public User checkLogin(String usernameOrEmail, String password) {
        return userDao.checkLogin(usernameOrEmail, password);
    }
}