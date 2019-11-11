# 准备工作
DROP TABLE IF EXISTS first_table;
CREATE TABLE IF NOT EXISTS first_table(
	first_column INT,
	second_column VARCHAR(100)
);

# 插入数据
# 语法: INSERT INTO 表名 VALUES (列1的值, 列2的值,...), (列1的值, 列2的值,...), ...;
# 语法: INSERT INTO 表名(列1, 列2, ...) VALUES (列1的值, 列2的值,...), (列1的值, 列2的值,...), ...;
# 第二种写法：INSERT语句中指定的列顺序可以改变，但是一定要和VALUES列表中的值一一对应起来。
INSERT INTO first_table VALUE(1, 'aaa');
SELECT * FROM first_table;
# 插入部分值
/*
  可省略值必须满足一下条件之一
    1. 该列允许存储NULL值
	  2. 该列有DEFAULT属性，给出了默认值
*/
INSERT INTO first_table(first_column) VALUES(5);
INSERT INTO first_table(second_column) VALUES('fff');

# 将某个查询的结果集插入到表中
CREATE TABLE IF NOT EXISTS second_table(
	s VARCHAR(200),
	i INT
);
INSERT INTO second_table(s, i) SELECT second_column, first_column FROM first_table WHERE first_column < 5;
SELECT * FROM second_table;

# INSERT IGNORE
# 对于那些是主键或者具有UNIQUE约束的列或者列组合来说，如果表中已存在的记录中没有与待插入记录
#	在这些列或者列组合上重复的值，那么就把待插入记录插到表中，否则忽略此次插入操作。
ALTER TABLE first_table MODIFY COLUMN first_column INT UNIQUE;
INSERT INTO first_table(first_column, second_column) VALUES(1, 'haha'); # 报错
INSERT IGNORE INTO first_table(first_column, second_column) VALUES(1, 'haha'), (9, 'iii'); # 成功
SELECT * FROM first_table;

# INSERT ON DUPLICATE KEY UPDATE
/*
	对于那些是主键或者具有UNIQUE约束的列或者列组合来说，如果表中已存在的记录中没有与待插入记录在
	这些列或者列组合上重复的值，那么就把待插入记录插到表中，否则按照规定去更新那条重复的记录中某些列的值。
*/
INSERT INTO first_table(first_column, second_column) VALUES(1, '娃哈哈') ON DUPLICATE KEY UPDATE second_column = '雪碧';


# 删除数据
# DELETE FROM 表名 [WHERE 表达式];
DELETE FROM first_table WHERE first_column > 4;
# LIMIT指定删除的数量，ORDER BY指定符合条件的记录的删除顺序
# 虽然删除语句的WHERE条件是可选的，但是如果不加WHERE条件的话将删除所有的记录，这是玩火的行为！超级危险！十分危险！请慎重使用。
DELETE FROM first_table ORDER BY first_column DESC LIMIT 1;
SELECT * from first_table;


# 更新数据
# UPDATE 表名 SET 列1=值1, 列2=值2, ..., 列n=值n [WHERE 布尔表达式];
# LIMIT指定删除的数量，ORDER BY指定符合条件的记录的删除顺序
# 虽然更新语句的WHERE子句是可选的，但是如果不加WHERE子句的话将更新表中所有的记录，这是玩火的行为！超级危险！十分危险！请慎重使用。
UPDATE first_table SET first_column = 5, second_column = '乳娃娃' WHERE first_column IS NULL;
