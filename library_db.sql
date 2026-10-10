CREATE DATABASE library_db;


USE library_db;

CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100),
    email VARCHAR(150) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    phone_no VARCHAR(20)
);

CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(250) NOT NULL,
    author VARCHAR(250) NOT NULL,
    category VARCHAR(120),
    isbn VARCHAR(30),
    publisher VARCHAR(250),
    total_pages INT,
    total_copies INT NOT NULL,
    available_copies INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100),
    email VARCHAR(150) NOT NULL UNIQUE,
    phone_no VARCHAR(20) NOT NULL,
    password VARCHAR(255) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'Active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE borrowings (
    borrowing_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT NOT NULL,
    book_id INT NOT NULL,
    issue_date DATE NOT NULL,
    due_date DATE NOT NULL,
    return_date DATE,
    status VARCHAR(20) NOT NULL DEFAULT 'Issued',
    fine DECIMAL(10,2) DEFAULT 0.00,
    notes VARCHAR(500),

    FOREIGN KEY (member_id) REFERENCES members(member_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);

USE library_db;

INSERT INTO books
(title, author, category, isbn, publisher, total_copies, available_copies)
VALUES
('The Great Gatsby',
 'F. Scott Fitzgerald',
 'Fiction',
 '9780743273565',
 'Scribner',
 10,
 8),

('Clean Code',
 'Robert C. Martin',
 'Technology',
 '9780132350884',
 'Prentice Hall',
 8,
 6),

('Java: The Complete Reference',
 'Herbert Schildt',
 'Programming',
 '9781260440232',
 'McGraw Hill',
 12,
 9),

('Database System Concepts',
 'Abraham Silberschatz',
 'Database',
 '9780073523323',
 'McGraw Hill',
 7,
 5);
 
 
 USE library_db;

INSERT INTO books
(title, author, category, isbn, publisher, total_pages, total_copies, available_copies)
VALUES
('The Great Gatsby',
 'F. Scott Fitzgerald',
 'Fiction',
 '9780743273565',
 'Scribner',
 180,
 10,
 8),

('Clean Code',
 'Robert C. Martin',
 'Technology',
 '9780132350884',
 'Prentice Hall',
 464,
 8,
 6),

('Java: The Complete Reference',
 'Herbert Schildt',
 'Programming',
 '9781260440232',
 'McGraw Hill',
 1248,
 12,
 9),

('Database System Concepts',
 'Abraham Silberschatz',
 'Database',
 '9780073523323',
 'McGraw Hill',
 1376,
 7,
 5);
 
 
 USE library_db;

INSERT INTO members
(first_name, last_name, email, phone_no, password, status)
VALUES
('Raj',
 'Yadav',
 'raj@gmail.com',
 '9876543210',
 '123456',
 'Active'),

('Aman',
 'Kumar',
 'aman@gmail.com',
 '9876543211',
 '123456',
 'Active'),

('Priya',
 'Sharma',
 'priya@gmail.com',
 '9876543212',
 '123456',
 'Active'),

('Vikash',
 'Singh',
 'vikash@gmail.com',
 '9876543213',
 '123456',
 'Inactive');
 
 
 USE library_db;

INSERT INTO borrowings
(member_id, book_id, issue_date, due_date, return_date, status, fine, notes)
VALUES
(1, 1, '2026-09-20', '2026-09-27', NULL, 'Issued', 0.00, NULL),

(2, 2, '2026-09-10', '2026-09-17', '2026-09-16', 'Returned', 0.00, 'Returned on time'),

(3, 3, '2026-09-05', '2026-09-12', NULL, 'Overdue', 50.00, 'Book not returned'),

(4, 4, '2026-08-20', '2026-08-27', '2026-08-26', 'Returned', 0.00, 'Returned on time');


USE library_db;

INSERT INTO users
(first_name, last_name, email, password, phone_no)
VALUES
('Admin',
 NULL,
 'admin@gmail.com',
 'admin123',
 '9876543210');
 
 
 USE library_db;

SELECT * FROM users;


USE library_db;

DELETE FROM books
WHERE book_id IN (5, 6, 7, 8);

SELECT * FROM books;

USE library_db;

SELECT * FROM members;

USE library_db;

SELECT * FROM borrowings;

USE library_db;

ALTER TABLE users
ADD COLUMN username VARCHAR(100) NOT NULL UNIQUE AFTER user_id;

UPDATE users
SET username = 'admin'
WHERE email = 'admin@gmail.com';

SELECT * FROM users;

USE library_db;

SELECT *
FROM users
WHERE (username = 'admin' OR email = 'admin')
AND password = 'admin123';

USE library_db;

SELECT * FROM users;

DESCRIBE borrowings;

USE library_db;

DESCRIBE books;


USE library_db;

SELECT book_id, title, total_pages
FROM books;

USE library_db;

UPDATE books
SET total_pages = CASE
    WHEN title = 'The Great Gatsby' THEN 180
    WHEN title = 'Clean Code' THEN 464
    WHEN title = 'Java: The Complete Reference' THEN 1248
    WHEN title = 'Database System Concepts' THEN 1376
    ELSE total_pages
END
WHERE title IN (
    'The Great Gatsby',
    'Clean Code',
    'Java: The Complete Reference',
    'Database System Concepts'
);

SELECT book_id, title, total_pages
FROM books;

USE library_db;

UPDATE books
SET total_pages = CASE
    WHEN title = 'The Great Gatsby' THEN 180
    WHEN title = 'Clean Code' THEN 464
    WHEN title = 'Java: The Complete Reference' THEN 1248
    WHEN title = 'Database System Concepts' THEN 1376
    ELSE total_pages
END
WHERE title IN (
    'The Great Gatsby',
    'Clean Code',
    'Java: The Complete Reference',
    'Database System Concepts'
);

SELECT book_id, title, total_pages FROM books;

USE library_db;

UPDATE books
SET total_pages = CASE
    WHEN title = 'The Great Gatsby' THEN 180
    WHEN title = 'Clean Code' THEN 464
    WHEN title = 'Java: The Complete Reference' THEN 1248
    WHEN title = 'Database System Concepts' THEN 1376
    ELSE total_pages
END
WHERE book_id IN (1, 2, 3, 4);

SELECT book_id, title, total_pages
FROM books
ORDER BY book_id;

USE library_db;

SELECT * FROM books;

DESCRIBE books;

ALTER TABLE books
ADD COLUMN status VARCHAR(20) NOT NULL DEFAULT 'Active';

SELECT book_id, title, status
FROM books
WHERE title = 'Python Programming';

SELECT book_id, title, status
FROM books
ORDER BY book_id DESC;

SELECT book_id, title, status, total_copies, available_copies
FROM books
WHERE title = 'Python Programming';

USE library_db;

DESCRIBE members;

USE library_db;

SELECT borrowing_id, member_id, book_id, issue_date,
       due_date, return_date, status
FROM borrowings;


SELECT * FROM borrowings
ORDER BY borrowing_id DESC;