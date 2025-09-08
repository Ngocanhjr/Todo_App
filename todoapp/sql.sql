-- Initialize database with sample data

CREATE DATABASE IF NOT EXISTS todoappdb;

USE todoappdb;

-- Insert some sample data if tables exist
INSERT IGNORE INTO tbl_todos(title, completed)
VALUES("first todo", true);

INSERT IGNORE INTO tbl_todos(title, completed)
VALUES("demo", false);