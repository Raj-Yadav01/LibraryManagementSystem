package com.lms.dao;

import java.util.List;

import com.lms.pojo.Borrowing;

public interface BorrowingDao {

    // Issue a book
    boolean issueBook(Borrowing borrowing);

    // Get all borrowing records
    List<Borrowing> getAllBorrowings();

    // Get borrowing record by ID
    Borrowing getBorrowingById(int borrowingId);

    // Get active borrowing records
    List<Borrowing> getActiveBorrowings();

    // Get borrowing history of a member
    List<Borrowing> getBorrowingsByMemberId(int memberId);
    
    List<Borrowing> getActiveBorrowingsByMemberId(int memberId);

    // Return a book
    boolean returnBook(
    	    int borrowingId,
    	    java.sql.Date returnDate
    	);

    // Count currently issued/overdue books
    int getActiveBorrowingCount();

    // Check whether member currently has a book
    int getMemberActiveBorrowingCount(int memberId);
    
    List<Borrowing> getRecentActivities();
    
    void updateOverdueFines();
    
    
}