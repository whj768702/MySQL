# 插入一行
INSERT INTO first_table(first_column) VALUES(2);

INSERT INTO first_table(second_column) VALUES('ccc');

SELECT * FROM first_table;

# 批量插入
INSERT INTO first_table(first_column, second_column)VALUES(4, 'ddd'), (5, 'eee'), (6, 'fff');

DROP TABLE first_table;

# 列名 列的类型 DEFAULT(默认值)
CREATE TABLE first_table (
	first_column INT,
	second_column VARCHAR(100) DEFAULT('abc')
);

# 列名 列的类型 NOT NULL
CREATE TABLE first_table(
	first_column INT NOT NULL,
	second_column VARCHAR(100) DEFAULT('abc')
);
# 插入NULL报错：Column 'first_column; cannot be null
INSERT INTO first_table(first_column, second_column) VALUES(NULL, 'aaa');
# 设置了NOT NULL，必须显式指定这个列的值: Field 'fist_column' doesn't have a default value
INSERT INTO first_table(second_column) VALUES('aaa');


/*
有时候在表里可以通过某个列或者某些列确定唯一的一条记录，这个列或者这些列称为候选键
一个表可能有多个候选键，可以选一个候选键作为表的主键。
一个表最多只能有一个主键，主键的值不能重复，通过主键可以找到唯一的一条记录。
*/
# PRIMARY KEY
CREATE TABLE student_info (
	number INT PRIMARY KEY,
	name VARCHAR(5),
	sex ENUM('男', '女'),
	id_number CHAR(18),
	department VARCHAR(30),
	major VARCHAR(30),
	enrollment_time DATE
);
# PRIMARY KEY（列名1, 列名2, ...）
CREATE TABLE student_score (
	number INT,
	subject VARCHAR(30),
	score TINYINT,
	PRIMARY KEY(number, subject)
);
# 主键默认有NOT NULL属性： Column 'number' cannot be null
INSERT INTO student_info(number) VALUES(NULL);

/*
其他不是主键的候选键，可以增加UNIQUE属性，表明该列或者列组合的值是不允许重复的.
如果表中为某个列或者列组合定义了UNIQUE属性的话，MySQL会对插入的记录做校验，如果
新插入的记录在该列或者列组合的值已经在表中存在了，就会报错！
*/
CREATE TABLE student_info2 (
	number INT PRIMARY KEY,
	name VARCHAR(5),
	sex ENUM('男', '女'),
	id_number CHAR(18) UNIQUE,
	department VARCHAR(30),
	major VARCHAR(30),
	enrollment_time DATE
);
# UNIQUE [约束名称] (列名1, 列名2, ...)
# UNIQUE KEY [约束名称] (列名1, 列名2, ...)
CREATE TABLE student_info3 (
	number INT PRIMARY KEY,
	name VARCHAR(5),
	sex ENUM('男', '女'),
	id_number CHAR(18),
	department VARCHAR(30),
	major VARCHAR(30),
	enrollment_time DATE,
	UNIQUE KEY uk_id_number(id_number)
);
/*
主键和UNIQUE约束
相同点：都能保证某个列或者列组合的唯一性
不同点：
1. 一张表中只能定义一个主键，却可以定义多个UNIQUE约束
2. 主键列不允许存放NULL，而声明了UNIQUE属性的列可以存放NULL，而且NULL可以重复地出现在多条记录中。
*/


# 外键
# 语法:CONSTRAINT [外键名称] FOREIGN KEY(列1, 列2,...) REFERENCES 父表名(父列1, 父列2, ...);
/*
父表中被子表依赖的列或者列组合必须建立索引，如果该列或者列组合已经是主键或者有UNIQUE属性，那么它们
也就被默认建立了索引。
*/
CREATE TABLE IF NOT EXISTS student_score(
	number INT,
	subject VARCHAR(30),
	score TINYINT,
	PRIMARY KEY (number, subject),
	CONSTRAINT FOREIGN KEY(number) REFERENCES student_info(number)
);
INSERT INTO student_info(number, `name`) VALUES(1, '小王');
/*
在student_score表中插入数据的时候，MySQL都会检查一下插入的学号是否能在student_info表中找到，
如果找不到则会报错。
*/
# 插入失败：Cannot add or update a child row:a foreign key constraint fails
INSERT INTO student_score(number, `subject`, score) VALUES(2, '语文', 90);
# 插入成功
INSERT INTO student_score(number, `subject`, score) VALUES(1, '语文', 90);

# AUTO_INCREMENT属性
# 语法: 列名 列的类型 AUTO_INCREMENT
/*
1. 一个表中最多有一个具有AUTO_INCREMENT属性的列。
2. 具有AUTO_INCREMENT属性的列必须建立索引。主键和具有UNIQUE属性的列会自动建立索引。
3. 拥有AUTO_INCREMENT属性的列不能再通过DEFAULT属性来指定默认值。
4. 一般拥有AUTO_INCREMENT属性的列都是作为主键的属性，来自动生成唯一标识一条记录的主键值。
*/
DROP TABLE first_table;
CREATE TABLE first_table(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	first_column INT,
	second_column VARCHAR(100) DEFAULT 'abc'
);
INSERT INTO first_table(first_column, second_column) VALUES(1, 'aaa');
INSERT INTO first_table(id, first_column, second_column) VALUES(NULL, 1, 'aaa');
INSERT INTO first_table(id, first_column, second_column) VALUE(0, 1, 'aaa');
SELECT * FROM first_table;


# 列注释:在语句后面加上COMMENT
CREATE TABLE first_table(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY COMMIT '自增主键',
	first_column INT COMMENT '第一列',
	second_column VARCHAR(100) DEFAULT 'abc' COMMENT '带默认值的第二列'
) COMMENT '第一个表';



# ZEROFILL属性
/*
如果声明了ZEROFILL属性的整数列的实际值的位数小于显示宽度时，会在实际值的左侧补0，使补0的位数和实际值
的位数相加正好等于显示宽度。
1. 在展示查询结果时，某列数据自动补0的条件：
   a. 该列必须是整数类型的。
	 b. 该列必须有UNSIGNED ZEROFILL的属性。
	 c. 该列的实际值的位数必须小于显示宽度。
2. 在创建表的时候，如果声明了ZEROFILL属性的列没有声明UNSIGNED属性，那么MySQL会为该列自动生成
	 UNSIGNED属性
也就是说，MySQL现在只支持对无符号整数进行自动补0的操作。
*/
CREATE TABLE zerofill_table(
	i1 INT UNSIGNED ZEROFILL,
	i2 INT UNSIGNED
);
INSERT INTO zerofill_table(i1, i2) VALUES(1, 1);
SELECT * FROM zerofill_table;
SHOW CREATE TABLE zerofill_table \g;