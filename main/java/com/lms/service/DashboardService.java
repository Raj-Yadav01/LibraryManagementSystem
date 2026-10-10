package com.lms.service;

import java.util.List;
import com.lms.pojo.Borrowing;

public interface DashboardService {

    int getTotalBooks();

    int getTotalMembers();

    int getIssuedBooks();

    int getOverdueBooks();

    int getAvailableBooks();

    List<Borrowing> getRecentActivities();
}