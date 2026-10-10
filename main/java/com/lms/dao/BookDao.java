package com.lms.dao;

import java.util.List;
import com.lms.pojo.Book;

public interface BookDao {

    // Database se sabhi books lana
    List<Book> getAllBooks();

    // Book ID se book search karna
    Book getBookById(int bookId);

    // Nayi book database mein add karna
    boolean addBook(Book book);

    // Book ko update karna
    boolean updateBook(Book book);

    // Book delete karna
    boolean deleteBook(int bookId);

    // Total books ki sankhya
    int getTotalBooks();

    // Available copies ki sankhya
    int getAvailableCopies();

    // Issued copies ki sankhya
    int getIssuedCopies();
}