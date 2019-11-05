# 简单搜索条件 WHERE
/*
操作符    |    示例          |   描述
---------|-----------------|---------
   =     |    a = b        | a等于b
-------------------------------------
 <>或!=  | a<>b a!=b       | a不等于b
-------------------------------------
   <     |    a < b        | a小于b
-------------------------------------
   >     |    a > b        | a大于b
-------------------------------------
   <=    |    a <= b       | a小于或等于b
-------------------------------------
   >=    |    a >= b       | a大于或等于b
-------------------------------------
 BETWEEN |a BETWEEN b AND c| 满足b<=a<c
-------------------------------------
NOT BETWEEN |a NOT BETWEEN b AND c | 不满足b<=a<=c
-------------------------------------
*/
SELECT number, name, id_number, major FROM student_info WHERE `name` = '范剑';
SELECT number, name, id_number, major FROM student_info WHERE number BETWEEN 20180102 AND 20180104;

# 匹配列表中的一个或多个元素值
/*
操作符    |      示例             |   描述
--------------------------------------------------------
   IN    |   a IN (b1, b2,...)   | a是b1,b2,...中的某一个
--------------------------------------------------------
 NOT IN  | a NOT IN (b1, b2,...) | a不是b1,b2,...中任意一个
--------------------------------------------------------
*/
SELECT number, name, id_number, major FROM student_info WHERE major IN('软件工程', '飞行器设计');
SELECT number, name, id_number, major FROM student_info WHERE major NOT IN('软件工程', '飞行器设计');

# 匹配NULL值
# 强调： 不能直接使用普通的操作符来与NULL值进行比较，必须使用IS NULL或者IS NOT NULL
/*
|   操作符    |     示例      |     描述      |
| :---------: | :-----------: | :-----------: |
|   IS NULL   |   a IS NULL   |  a的值是NULL  |
| IS NOT NULL | a IS NOT NULL | a的值不是NULL |
*/
SELECT number, name, major FROM student_info WHERE name IS NULL;
SELECT number, name, major FROM student_info WHERE name IS NOT NULL;

# 多个搜索条件的查询
# AND操作符
SELECT * FROM student_score WHERE `subject`='母猪的产后护理' AND score > 75;
SELECT * FROM student_score WHERE `subject`='母猪的产后护理' AND score > 75 AND number !=20180101;
# OR操作符
SELECT * FROM student_score WHERE score > 95 OR score < 55;
SELECT * FROM student_score WHERE score > 95 OR score < 55 OR number != 20180102;

# 更复杂的搜索条件的组合
# 强调：AND操作符的优先级高于OR操作符。
SELECT * FROM student_score WHERE score > 95 OR score < 55 AND `subject`='论萨达姆的战争准备';
SELECT * FROM student_score WHERE score > 95 OR (score < 55 AND `subject`='论萨达姆的战争准备');

# 通配符
/*
|  操作符  |     示例     |   描述   |
| :------: | :----------: | :------: |
|   LIKE   |   a LIKE b   |  a匹配b  |
| NOT LIKE | a NOT LIKE b | a不匹配b |
*/
# 1. %:代表任意个（0个或者多个）字符串
SELECT number, name, id_number, major FROM student_info WHERE `name` LIKE '杜%';
SELECT number, name, id_number, major FROM student_info WHERE `name` LIKE '%香%';

# 2. _:代表任意一个(就是一个)字符
SELECT number, name, id_number, major FROM student_info WHERE `name` LIKE '杜__';

# 转义通配符, 前面加\转义
SELECT number, name, id_number, major FROM student_info WHERE `name` LIKE '杜\%';






