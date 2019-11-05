# 标量子查询
/*
  1. ()中查询语句被称为子查询或内层查询
	2. 所有子查询必须使用()扩起来，否则是非法的
*/
SELECT * FROM student_score WHERE number = (SELECT number FROM student_info WHERE name = '杜琦燕');

# 列子查询
SELECT * FROM student_score WHERE number IN (SELECT number FROM student_info WHERE major = '计算机科学与工程');

# 行子查询
/*
	1. 子查询的结果集中最多包含一条记录，而且这条记录中有超过一个列的数据，那么这个子查询就可以被称之为行子查询。
	2. 在想要得到标量子查询或者行子查询，但又不能保证子查询的结果集只有一条记录时，应该使用LIMIT 1子句来限制记录数量。
*/
SELECT * FROM student_score WHERE (number, `subject`) = (SELECT number, '母猪的产后护理' FROM student_info LIMIT 1);

# 表子查询
/*
  1. 如果子查询结果集中包含多行多列，那么这个子查询也可以被称之为表子查询。
*/
SELECT * FROM student_score WHERE (number, `subject`) IN (SELECT number, '母猪的产后护理' FROM student_info WHERE major = '计算机科学与工程');

# 外层查询并不关心子查询中的结果是什么，而只关心子查询的结果集是不是空集，这时可以用下边两个操作符
/*
|   操作符   |          示例           |                描述                |
| :--------: | :---------------------: | :--------------------------------: |
|   EXISTS   |   EXISTS (SELECT ...)   | 当子查询结果集不是空集时表达式为真 |
| NOT EXISTS | NOT EXISTS (SELECT ...) |  当子查询结果集是空集时表达式为真  |
*/
SELECT * FROM student_score WHERE EXISTS (SELECT * FROM student_info WHERE number = 20180108);
SELECT * FROM student_score WHERE NOT EXISTS (SELECT * FROM student_info WHERE number = 20180108);

# 不相关子查询和相关子查询
/*
  1. 子查询和外层查询没有依赖关系，这种子查询称为不相关子查询。
	2. 子查询的语句中引用到外层查询的值，这样的话子查询不能当做一个独立的语句去执行，这种子查询被称为相关子查询。
*/
# 不相关子查询
SELECT * FROM student_score WHERE number = (SELECT number FROM student_info WHERE name = '杜琦燕');
# 相关子查询。查看一些学生的基本信息，但是前提是这些学生在student_score表中有成绩记录
SELECT number, name, id_number, major FROM student_info WHERE EXISTS (SELECT * FROM student_score WHERE student_score.number = student_info.number);


# 对同一个表的子查询
/*
  1. 聚集函数不能放到WHERE子句中
*/
SELECT * FROM student_score WHERE subject = '母猪的产后护理' AND score > AVG(score); # 1111 - Invalid use of group function
# 先使用子查询统计出'母猪产后护理'这门课的平均分，然后再到外层查询中使用这个平均分组成的表达式来作为搜索条件去查询大于平均分的记录。
SELECT * FROM student_score WHERE `subject` = '母猪的产后护理' AND score > (SELECT AVG(score) FROM student_score WHERE `subject` = '母猪的产后护理');