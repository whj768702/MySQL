# 准备工作
CREATE TABLE IF NOT EXISTS t1 (m1 INT, n1 CHAR(1));
CREATE TABLE If NOT EXISTS t2 (m2 INT, n2 CHAR(1));

INSERT INTO t1 VALUES (1, 'a'), (2, 'b'), (3, 'c');
INSERT INTO t2 VALUES (2, 'b'), (3, 'c'), (4, 'd');

SELECT * FROM t1;
SELECT * FROM t2;

# 连接
/*
  1. 在一个查询语句结果集中展示多个表的信息的方式。
	2. 连接的本质是把各个表中的记录都取出来依次匹配的组合加入结果集并返回给用户。
	3. 连接查询的结果集中包含一个表中的每一条记录与另一个表中的每一条记录相互匹配的组合，这样的结果集就可以称之为笛卡尔积.
	   t1有3条记录，t2有3条记录，这两个表连接之后的笛卡尔积有3*3=9行记录。
  4. 写法
	   4.1 SELECT t1.m1, t1.n1, t2.m2, t2.n2 FROM t1, t2;
		 4.2 SELECT m1, n1, m2, n2 FROM t1, t2;
		 4.3 SELECT t1.*, t2.* FROM t1, t2;
*/
SELECT * from t1, t2;

# 连接的过程
/*
	1. 先查t1.m1>1的，有两个满足条件。
	2. 根据1的结果，再查t1.m1 = t2.m2的，有两个满足条件。
	3. 根据2的结果，再查t2.n2 < 'd'的，有两个满足条件。
*/
SELECT * FROM t1, t2 WHERE t1.m1 > 1 AND t1.m1 = t2.m2 AND t2.n2 < 'd';


# 内连接和外连接
# 两者区别:在驱动表中的记录不符合ON子句中的连接条件时不会把该记录加入到最后的结果集。
SELECT student_info.number, name, major, `subject`, score FROM student_info, student_score WHERE student_info.number = student_score.number;
/*
  20180105和20180106的同学因为某些原因没有参加考试，所以在studnet_score表中没有对应的成绩记录。
  那如果老师想查看所有同学的考试成绩，即使是缺考的同学也应该展示出来，但是到目前为止我们介绍的连接查询是无法完成这样的需求的
  驱动表中的记录即使在被驱动表中没有匹配的记录，也仍然需要加入到结果集。
*/
# 内连接
# 对于内连接的两个表，驱动表中的记录在被驱动表中找不到匹配的记录，该记录不会加入到最后的结果集。


# 外连接
/*
  1. 定义：对于外连接的两个表，驱动表中的记录即使在被驱动表中没有匹配的记录，也仍然需要加入到结果集中。
	2. 两种：
	   2.1 左外连接: 选取左侧的表为驱动表
		 2.2 右外连接: 选取右侧的表去驱动表
*/

# 内外连接的两种过滤条件
/*
  1. WHERE子句中的过滤条件
	   不论是内连接还是外连接，凡是不符合WHERE子句中的过滤条件的记录都不会被加入最后的结果集。
	2. ON子句中的过滤条件
	   对于外连接的驱动表的寄来来说，如果无法在被驱动表中找到匹配ON子句中的过滤条件的记录，那么该记录仍然会被加入到
		 结果集中，对应的被驱动表记录的各个字段使用NULL值填充。
	3. 注意: ON子句是专门为外连接驱动表中的记录在被驱动表中找不到匹配记录时应不应该把该记录加入结果集这个场景提出的。
	   所以如果把ON子句放到内连接中，MySQL会把它和WHERE子句一样对待。
		 也就是说：内连接中的WHERE子句和ON子句是等价的。
	4. 一般情况下，我们都把只涉及单表的过滤条件放到WHERE子句中，把涉及两表的过滤条件都放到ON子句中，
	   我们也一般把放到ON子句中的过滤条件也称之为连接条件。
*/

# 左外连接
# 语法：SELECT * FROM table1 LEFT [OUTER] JOIN table2 ON 连接条件 [WHERE  普通过滤条件];
# 放在左边的表称之为外表或驱动表，右边的称之为内表或被驱动表。
SELECT student_info.number, name, major, `subject`, score FROM student_info xLEFT JOIN student_score ON student_info.number = student_score.number;

# 右外连接
# 语法：SELECT * FROM table1 RIGHT [OUTER] JOIN table2 ON 连接条件 [WHERE  普通过滤条件];
# 与左外连接相反，驱动表是右边的表，被驱动表示左边的表。


# 内连接
# 由于在内连接中ON子句和WHERE子句是等价的，所以内连接中不要求强制写明ON子句。
/*
  语法(推荐2写法)
	   1. SELECT * FROM table1 JOIN table2;
		 2. SELECT * FROM table1 INNER JOIN table2;
		 3. SELECT * FROM table1 CROSS JOIN table2;
		 4. SELECT * FROM table1, table2;
*/

SELECT * FROM t1 INNER JOIN t2 ON t1.m1 = t2.m2;
SELECT * FROM t1 LEFT JOIN t2 ON t1.m1 = t2.m2;
SELECT * FROM t1 RIGHT JOIN t2 ON t1.m1 = t2.m2;


# 多表连接
CREATE TABLE IF NOT EXISTS t3(m3 INT, n3 CHAR(1));
INSERT INTO t3 VALUES(3, 'c'), (4, 'd'), (5, 'e');
SELECT * FROM t1 INNER JOIN t2 INNER JOIN t3 WHERE t1.m1 = t2.m2 AND t1.m1 = t3.m3;


# 自连接
# 查看与'史珍香'相同专业的学生有哪些
SELECT s2.number, s2.name, s2.major FROM student_info AS s1 INNER JOIN student_info AS s2 WHERE s1.major = s2.major AND s1.name = '史珍香';

# 连接查询与子查询的转换
SELECT * FROM student_score WHERE number IN (SELECT number FROM student_info WHERE major = '计算机科学与工程');
SELECT s2.* FROM student_info AS s1 INNER JOIN student_score AS s2 WHERE s1.number = s2.number AND s1.major = '计算机科学与工程';
