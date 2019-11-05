DROP TABLES IF EXISTS student_info, student_score;
# 创建基本信息表和成绩表
CREATE TABLE student_info(
	number INT PRIMARY KEY,
	name VARCHAR(5),
	sex ENUM('男', '女'),
	id_number CHAR(18),
	department VARCHAR(30),
	major VARCHAR(30),
	enrollment_time DATE,
	UNIQUE KEY (id_number)
) COMMENT '学生基本信息表';
CREATE TABLE student_score(
	number INT,
	subject VARCHAR(30),
	score TINYINT,
	PRIMARY KEY (number, subject),
	CONSTRAINT FOREIGN KEY(number) REFERENCES student_info(number)
) COMMENT '学生成绩表';
# 插入数据
INSERT INTO student_info(number, name, sex, id_number, department, major, enrollment_time) VALUES
	(20180101, '杜子腾', '男', '158177199901044792', '计算机学院', '计算机科学与工程', '2018-09-01'),
	(20180102, '杜琦燕', '女', '151008199801178529', '计算机学院', '计算机科学与工程', '2018-09-01'),
	(20180103, '范统', '男', '17156319980116959X', '计算机学院', '软件工程', '2018-09-01'),
	(20180104, '史珍香', '女', '141992199701078600', '计算机学院', '软件工程', '2018-09-01'),
	(20180105, '范剑', '男', '181048199308156368', '航天学院', '飞行器设计', '2018-09-01'),
	(20180106, '朱逸群', '男', '197995199501078445', '航天学院', '电子信息', '2018-09-01');
INSERT INTO student_score (number, subject, score) VALUES
	(20180101, '母猪的产后护理', 78),
	(20180101, '论萨达姆的战争准备', 88),
	(20180102, '母猪的产后护理', 100),
	(20180102, '论萨达姆的战争准备', 98),
	(20180103, '母猪的产后护理', 59),
	(20180103, '论萨达姆的战争准备', 61),
	(20180104, '母猪的产后护理', 55),
	(20180104, '论萨达姆的战争准备', 46);
	
# 查询
# 查询单个列：SELECT 列名 FROM 表名;
SELECT number FROM student_info;
# 列的别名: SELECT 列名 [AS] 列的别名 FROM 表名;
SELECT number AS 学号 FROM student_info;
SELECT number 学号 FROM student_info;
# 查询多列: SELECT 列名1, 列名2, ..., 列名n FROM 表名;
SELECT number, name, id_number, major FROM student_info;
# 查询所有列: SELECT * FROM 表名;
# 没有必要所有列的话，少用，查询不需要的列会降低性能。
SELECT * FROM student_info;

# 查询结果去重: SELECT DISTINCT 列名 FROM 表名;
SELECT DISTINCT department FROM student_info;
# 去除多列的重复结果: SELECT DISTINCT 列名1, 列名2, ..., 列名n FROM 表名;
SELECT DISTINCT department, major FROM student_info;
# 限制查询结果条数: LIMIT 开始行, 限制条数;
/*
开始行指的是从第几行（从0开始）数据开始查询，限制条数是结果集中最多包含多少条记录。
*/
SELECT number, `name`, id_number, major FROM student_info LIMIT 0, 2;
SELECT number, `name`, id_number, major FROM student_info LIMIT 2; # 默认从0行开始

# 对查询结果排序: ORDER BY 列名 ASC|DESC
/*
如果省略 ORDER BY语句中的排序方向，则默认按照从小到大的顺序排列
*/
SELECT * FROM student_score ORDER BY score ASC;
SELECT * FROM student_score ORDER BY score DESC;
# 按照多个列的值进行排序: ORDER BY 列1 ASC|DESC, 列2 ASC|DESC ...
SELECT * FROM student_score ORDER BY score;
SELECT * FROM student_score ORDER BY number DESC, score DESC;
/*
ORDER BY语句和 LIMIT 语句可以结合使用，ORDER BY语句必须放在 LIMIT语句前面
*/
SELECT * FROM student_score ORDER BY score LIMIT 1;