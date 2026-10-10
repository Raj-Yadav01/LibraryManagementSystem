package com.lms.dao;

public interface DashboardDao {

    int getTotalBooks();

    int getTotalMembers();

    int getIssuedBooks();

    int getOverdueBooks();
    
    int getAvailableBooks();
}