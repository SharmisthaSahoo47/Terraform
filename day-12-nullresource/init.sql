CREATE DATABASE IF NOT EXISTS demodb;

SHOW DATABASES;

CREATE TABLE demodb.persons (
    PersonID int,
    LastName varchar(255),
    FirstName varchar(255),
    Address varchar(255),
    City varchar(255)
);
