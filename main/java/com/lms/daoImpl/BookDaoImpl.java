package com.lms.daoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.lms.dao.BookDao;
import com.lms.pojo.Book;
import com.lms.util.DbUtil;

public class BookDaoImpl implements BookDao {

    // Get all books
    @Override
    public List<Book> getAllBooks() {

        List<Book> books = new ArrayList<>();

        String sql = "SELECT * FROM books WHERE status = 'Active' ORDER BY book_id DESC";

        try (Connection con = DbUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                books.add(mapBook(rs));
            }

            System.out.println(
                "Books fetched from database: " + books.size()
            );

        } catch (SQLException e) {
            System.err.println("Error fetching books!");
            System.err.println("SQL Error: " + e.getMessage());
            e.printStackTrace();
        }

        return books;
    }

    // Get book by ID
    @Override
    public Book getBookById(int bookId) {

        String sql = "SELECT book_id, title, author, category, isbn, "
                   + "publisher, total_pages, total_copies, available_copies "
                   + "FROM books WHERE book_id = ? AND status = 'Active'";

        try (Connection con = DbUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, bookId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapBook(rs);
                }
            }

        } catch (SQLException e) {
            System.err.println("Error fetching book ID: " + bookId);
            e.printStackTrace();
        }

        return null;
    }

    // Add a new book
    @Override
    public boolean addBook(Book book) {

    	String sql = "INSERT INTO books "
    	           + "(title, author, category, isbn, publisher, "
    	           + "total_pages, total_copies, available_copies, status) "
    	           + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, 'Active')";

        try (Connection con = DbUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, book.getTitle());
            ps.setString(2, book.getAuthor());
            ps.setString(3, book.getCategory());
            ps.setString(4, book.getIsbn());
            ps.setString(5, book.getPublisher());

            if (book.getTotalPages() > 0) {
                ps.setInt(6, book.getTotalPages());
            } else {
                ps.setNull(6, java.sql.Types.INTEGER);
            }

            ps.setInt(7, book.getTotalCopies());
            ps.setInt(8, book.getAvailableCopies());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("Error adding book!");
            e.printStackTrace();
        }

        return false;
    }

    // Update an existing book
    @Override
    public boolean updateBook(Book book) {

        String sql = "UPDATE books SET title = ?, author = ?, "
                   + "category = ?, isbn = ?, publisher = ?, "
                   + "total_pages = ?, total_copies = ?, "
                   + "available_copies = ? WHERE book_id = ?";

        try (Connection con = DbUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, book.getTitle());
            ps.setString(2, book.getAuthor());
            ps.setString(3, book.getCategory());
            ps.setString(4, book.getIsbn());
            ps.setString(5, book.getPublisher());

            if (book.getTotalPages() > 0) {
                ps.setInt(6, book.getTotalPages());
            } else {
                ps.setNull(6, java.sql.Types.INTEGER);
            }

            ps.setInt(7, book.getTotalCopies());
            ps.setInt(8, book.getAvailableCopies());
            ps.setInt(9, book.getBookId());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println(
                "Error updating book ID: " + book.getBookId()
            );
            e.printStackTrace();
        }

        return false;
    }

    // Delete a book
    
    @Override
    public boolean deleteBook(int bookId) {

    	String sql = "UPDATE books SET status = 'Inactive' "
    	           + "WHERE book_id = ? AND status = 'Active' "
    	           + "AND NOT EXISTS "
    	           + "(SELECT 1 FROM borrowings WHERE book_id = ?)";
    	
    	
        try (Connection connection = DbUtil.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setInt(1, bookId);
            ps.setInt(2, bookId);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Get total book records
    @Override
    public int getTotalBooks() {

        String sql = "SELECT COUNT(*) FROM books WHERE status = 'Active'";

        try (Connection connection = DbUtil.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }

    // Get total issued copies
    
    @Override
    public int getIssuedCopies() {
        return getCount(
            "SELECT COALESCE(SUM(total_copies - available_copies), 0) "
          + "FROM books WHERE status = 'Active'"
        );
    }
    
    
    // get available copies...
    
    @Override
    public int getAvailableCopies() {
        return getCount(
            "SELECT COALESCE(SUM(available_copies), 0) "
          + "FROM books WHERE status = 'Active'"
        );
    }
    
    // Common method for statistics
    private int getCount(String sql) {

        try (Connection con = DbUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (SQLException e) {
            System.err.println("Error fetching book statistics!");
            e.printStackTrace();
        }

        return 0;
    }

    // Convert ResultSet into Book object
    private Book mapBook(ResultSet rs) throws SQLException {

        Book book = new Book();

        book.setBookId(rs.getInt("book_id"));
        book.setTitle(rs.getString("title"));
        book.setAuthor(rs.getString("author"));
        book.setCategory(rs.getString("category"));
        book.setIsbn(rs.getString("isbn"));
        book.setPublisher(rs.getString("publisher"));
        book.setTotalPages(rs.getInt("total_pages"));
        book.setTotalCopies(rs.getInt("total_copies"));
        book.setAvailableCopies(rs.getInt("available_copies"));

        return book;
    }
}