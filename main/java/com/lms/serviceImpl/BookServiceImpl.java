package com.lms.serviceImpl;

import java.util.List;

import com.lms.dao.BookDao;
import com.lms.daoImpl.BookDaoImpl;
import com.lms.pojo.Book;
import com.lms.service.BookService;

public class BookServiceImpl implements BookService {

    private final BookDao bookDao = new BookDaoImpl();

    @Override
    public List<Book> getAllBooks() {
        return bookDao.getAllBooks();
    }

    @Override
    public Book getBookById(int bookId) {
        return bookDao.getBookById(bookId);
    }

    @Override
    public boolean addBook(Book book) {
        return bookDao.addBook(book);
    }

    @Override
    public boolean updateBook(Book book) {
        return bookDao.updateBook(book);
    }

    @Override
    public boolean deleteBook(int bookId) {
        return bookDao.deleteBook(bookId);
    }

    @Override
    public int getTotalBooks() {
        return bookDao.getTotalBooks();
    }

    @Override
    public int getAvailableCopies() {
        return bookDao.getAvailableCopies();
    }

    @Override
    public int getIssuedCopies() {
        return bookDao.getIssuedCopies();
    }
}