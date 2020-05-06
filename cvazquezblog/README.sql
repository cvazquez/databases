CREATE DATABASE cvazquezblog;

create user nodeuser@localhost identified WITH mysql_native_password by '...';
GRANT SELECT, INSERT, UPDATE on cvazquezblog.* to nodeuser@localhost;