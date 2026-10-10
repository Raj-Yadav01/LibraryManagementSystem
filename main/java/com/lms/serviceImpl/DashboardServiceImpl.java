package com.lms.serviceImpl;

import java.util.List;

import com.lms.dao.DashboardDao;
import com.lms.daoImpl.DashboardDaoImpl;
import com.lms.daoImpl.BorrowingDaoImpl;
import com.lms.pojo.Borrowing;
import com.lms.service.DashboardService;
import com.lms.dao.BorrowingDao;

public class DashboardServiceImpl implements DashboardService {

    private final DashboardDao dashboardDao = new DashboardDaoImpl();
    private final BorrowingDao borrowingDao = new BorrowingDaoImpl();

    @Override
    public int getTotalBooks() {
        return dashboardDao.getTotalBooks();
    }

    @Override
    public int getTotalMembers() {
        return dashboardDao.getTotalMembers();
    }

    @Override
    public int getIssuedBooks() {
        return dashboardDao.getIssuedBooks();
    }

    @Override
    public int getOverdueBooks() {
        return dashboardDao.getOverdueBooks();
    }

    @Override
    public int getAvailableBooks() {
        return dashboardDao.getAvailableBooks();
    }

    @Override
    public List<Borrowing> getRecentActivities() {
        return borrowingDao.getRecentActivities();
    }
}