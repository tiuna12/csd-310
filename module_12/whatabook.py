# IMPORT STATEMENTS
import sys
import mysql.connector
from mysql.connector import errorcode

# DATABASE CONFIG
config = {
    "user": "whatabook_user",
    "password": "MySQL8IsGreat",
    "host": "127.0.0.1",
    "database": "whatabook",
    "raise_on_warnings": True
}

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
            show_books()
        elif choice == 2:
            show_locations()
        elif choice == 3:
            user_id = validate_user()
            if user_id:
                show_account_menu( user_id)
        elif choice == 4:
            break
        else:
            print("Invalid choice. Please select a valid option.")

    conn.close()

if __name__ == "__main__":
    main()


