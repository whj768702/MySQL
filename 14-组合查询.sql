# 合并查询(组合查询)
# 多条查询语句产生的结果集查也可以被合并成一个大的结果集，这种将多条查询语句产生的结果集合并起来的查询方式称为合并查询，或者组合查询。


SELECT m1 FROM t1 WHERE m1 < 2;
SELECT m1 FROM t1 WHERE m1 > 2;
# OR: 连接两个查询语句中的搜索条件
SELECT m1 FROM t1 WHERE m1 < 2 OR m1 > 2;
# UNION: 连接两个查询语句
# 建议：使用UNION连接起来的各个查询语句的查询列表中位置相同的表达式的类型应该是相同的。
# 组合查询的结果集中显示的列名将以第一个查询中的列名为准。
SELECT m1 FROM t1 WHERE m1 < 2 UNION SELECT m1 FROM t1 WHERE m1 > 2;

# 不同表的组合查询
SELECT m1, n1 FROM t1 WHERE m1 < 2 UNION SELECT m2, n2 FROM t2 WHERE m2 > 2;

# 包含或去除重复的行
SELECT * FROM t1;
SELECT * FROM t2;
# 使用UNION来合并多个查询的记录会默认过滤掉重复的记录。
SELECT m1, n1 FROM t1 UNION SELECT m2, n2 FROM t2;
# 如果想保留重复记录，可以使用UNION ALL来连接多个查询
SELECT m1, n1 FROM t1 UNION ALL SELECT m2, n2 FROM t2;


# 组合查询中的ORDER BY和LIMIT子句
# 注意：由于最后的结果集展示的列名是第一个查询中给定的列名，所以ORDER BY子句中指定的排序列也必须是第一个查询中给定的列名（别名也可以）.
SELECT m1, n1 FROM t1 UNION SELECT m2, n2 FROM t2 ORDER BY m1 DESC LIMIT 2;
# 为每个小查询加入ORDER BY子句并不起作用。
# 组合查询并不保证最后汇总起来的大结果集中的顺序是按照各个小查询的结果集中的顺序排序的，所以在小查询中加入ORDER BY和没加一样
(SELECT m1, n1 FROM t1 ORDER BY m1 DESC) UNION (SELECT m2, n2 FROM t2 ORDER BY m2 DESC);
# 只是单纯的想从各个小的查询中获取有限条排序好的记录加入最终的汇总，那是可以的。
(SELECT m1, n1 FROM t1 ORDER BY m1 DESC LIMIT 4) UNION (SELECT m2, n2 FROM t2 ORDER BY m2 DESC LIMIT 4);



