package com.lms.serviceImpl;

import java.util.List;

import com.lms.dao.BorrowingDao;
import com.lms.daoImpl.BorrowingDaoImpl;
import com.lms.pojo.Borrowing;
import com.lms.service.BorrowingService;

public class BorrowingServiceImpl implements BorrowingService {

    private final BorrowingDao borrowingDao =
            new BorrowingDaoImpl();


    // =========================================================
    // ISSUE BOOK
    // =========================================================

    @Override
    public boolean issueBook(Borrowing borrowing) {

        return borrowingDao.issueBook(borrowing);
    }


    // =========================================================
    // GET ALL BORROWINGS
    // =========================================================

    @Override
    public List<Borrowing> getAllBorrowings() {

        return borrowingDao.getAllBorrowings();
    }


    // =========================================================
    // GET BORROWING BY ID
    // =========================================================

    @Override
    public Borrowing getBorrowingById(int borrowingId) {

        return borrowingDao.getBorrowingById(
                borrowingId
        );
    }


    // =========================================================
    // GET ACTIVE BORROWINGS
    // =========================================================

    @Override
    public List<Borrowing> getActiveBorrowings() {

        return borrowingDao.getActiveBorrowings();
    }


    // =========================================================
    // GET MEMBER BORROWING HISTORY
    // =========================================================

    @Override
    public List<Borrowing> getBorrowingsByMemberId(
            int memberId) {

        return borrowingDao.getBorrowingsByMemberId(
                memberId
        );
    }


    // =========================================================
    // RETURN BOOK
    // =========================================================

    @Override
    public boolean returnBook(
            int borrowingId,
            java.sql.Date returnDate) {

        return borrowingDao.returnBook(
                borrowingId,
                returnDate
        );
    }


    // =========================================================
    // ACTIVE BORROWING COUNT
    // =========================================================

    @Override
    public int getActiveBorrowingCount() {

        return borrowingDao.getActiveBorrowingCount();
    }


    // =========================================================
    // MEMBER ACTIVE BORROWING COUNT
    // =========================================================

    @Override
    public int getMemberActiveBorrowingCount(
            int memberId) {

        return borrowingDao.getMemberActiveBorrowingCount(
                memberId
        );
    }
    
    @Override
    public List<Borrowing> getRecentActivities() {

        return borrowingDao.getRecentActivities();
    }
    
    @Override
    public List<Borrowing> getActiveBorrowingsByMemberId(int memberId) {
        return borrowingDao.getActiveBorrowingsByMemberId(memberId);
    }
    
    @Override
    public void updateOverdueFines() {

        borrowingDao.updateOverdueFines();

    }
}