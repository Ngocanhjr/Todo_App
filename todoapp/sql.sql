CREATE DATABASE todoappdb;

use todoappdb;

select * from tbl_todos;

insert into tbl_todos(title, completed)
values("first todo", true);

insert into tbl_todos(title, completed)
values("second todo", false);

delete from tbl_todos where id = 2