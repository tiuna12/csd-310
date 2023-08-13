
import sys
import mysql.connector
f-- Active: 1689739254286@@127.0.0.1@3306@whatabook

CREATE USER 'whatabook_user'@'3306' IDENTIFIED WITH mysql_native_password BY 'MySQL8IsGreat!'

grant all privileges on whatabook. * to 'whatabook_user'@'3306'


CREATE TABLE User(
    user_id INT PRIMARY KEY,
    first_name VARCHAR (50),
    last_name VARCHAR (50),
    email VARCHAR (100)
);

CREATE TABLE Book(
    book_id INT PRIMARY KEY,
    book_name VARCHAR (200),
    author VARCHAR (200),
    details TEXT
);

CREATE TABlE Wishlist(
    wishlist_id INT PRIMARY KEY,
    user_id INT,
    book_id INT,
    FOREIGN KEY (user_id) REFERENCES User(user_id),
    FOREIGN KEY (book_id) REFERENCES Book(book_id)
);

CREATE TABLE WhatABook(
    whatabook_id INT PRIMARY KEY,
    name VARCHAR(200)
);

CREATE TABLE Location(
    location_id INT PRIMARY KEY,
    whatabook_id INT,
    location_name VARCHAR(200),
    address TEXT,
    FOREIGN KEY (whatabook_id) REFERENCES WhatABook(whatabook_id)
);

INSERT INTO User (user_id, first_name, last_name, email)
VALUES
    (1,'Travis','Smith','t.smith@yahoo.com'),
    (2,'Kevin','Love','love@gmail.com'),
    (3,'ALice','Johnson','alice@yahoo.com');

INSERT INTO Book (book_id, book_name, author, details)
VALUES
    (1,'Self Care','Lola Love','tips, quotes and journal topics to help one focus on self'),
    (2,'Walking Free','Thomas Eve','a guide on letting go and moving on'),
    (3,'Business Data','Julia Pranko','business data for beginers'),
    (4,'The Psychology Of Money','Morgan Housel','gives insight into how and why consumers interact with money'),
    (5,'Win Your Inner Battles','Darius Foroux','help one to destroy fear and live life with a sense of purpose'),
    (6,'Good Vibes, Good Life','Vex King','explores ways to unlock yout true potential by loving'),
    (7,'The Big Question Of Life','Om Swami','an investigation into one mans look into the greatest questions in life'),
    (8,'100 Quotes That Will CHange Your Life','Library Mindset','wonderful quotes that will help your mood, motivate'),
    (9,'The Subtle Art Of Not Giving A F*ck','Mark Manson','challenges the conventions of self help');

INSERT INTO wishlist (wishlist_id,user_id,book_id)
VALUES
    (1,1,5),
    (2,2,8),
    (3,3,6);

INSERT INTO whatabook (whatabook_id, name)
VALUES
    (1,'WhatABook Store');

INSERT INTO location (location_id, whatabook_id, location_name, address)
VALUES
    (1,1,'Central Store','7811 Reader Lane, Ocala, Florida');rom mysql.connector import errorcode

# DATABASE CONFIG
config = {
    "user": "whatabook_user",
    "password": "MySQL8IsGreat",
    "host": "127.0.0.1",
    "database": "whatabook",
    "raise_on_warnings": True
}
# Connect to the database (or create if not exists)
conn = sqlite3.connect('whatabook.db')
cursor = conn.cursor()

# Create tables
cursor.execute('''
CREATE TABLE IF NOT EXISTS users (
    user_id INTEGER PRIMARY KEY,
    first_name TEXT,
    last_name TEXT,
    email TEXT
)
''')

cursor.execute('''
CREATE TABLE IF NOT EXISTS books (
    book_id INTEGER PRIMARY KEY,
    book_name TEXT,
    author TEXT,
    details TEXT
)
''')

cursor.execute('''
CREATE TABLE IF NOT EXISTS locations (
    location_id INTEGER PRIMARY KEY,
    location_name TEXT,
    address TEXT
)
''')

cursor.execute('''
CREATE TABLE IF NOT EXISTS wishlist (
    user_id INTEGER,
    book_id INTEGER,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id)
)
''')

conn.commit()

def show_menu():
    print("Menu:")
    print("1. View Books")
    print("2. View Store Locations")
    print("3. My Account")
    print("4. Exit Program")

def show_books(cursor):
    cursor.execute('SELECT * FROM books')
    books = cursor.fetchall()
    for book in books:
        print(f"ID: {book[0]}, Name: {book[1]}, Author: {book[2]}, Details: {book[3]}")

def show_locations(cursor):
    cursor.execute('SELECT * FROM locations')
    locations = cursor.fetchall()
    for location in locations:
        print(f"ID: {location[0]}, Name: {location[1]}, Address: {location[2]}")

def validate_user(cursor):
    user_id = int(input("Enter your user ID: "))
    cursor.execute('SELECT * FROM users WHERE user_id = ?', (user_id,))
    user = cursor.fetchone()
    if user:
        return user_id
    else:
        print("Invalid user ID.")
        return None

def show_wishlist(cursor, user_id):
    cursor.execute('''
    SELECT b.book_id, b.book_name, b.author, b.details
    FROM books b
    INNER JOIN wishlist w ON b.book_id = w.book_id
    WHERE w.user_id = ?
    ''', (user_id,))
    wishlist = cursor.fetchall()
    for book in wishlist:
        print(f"ID: {book[0]}, Name: {book[1]}, Author: {book[2]}, Details: {book[3]}")

def show_books_to_add(cursor, user_id):
    cursor.execute('''
    SELECT book_id, book_name, author, details
    FROM books
    WHERE book_id NOT IN (SELECT book_id FROM wishlist WHERE user_id = ?)
    ''', (user_id,))
    available_books = cursor.fetchall()
    for book in available_books:
        print(f"ID: {book[0]}, Name: {book[1]}, Author: {book[2]}, Details: {book[3]}")

def main():
    while True:
        show_menu()
        choice = int(input("Select an option: "))
        
        if choice == 1:
            show_books(cursor)
        elif choice == 2:
            show_locations(cursor)
        elif choice == 3:
            user_id = validate_user(cursor)
            if user_id:
                show_account_menu(cursor, user_id)
        elif choice == 4:
            break
        else:
            print("Invalid choice. Please select a valid option.")

    conn.close()

if __name__ == "__main__":
    main()

