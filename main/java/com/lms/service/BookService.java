package com.lms.service;

import java.util.List;
import com.lms.pojo.Book;

public interface BookService {

    List<Book> getAllBooks();

    Book getBookById(int bookId);

    boolean addBook(Book book);

    boolean updateBook(Book book);

    boolean deleteBook(int bookId);

    int getTotalBooks();

    int getAvailableCopies();

    int getIssuedCopies();
}