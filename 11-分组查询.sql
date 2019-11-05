# GROUP BY
# 针对某个列，将该列的值相同的记录分到一个组中。
/*
  分组的存在仅仅是为了方便我们分别统计各个分组中的信息，所以只需要把分组列和聚集函数放到查询列表处就好。
	如果非分组列出现在查询列表中会出现错误。
*/
SELECT `subject`, AVG(score) FROM student_score GROUP BY `subject`;
# 下面语句会报错
/*
1055 - Expression #1 of SELECT list is not in GROUP BY clause and contains nonaggregated
column 'juejin_mysql.student_score.number' which is not functionally dependent on columns
in GROUP BY clause; this is incompatible with sql_mode=only_full_group_by
*/
SELECT number, `subject`, AVG(score) FROM student_score GROUP BY `subject`;

# 带有WHERE子句的分组查询
SELECT `subject`, AVG(score) FROM student_score WHERE score>=60 GROUP BY `subject`;

# 作用于分组的过滤条件
# 1. 查询平均分大于73分的课程
SELECT `subject`, AVG(score) FROM student_score GROUP BY `subject` HAVING AVG(score) > 73;
# 2. 查询最高分大于98分的课程平均分（作用于分组的聚集函数）
SELECT `subject`, AVG(score) FROM student_score GROUP BY `subject` HAVING MAX(score) > 98;
# 3. 分组列
SELECT `subject`, AVG(score) FROM student_score GROUP BY `subject` HAVING `subject` LIKE '母猪%';


# 分组和排序
# 各个学科的平均分降序排序
SELECT `subject`, AVG(score) AS avg_score FROM student_score GROUP BY `subject` ORDER BY avg_score DESC;

# 嵌套分组
SELECT department, major, COUNT(*) FROM student_info GROUP BY department, major;
SELECT major, department, COUNT(*) FROM student_info GROUP BY major, department;

SELECT major, department, COUNT(*) FROM student_info GROUP BY major, department;
SELECT * FROM student_info;
INSERT INTO student_info(number, name, sex, id_number, department, major, enrollment_time) VALUES(20180107, '王五', '男', '158177199001048290', '计算机学院', '嵌入式', '2018-09-01');

# 使用分组注意事项
/*
  1. 如果分组列中含有NULL值，那么NULL也会作为一个独立的分组存在。
	2. 如果存在多个分组列(嵌套分组)，聚集函数将作用在最后的那个分组列上。
	3. 如果查询语句中存在WHERE子句和ORDER BY子句，那么GROUP BY子句必须出现在WHERE子句之后，ORDER BY子句之前。
	4. 非分组列不能单独出现在检索列表中(可以被放到聚集函数中)。
	5. GROUP BY子句后可以跟随表达式(但不能是聚集函数)。
	6. WHERE和HAVING子句的区别
			WHERE子句在分组前进行过滤，作用于每一条记录, WHERE子句过滤掉的记录将不包括在分组中。
			HAVING子句在数据分组后进行过滤，作用于整个分组。
*/

# 子句的顺序
/*
SELECT [DISTINCT] 查询列表
[FROM 表名]
[WHERE 布尔表达式]
[GROUP BY 分组列表 ]
[HAVING 分组过滤条件]
[ORDER BY 排序列表]
[LIMIT 开始行, 限制条数]
*/