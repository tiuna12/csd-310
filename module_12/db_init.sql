
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
    (1,1,'Central Store','7811 Reader Lane, Ocala, Florida');