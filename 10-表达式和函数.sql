# 操作符
# 1. 算术操作符
/*
| 操作符 |  示例   |        描述        |
| :----: | :-----: | :----------------: |
|   +    |  a + b  |        加法        |
|   -    |  a - b  |        减法        |
|   *    |  a * b  |        乘法        |
|   /    |  a / b  |        除法        |
|  DIV   | a DIV b | 除法，取商整数部分 |
|   %    |  a % b  |        取余        |
|   -    |   -a    |        负号        |
*/
# 2. 比较操作符
/*
|   操作符    |         示例          |           描述           |
| :---------: | :-------------------: | :----------------------: |
|      =      |         a = b         |          a等于b          |
|   <>或!=    |         a<>b          |         a不等于b         |
|      <      |          a<b          |          a小于b          |
|     <=      |          a<=          |        a小于等于b        |
|      >      |          a>b          |          a大于b          |
|     >=      |         a>=b          |        a大于等于b        |
|   BETWEEN   |   a BETWEEN b AND c   |       满足b<=a<=c        |
| NOT BETWEEN | a NOT BETWEEN b AND c |      不满足b<=a<=c       |
|     IN      |  a IN（b1, b2,...）   |  a是b1,b2,...中的某一个  |
|   NOT IN    |  a NOT IN(b1,b2,...)  | a不是b1,b2,...中的某一个 |
|   IS NULL   |       a IS NULL       |       a的值是NULL        |
| IS NOT NULL |     a IS NOT NULL     |      a的值不是NULL       |
|    LIKE     |       a LIKE  b       |          a匹配b          |
|  NOT LIKE   |     a NOT LIKE b      |         a不匹配b         |
*/
# 3. 逻辑操作符
/*
| 操作符 |  示例   |                 描述                 |
| :----: | :-----: | :----------------------------------: |
|  AND   | a AND b |    只有a和b同时为真，表达式才为真    |
|   OR   | a OR b  | 只要a或b有任意一个为真，表达式就为真 |
|  XOR   | a XOR b |   a和b有且只有一个为真，表达式为真   |
*/

SELECT number, `subject`, score + 10 AS score FROM student_score;

# 函数
# 1. 文本处理函数
/*
|   名称    |          调用示例           |   结果    |                  描述                  |
| :-------: | :-------------------------: | :-------: | :------------------------------------: |
|   LEFT    |      LEFT('abc123', 3)      |    abc    |    给定字符串从左边取指定长度的子串    |
|   RIGHT   |     RIGHT('abc123', 3)      |    123    |     给定字符从右边取指定长度的子串     |
|  LENGTH   |        LENGTH('abc')        |     3     |            给定字符串的长度            |
|   LOWER   |        LOWER('ABC')         |    abc    |          给定字符串的小写格式          |
|   UPPER   |        UPPER('abc')         |    ABC    |          给定字符串的大写格式          |
|   LTRIM   |        LTRM('  abc')        |    abc    |     给定字符串左边空格去除后的格式     |
|   RTRIM   |       RTRIM('abc  ')        |    abc    |     给定字符串右边空格去除后的格式     |
| SUBSTRING |  SUBSTRING('abc123', 2, 3)  |    bc1    | 给定字符串从指定位置截取指定长度的子串 |
|  CONCAT   | CONCAT('abc', '123', 'xyz') | abc123xyz |  将给定的各个字符串拼接成一个新字符串  |
*/
SELECT CONCAT('学号为', number, '的学生在《', subject, '》课程的成绩是: ', score) AS '成绩描述' FROM student_score;

# 日期和时间处理函数
/*
|    名称     |                    调用示例                     |        结果         |                             描述                             |
| :---------: | :---------------------------------------------: | :-----------------: | :----------------------------------------------------------: |
|     NOW     |                      NOW()                      | 2019-08-16 17:10:43 |                      返回当前日期和时间                      |
|   CURDATE   |                    CURDATE()                    |     2019-08-16      |                         返回当前日期                         |
|   CURTIME   |                    CURTIME()                    |      17:10:43       |                         返回当前时间                         |
|    DATE     |           DATE('2019-08-16 17:10:43')           |     2019-08-16      |                   提取指定日期和时间的日期                   |
|  DATE_ADD   | DATE_ADD('2019-08-16 17:10:43', INTERVAL 2 DAY) | 2019-08-18 17:10:43 |            将给定的日期和时间值添加指定的时间间隔            |
|  DATE_SUB   | DATE_SUB('2019-08-16 17:10:43', INTERVAL 2 DAY) | 2019-08-14 17:10:43 |            将给定的日期和时间值减去指定的时间间隔            |
|  DATEDIFF   |      DATEDIFF('2019-08-16', '2019-08-17');      |         -1          | 返回两个日期之间的天数（负数代表前一个参数代表的日期比较小） |
| DATE_FORMAT |          DATE_FORMAT(NOW(),'%m-%d-%Y')          |     08-16-2019      |                  用给定的格式显示日期和时间                  |

时间单位	    描述
MICROSECOND	毫秒
SECOND	    秒
MINUTE	    分钟
HOUR	      小时
DAY        	天
WEEK	      星期
MONTH	      月
QUARTER   	季度
YEAR	      年
*/
SELECT DATE_SUB('2019-08-20 17:10:10', INTERVAL 10 SECOND);
SELECT DATEDIFF('2019-08-23 17:10:10', '2019-08-21 17:10:11');

# 数值处理函数
/*
| 名称 |  调用示例   |        结果        |        描述        |
| :--: | :---------: | :----------------: | :----------------: |
| ABS  |   ABS(-1)   |         1          | 返回当前日期和时间 |
|  Pi  |    PI()     |      3.141593      |     返回圆周率     |
| COS  |  COS(PI())  |         -1         | 返回一个角度的余弦 |
| EXP  |   EXP(1)    | 2.718281828459045  |  返回e的指定次方   |
| MOD  |  MOD(5, 2)  |         1          |   返回除法的余数   |
| RAND |   RAND()    | 0.7537623539136372 |   返回一个随机数   |
| SIN  | SIN(PI()/2) |         1          | 返回一个角度的正弦 |
| SQRT |   SQRT(9)   |         3          | 返回一个数的平方根 |
| TAN  |   TAN(0)    |         0          | 返回一个角度的正切 |
*/
SELECT TAN(0);

# 聚集函数
# 聚集函数不能放到WHERE子句中！！！
/*
| 函数名 |       描述       |
| :----: | :--------------: |
| COUNT  |  返回某列的行数  |
|  MAX   | 返回某列的最大值 |
|  MIN   | 返回某列的最小值 |
|  SUM   |  返回某列值之和  |
|  AVG   | 返回某列的平均值 |
*/
 # 1. COUNT: 
 # COUNT(*):对表中行的数目进行计数，不管列的值是不是NULL
 # COUNT(列名):对特定的列进行计数，会忽略掉该列为NULL的行
 SELECT COUNT(*) FROM student_info;
 SELECT COUNT(number) FROM student_info;
 
 # 2. MAX
 SELECT MAX(score) FROM student_score;
 
 # 3. MIN
 SELECT MIN(score) FROM student_score;

# 4. SUM
SELECT SUM(score) FROM student_score;

# 5. AVG
SELECT AVG(score) FROM student_score;

SELECT COUNT(DISTINCT major) FROM student_info;