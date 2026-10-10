package com.lms.service;

import java.util.List;

import com.lms.pojo.Borrowing;

public interface BorrowingService {

    // Issue a book
    boolean issueBook(Borrowing borrowing);

    // Get all borrowing records
    List<Borrowing> getAllBorrowings();

    // Get borrowing by ID
    Borrowing getBorrowingById(int borrowingId);

    // Get currently active borrowings
    List<Borrowing> getActiveBorrowings();

    // Get member borrowing history
    List<Borrowing> getBorrowingsByMemberId(int memberId);
    
    List<Borrowing> getActiveBorrowingsByMemberId(int memberId);

    // Return a book
    boolean returnBook(
    	    int borrowingId,
    	    java.sql.Date returnDate
    );

    // Count active borrowings
    int getActiveBorrowingCount();

    // Count member's active borrowings
    int getMemberActiveBorrowingCount(int memberId);
    
    List<Borrowing> getRecentActivities();
    
    void updateOverdueFines();
}