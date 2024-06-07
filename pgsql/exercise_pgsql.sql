-- 1757. 可回收且低脂的产品
-- 创建枚举类型
CREATE TYPE low_fats_type AS ENUM ('Y', 'N');
CREATE TYPE recyclable_type AS ENUM ('Y', 'N');

-- 创建表(自增主键)
CREATE TABLE IF NOT EXISTS Products (product_id SERIAL PRIMARY KEY, low_fats low_fats_type NOT NULL, recyclable recyclable_type NOT NULL);

-- 插入数据
INSERT INTO Products (low_fats, recyclable) VALUES ('Y', 'N');
INSERT INTO Products (low_fats, recyclable) VALUES ('Y', 'Y');
INSERT INTO Products (low_fats, recyclable) VALUES ('N', 'Y');
INSERT INTO Products (low_fats, recyclable) VALUES ('Y', 'Y');
INSERT INTO Products (low_fats, recyclable) VALUES ('N', 'N');

-- 清空表
-- TRUNCATE TABLE Products RESTART IDENTITY;

SELECT product_id FROM Products WHERE low_fats = 'Y' AND recyclable = 'Y';


-- 584. 寻找用户推荐人
Create TABLE IF NOT EXISTS Customer (id SERIAL PRIMARY KEY, name VARCHAR(25) DEFAULT '' NOT NULL, referee_id INT);

INSERT INTO Customer (name, referee_id) VALUES ('Will', NULL);
INSERT INTO Customer (name, referee_id) VALUES ('Jane', NULL);
INSERT INTO Customer (name, referee_id) VALUES ('Alex', '2');
INSERT INTO Customer (name, referee_id) VALUES ('Bill', NULL);
INSERT INTO Customer (name, referee_id) VALUES ('Zack', '1');
INSERT INTO Customer (name, referee_id) VALUES ('Mark', '2');

-- SELECT name FROM Customer WHERE referee_id != 2 OR referee_id ISNULL;
-- IS NULL 是 标准 sql 写法
SELECT name FROM Customer WHERE referee_id != 2 OR referee_id IS NULL;


-- 595. 大的国家
Create TABLE IF NOT EXISTS World (name VARCHAR(255) CONSTRAINT unique_name UNIQUE, continent VARCHAR(255), area INT, population INT, gdp BIGINT);
-- 唯一约束(唯一键)
-- ALTER TABLE World ADD CONSTRAINT unique_name UNIQUE (name);

INSERT INTO World (name, continent, area, population, gdp) VALUES ('Afghanistan', 'Asia', 652230, 25500100, 20343000000);
INSERT INTO World (name, continent, area, population, gdp) VALUES ('Albania', 'Europe', 28748, 2831741, 12960000000);
INSERT INTO World (name, continent, area, population, gdp) VALUES ('Algeria', 'Africa', 2381741, 37100000, 188681000000);
INSERT INTO World (name, continent, area, population, gdp) VALUES ('Andorra', 'Europe', 468, 78115, 3712000000);
INSERT INTO World (name, continent, area, population, gdp) VALUES ('Angola', 'Africa', 1246700, 20609294, 100990000000);

SELECT name, population, area FROM World WHERE area >= 3000000 OR population >= 25000000;


-- 1148. 文章浏览 I
Create TABLE IF NOT EXISTS Views (article_id INT, author_id INT, viewer_id INT, view_date DATE);

INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (1, 3, 5, '2019-08-01');
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (1, 3, 6, '2019-08-02');
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (2, 7, 7, '2019-08-01');
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (2, 7, 6, '2019-08-02');
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (4, 7, 1, '2019-07-22');
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (3, 4, 4, '2019-07-21');
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (3, 4, 4, '2019-07-21');
-- DESC 是降序(Descending), ASC 是升序(Ascending)
-- SELECT DISTINCT author_id AS id FROM Views WHERE author_id = viewer_id ORDER BY id ASC;
SELECT author_id AS id FROM Views WHERE author_id = viewer_id GROUP BY id ORDER BY id ASC;


-- 1683. 无效的推文
Create TABLE IF NOT EXISTS Tweets(tweet_id SERIAL PRIMARY KEY, content VARCHAR(50));

INSERT INTO Tweets (content) VALUES ('Vote for Biden');
INSERT INTO Tweets (content) VALUES ('Let us make America great again!');

-- 查询性能分析
-- EXPLAIN ANALYZE SELECT tweet_id FROM Tweets WHERE "length"(content) > 15;
-- EXPLAIN ANALYZE SELECT tweet_id FROM Tweets WHERE LENGTH(content) > 15;
SELECT tweet_id FROM Tweets WHERE CHAR_LENGTH(content) > 15; -- 推荐这个

----------------------------连接----------------------------------

-- 1378. 使用唯一标识码替换员工ID
Create TABLE IF NOT EXISTS Employees (id INT PRIMARY KEY, name VARCHAR(20));
Create TABLE IF NOT EXISTS Employee_UNI (id INT, unique_id INT, PRIMARY KEY (id, unique_id));
-- 组合主键
-- ALTER TABLE EmployeeUNI ADD PRIMARY KEY (id, unique_id);

INSERT INTO Employees (id, name) VALUES (1, 'Alice');
INSERT INTO Employees (id, name) VALUES (7, 'Bob');
INSERT INTO Employees (id, name) VALUES (11, 'Meir');
INSERT INTO Employees (id, name) VALUES (90, 'Winston');
INSERT INTO Employees (id, name) VALUES (3, 'Jonathan');

INSERT INTO Employee_UNI (id, unique_id) VALUES (3, 1);
INSERT INTO Employee_UNI (id, unique_id) VALUES (11, 2);
INSERT INTO Employee_UNI (id, unique_id) VALUES (90, 3);

SELECT * FROM Employees;
SELECT * FROM Employee_UNI;

SELECT euni.unique_id, e.name FROM Employees e LEFT JOIN Employee_UNI euni ON e.id = euni.id;
-- USING (id) 子句是 ON e.id = euni.id 的简写形式，告诉数据库在两个表中查找具有相同列名 id 的列，并将它们用作连接条件。这可以使查询更简洁，但逻辑上它们是一样的。
SELECT unique_id, name FROM Employees LEFT JOIN Employee_UNI USING (id);


-- 1068. 产品销售分析I(可选)
Create TABLE IF NOT EXISTS Sales (sale_id INT, product_id INT, year INT, quantity INT, price INT, PRIMARY KEY (sale_id, year));
Create TABLE IF NOT EXISTS Product (id INT PRIMARY KEY, name VARCHAR(10));

INSERT INTO Sales (sale_id, product_id, year, quantity, price) VALUES (1, 100, 2008, 10, 5000);
INSERT INTO Sales (sale_id, product_id, year, quantity, price) VALUES (2, 100, 2009, 12, 5000);
INSERT INTO Sales (sale_id, product_id, year, quantity, price) VALUES (7, 200, 2011, 15, 9000);

INSERT INTO Product (id, name) VALUES (100, 'Nokia');
INSERT INTO Product (id, name) VALUES (200, 'Apple');
INSERT INTO Product (id, name) VALUES (300, 'Samsung');

SELECT name, year, price FROM sales s LEFT JOIN product p ON s.product_id = p.id;


-- 1581. 进店却未进行过交易的顾客
Create TABLE IF NOT EXISTS Visits(visit_id INT PRIMARY KEY, customer_id INT);
Create TABLE IF NOT EXISTS Transactions(transaction_id INT PRIMARY KEY, visit_id INT, amount INT);

INSERT INTO Visits (visit_id, customer_id) VALUES (1, 23);
INSERT INTO Visits (visit_id, customer_id) VALUES (2, 9);
INSERT INTO Visits (visit_id, customer_id) VALUES (4, 30);
INSERT INTO Visits (visit_id, customer_id) VALUES (5, 54);
INSERT INTO Visits (visit_id, customer_id) VALUES (6, 96);
INSERT INTO Visits (visit_id, customer_id) VALUES (7, 54);
INSERT INTO Visits (visit_id, customer_id) VALUES (8, 54);

INSERT INTO Transactions (transaction_id, visit_id, amount) VALUES (2, 5, 310);
INSERT INTO Transactions (transaction_id, visit_id, amount) VALUES (3, 5, 300);
INSERT INTO Transactions (transaction_id, visit_id, amount) VALUES (9, 5, 200);
INSERT INTO Transactions (transaction_id, visit_id, amount) VALUES (12, 1, 910);
INSERT INTO Transactions (transaction_id, visit_id, amount) VALUES (13, 2, 970);

-- SELECT * FROM Visits LEFT JOIN Transactions USING (visit_id);
SELECT customer_id, COUNT(*) AS count_no_trans FROM Visits LEFT JOIN Transactions USING (visit_id)
                                               WHERE transaction_id IS NULL GROUP BY customer_id;


-- 197. 上升的温度(内连接)
Create TABLE IF NOT EXISTS Weather (id Serial PRIMARY KEY, record_date DATE, temperature INT);

INSERT INTO Weather (record_date, temperature) VALUES ('2015-01-01', 10);
INSERT INTO Weather (record_date, temperature) VALUES ('2015-01-02', 25);
INSERT INTO Weather (record_date, temperature) VALUES ('2015-01-03', 20);
INSERT INTO Weather (record_date, temperature) VALUES ('2015-01-04', 30);
-- 找出与之前（昨天的）日期相比温度更高的所有日期的 id, 内联自己查询
-- INNER JOIN(内连接) 查询在SQL中用于解决从两个或多个表中检索满足特定关联条件的行的问题。当需要从多个表中提取相关数据时，通常会使用INNER JOIN。
-- INNER JOIN会根据指定的连接条件(通常是基于两个或多个表中的列之间的关系)来组合两个表中的行。它只返回那些在两个表中都有匹配的行，即满足连接条件的行。如果某一行在其中一个表中没有匹配的行，那么该行就不会出现在结果集中。
-- date 类型数据可以直接相加减
SELECT w1.id FROM Weather w1 INNER JOIN Weather w2 ON w1.record_date - w2.record_date = 1 AND w1.temperature > w2.temperature;


-- 1661. 每台机器的进程平均运行时间
CREATE TYPE activity_type_enum AS ENUM ('start', 'end');
Create TABLE IF NOT EXISTS Activity (machine_id INT, process_id INT, activity_type activity_type_enum NOT NULL, timestamp FLOAT,
                                     PRIMARY KEY (machine_id, process_id, activity_type));

INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (0, 0, 'start', 0.712);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (0, 0, 'end', 1.52);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (0, 1, 'start', 3.14);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (0, 1, 'end', 4.12);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 0, 'start', 0.55);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 0, 'end', 1.55);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 1, 'start', 0.43);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 1, 'end', 1.42);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 0, 'start', 4.1);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 0, 'end', 4.512);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 1, 'start', 2.5);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 1, 'end', 5);
-- 现在有一个工厂网站由几台机器运行，每台机器上运行着 相同数量的进程 。查询并计算每台机器各自完成一个进程任务的平均耗时。
-- 完成一个进程任务的时间指进程的'end' 时间戳 减去 'start' 时间戳。平均耗时通过计算每台机器上所有进程任务的总耗费时间除以机器上的总进程数量获得。
-- 结果表必须包含machine_id(机器ID)和对应的 average time(平均耗时)别名 processing_time,且四舍五入保留3位小数。
-- 类型转换 CAST(xxx AS NUMERIC) 转小数类型, Round(xxx, 3)函数保留三位小数
SELECT machine_id,
       ROUND(CAST(SUM(timestamp * (CASE WHEN activity_type = 'end' THEN 1 ELSE -1 END)) / COUNT(DISTINCT process_id) AS NUMERIC), 3) AS processing_time
FROM Activity GROUP BY machine_id;
-- 内连接(使用多条件)
SELECT a1.machine_id, ROUND(AVG(a2.timestamp - a1.timestamp)::numeric, 3) processing_time
FROM Activity a1 INNER JOIN Activity a2
    ON (a1.machine_id = a2.machine_id AND a1.process_id = a2.process_id AND a1.activity_type = 'start' AND a2.activity_type = 'end')
GROUP BY a1.machine_id;


-- 577. 员工奖金(可选)
Create TABLE IF NOT EXISTS Employee (id INT PRIMARY KEY, name VARCHAR(255), supervisor INT, salary INT);
Create TABLE IF NOT EXISTS Bonus (emp_id INT PRIMARY KEY, bonus INT);

INSERT INTO Employee (id, name, supervisor, salary) VALUES (1, 'John', 3, 1000);
INSERT INTO Employee (id, name, supervisor, salary) VALUES (2, 'Dan', 3, 2000);
INSERT INTO Employee (id, name, supervisor, salary) VALUES (3, 'Brad', NULL, 4000);
INSERT INTO Employee (id, name, supervisor, salary) VALUES (4, 'Thomas', 3, 4000);

INSERT INTO Bonus (emp_id, bonus) VALUES (2, 500);
INSERT INTO Bonus (emp_id, bonus) VALUES (4, 2000);

SELECT name, bonus FROM employee e LEFT JOIN bonus b ON e.id = b.emp_id WHERE bonus < 1000 OR bonus IS NULL;


-- 1280. 学生们参加各科测试的次数(交叉连接)
Create TABLE IF NOT EXISTS Students (id INT PRIMARY KEY, name VARCHAR(20));
Create TABLE IF NOT EXISTS Subjects (name VARCHAR(20) PRIMARY KEY);
Create TABLE IF NOT EXISTS Examinations (student_id INT, subject_name VARCHAR(20));

INSERT INTO Students (id, name) VALUES (1, 'Alice');
INSERT INTO Students (id, name) VALUES (2, 'Bob');
INSERT INTO Students (id, name) VALUES (13, 'John');
INSERT INTO Students (id, name) VALUES (6, 'Alex');

INSERT INTO Subjects (name) VALUES ('Math');
INSERT INTO Subjects (name) VALUES ('Physics');
INSERT INTO Subjects (name) VALUES ('Programming');

INSERT INTO Examinations (student_id, subject_name) VALUES (1, 'Math');
INSERT INTO Examinations (student_id, subject_name) VALUES (1, 'Physics');
INSERT INTO Examinations (student_id, subject_name) VALUES (1, 'Programming');
INSERT INTO Examinations (student_id, subject_name) VALUES (2, 'Programming');
INSERT INTO Examinations (student_id, subject_name) VALUES (1, 'Physics');
INSERT INTO Examinations (student_id, subject_name) VALUES (1, 'Math');
INSERT INTO Examinations (student_id, subject_name) VALUES (13, 'Math');
INSERT INTO Examinations (student_id, subject_name) VALUES (13, 'Programming');
INSERT INTO Examinations (student_id, subject_name) VALUES (13, 'Physics');
INSERT INTO Examinations (student_id, subject_name) VALUES (2, 'Math');
INSERT INTO Examinations (student_id, subject_name) VALUES (1, 'Math');

-- 双表查询(将交叉连接改为双表查询)
SELECT stu.id, stu.name, sub.name AS sub_name,
       (SELECT COUNT(*) FROM Examinations e WHERE e.student_id = stu.id AND e.subject_name = sub.name) AS attended_exams
FROM Students stu, Subjects sub ORDER BY stu.id, sub.name;
-- 交叉连接:返回两个或多个表中的所有可能组合，作用就是把两张表的数据放入到一张表中，实际数据数量就是两张表的数据数量相乘。
-- 需要谨慎使用，确保结果集不会无限增长。可以适时地结合 LIMIT子句 或其他条件来控制返回的数据量,以确保查询性能。
SELECT stu.id, stu.name, sub.name AS sub_name, COALESCE(COUNT(e.subject_name), 0) AS attended_exams
FROM Students stu CROSS JOIN Subjects sub LEFT JOIN Examinations e ON stu.id = e.student_id AND e.subject_name = sub.name
GROUP BY stu.id, stu.name, sub.name ORDER BY stu.id, sub.name;


-- 620. 有趣的电影
-- NUMERIC类型定义小数位的类型
Create TABLE IF NOT EXISTS cinema (id INT PRIMARY KEY, movie VARCHAR(255), description VARCHAR(255), rating NUMERIC(2, 1));

INSERT INTO cinema (id, movie, description, rating) VALUES (1, 'War', 'great 3D', 8.9);
INSERT INTO cinema (id, movie, description, rating) VALUES (2, 'Science', 'fiction', 8.5);
INSERT INTO cinema (id, movie, description, rating) VALUES (3, 'irish', 'boring', 6.2);
INSERT INTO cinema (id, movie, description, rating) VALUES (4, 'Ice song', 'Fantacy', 8.6);
INSERT INTO cinema (id, movie, description, rating) VALUES (5, 'House card', 'Interesting', 9.1);

-- 不等于 != 或 <>, mod(id, 2) = 1 或 id % 2 != 0, mod()是取模函数, lower()函数字符串转小写
SELECT * FROM cinema WHERE lower(description) != 'boring' AND id % 2 != 0 ORDER BY rating DESC;
SELECT * FROM cinema WHERE lower(description) <> 'boring' AND mod(id, 2) = 1 ORDER BY rating DESC;


-- 1251. 平均售价
Create TABLE IF NOT EXISTS Prices (product_id INT, start_date DATE, end_date DATE, price INT);
ALTER TABLE Prices ADD PRIMARY KEY (product_id, start_date, end_date);
Create TABLE IF NOT EXISTS Units_Sold (product_id INT, purchase_date DATE, units INT);

INSERT INTO Prices (product_id, start_date, end_date, price) VALUES (1, '2019-02-17', '2019-02-28', 5);
INSERT INTO Prices (product_id, start_date, end_date, price) VALUES (1, '2019-03-01', '2019-03-22', 20);
INSERT INTO Prices (product_id, start_date, end_date, price) VALUES (2, '2019-02-01', '2019-02-20', 15);
INSERT INTO Prices (product_id, start_date, end_date, price) VALUES (2, '2019-02-21', '2019-03-31', 30);
INSERT INTO Prices (product_id, start_date, end_date, price) VALUES (3, '2019-02-21', '2019-03-31', 30);

INSERT INTO Units_Sold (product_id, purchase_date, units) VALUES (1, '2019-02-25', 100);
INSERT INTO Units_Sold (product_id, purchase_date, units) VALUES (1, '2019-03-01', 15);
INSERT INTO Units_Sold (product_id, purchase_date, units) VALUES (2, '2019-02-10', 200);
INSERT INTO Units_Sold (product_id, purchase_date, units) VALUES (2, '2019-03-22', 30);

-- NULLIF() 和 COALESCE(): 在这里，NULLIF(CAST(SUM(us.units) AS NUMERIC), 0) 会返回 NULL 如果 SUM(us.units) 是 0，从而避免除以零的错误。注:如果某个 product_id 没有任何销售记录(即 SUM(us.units) 为 0)，那么 average_price 将是 NULL。如果你想要在这种情况下返回 0 或者其他默认值，可以使用 COALESCE 函数来处理 NULL 值。
-- left join (使用多条件)
SELECT p.product_id, COALESCE(ROUND(SUM(p.price * us.units)::numeric / SUM(us.units), 2), 0) AS average_price
FROM Prices p LEFT JOIN Units_Sold us ON p.product_id = us.product_id AND us.purchase_date BETWEEN p.start_date AND p.end_date
GROUP BY p.product_id;
-- ::numeric这个运行效率高一点
-- SELECT p.product_id, COALESCE(ROUND(SUM(p.price * us.units) * 1.00 / SUM(us.units), 2), 0) AS average_price FROM Prices p LEFT JOIN Units_Sold us ON p.product_id = us.product_id AND us.purchase_date BETWEEN p.start_date AND p.end_date GROUP BY p.product_id;


-- 1075. 项目员工I
Create TABLE IF NOT EXISTS Project (id INT, employee_id INT, PRIMARY KEY (id, employee_id));
-- Create TABLE IF NOT EXISTS Employee (id INT, name VARCHAR(10), experience_years INT DEFAULT 0 NOT NULL);
-- 添加列(字段)
ALTER TABLE Employee ADD COLUMN experience_years INT DEFAULT 0 NOT NULL;

INSERT INTO Project (id, employee_id) VALUES (1, 1);
INSERT INTO Project (id, employee_id) VALUES (1, 2);
INSERT INTO Project (id, employee_id) VALUES (1, 3);
INSERT INTO Project (id, employee_id) VALUES (2, 1);
INSERT INTO Project (id, employee_id) VALUES (2, 4);

INSERT INTO Employee (id, name, experience_years) VALUES (1, 'Khaled', 3);
INSERT INTO Employee (id, name, experience_years) VALUES (2, 'Ali', 2);
INSERT INTO Employee (id, name, experience_years) VALUES (3, 'John', 1);
INSERT INTO Employee (id, name, experience_years) VALUES (4, 'Doe', 2);

-- AVG()函数 和 SUM()函数
-- SELECT p.id, ROUND(SUM(e.experience_years)::numeric / COUNT(*), 2) AS average_years FROM project p LEFT JOIN employee e ON p.employee_id = e.id GROUP BY p.id;
-- 解法二:
SELECT p.id, ROUND(AVG(e.experience_years), 2) AS average_years FROM Project p LEFT JOIN Employee e ON p.employee_id = e.id GROUP BY p.id;


-- 1633. 各赛事的用户注册率
Create TABLE IF NOT EXISTS Users (id INT PRIMARY KEY, name VARCHAR(20));
Create TABLE IF NOT EXISTS Register (contest_id INT, user_id INT, PRIMARY KEY(contest_id, user_id));

INSERT INTO Users (id, name) VALUES (2, 'Bob');
INSERT INTO Users (id, name) VALUES (6, 'Alice');
INSERT INTO Users (id, name) VALUES (7, 'Alex');

INSERT INTO Register (contest_id, user_id) VALUES (215, 6);
INSERT INTO Register (contest_id, user_id) VALUES (209, 2);
INSERT INTO Register (contest_id, user_id) VALUES (208, 2);
INSERT INTO Register (contest_id, user_id) VALUES (210, 6);
INSERT INTO Register (contest_id, user_id) VALUES (208, 6);
INSERT INTO Register (contest_id, user_id) VALUES (209, 7);
INSERT INTO Register (contest_id, user_id) VALUES (209, 6);
INSERT INTO Register (contest_id, user_id) VALUES (215, 7);
INSERT INTO Register (contest_id, user_id) VALUES (208, 7);
INSERT INTO Register (contest_id, user_id) VALUES (210, 2);
INSERT INTO Register (contest_id, user_id) VALUES (207, 2);
INSERT INTO Register (contest_id, user_id) VALUES (210, 7);

-- 计算百分比,双字段排序
SELECT contest_id, ROUND(COUNT(*)::numeric / (SELECT COUNT(*) FROM Users) *100, 2) AS percentage
FROM Register GROUP BY contest_id ORDER BY percentage DESC, contest_id ASC;
-- 解法二:(先统计Users的总数，再交叉连接，可以减少Count(*)的调用)
WITH cte AS (SELECT COUNT(*) AS total_users FROM Users)
SELECT contest_id, ROUND(COUNT(*)::numeric / cte.total_users *100, 2) AS percentage
FROM Register CROSS JOIN cte GROUP BY contest_id, cte.total_users ORDER BY percentage DESC, contest_id ASC;


-- 1211. 查询结果的质量和占比
Create TABLE IF NOT EXISTS Queries (query_name VARCHAR(30), result VARCHAR(50), position INT, rating INT);

INSERT INTO Queries (query_name, result, position, rating) VALUES ('Dog', 'Golden Retriever', '1', '5');
INSERT INTO Queries (query_name, result, position, rating) VALUES ('Dog', 'German Shepherd', '2', '5');
INSERT INTO Queries (query_name, result, position, rating) VALUES ('Dog', 'Mule', '200', '1');
INSERT INTO Queries (query_name, result, position, rating) VALUES ('Cat', 'Shirazi', '5', '2');
INSERT INTO Queries (query_name, result, position, rating) VALUES ('Cat', 'Siamese', '3', '3');
INSERT INTO Queries (query_name, result, position, rating) VALUES ('Cat', 'Sphynx', '7', '4');
INSERT INTO Queries (query_name, result, position, rating) VALUES (NULL, 'Golden Retriever', '1', '5');
INSERT INTO Queries (query_name, result, position, rating) VALUES (NULL, 'German Shepherd', '2', '5');
INSERT INTO Queries (query_name, result, position, rating) VALUES (NULL, 'Mule', '200', '1');

-- avg（条件）相当于sum（if（条件，1，0））/ count(全体)
-- 进阶 sum（if（条件，N，0））/ count(全体) 可用 N*avg（条件）代替
-- 使用bool条件将多个样本判断为0和1，多个0和多个1的平均值就是1在整体中的比例，也即满足条件的样本在整体中的比例。

SELECT query_name, ROUND(AVG(rating::numeric / position), 2) AS quality,
       ROUND(AVG(CASE WHEN rating < 3 THEN 100 ELSE 0 END), 2) AS poor_query_percentage
FROM Queries WHERE query_name IS NOT NULL GROUP BY query_name;
-- 查询使用WHERE子句来过滤掉query_name为NULL的记录，而第二个查询则在GROUP BY之后使用了HAVING子句来进行相同的过滤。
-- WHERE子句在数据分组之前使用，用于过滤出不需要的行，而HAVING子句在数据分组之后使用，用于过滤出不需要的分组。这种情况下where子句会略快一点
-- SELECT query_name, ROUND(AVG(rating::numeric / position), 2) AS quality, ROUND(AVG(CASE WHEN rating < 3 THEN 100 ELSE 0 END), 2) AS poor_query_percentage FROM Queries GROUP BY query_name HAVING query_name is not null;


-- 2356. 每位教师所教授的科目种类的数量
Create TABLE IF NOT EXISTS Teacher (teacher_id INT, subject_id INT, dept_id INT, PRIMARY KEY(subject_id, dept_id));

INSERT INTO Teacher (teacher_id, subject_id, dept_id) VALUES ('1', '2', '3');
INSERT INTO Teacher (teacher_id, subject_id, dept_id) VALUES ('1', '2', '4');
INSERT INTO Teacher (teacher_id, subject_id, dept_id) VALUES ('1', '3', '3');
INSERT INTO Teacher (teacher_id, subject_id, dept_id) VALUES ('2', '1', '1');
INSERT INTO Teacher (teacher_id, subject_id, dept_id) VALUES ('2', '2', '1');
INSERT INTO Teacher (teacher_id, subject_id, dept_id) VALUES ('2', '3', '1');
INSERT INTO Teacher (teacher_id, subject_id, dept_id) VALUES ('2', '4', '1');

-- DISTINCT 统计中去重复
SELECT teacher_id, COUNT(DISTINCT subject_id) AS cnt FROM Teacher GROUP BY teacher_id;


-- 1141. 查询近30天活跃用户数(INTERVAL关键字的使用)
CREATE TYPE activity_type1 AS ENUM ('open_session', 'end_session', 'scroll_down', 'send_message');
Create TABLE IF NOT EXISTS Activity1 (user_id INT, session_id INT, activity_date DATE, activity_type activity_type1 NOT NULL);

INSERT INTO Activity1 (user_id, session_id, activity_date, activity_type) VALUES ('1', '1', '2019-07-20', 'open_session');
INSERT INTO Activity1 (user_id, session_id, activity_date, activity_type) VALUES ('1', '1', '2019-07-20', 'scroll_down');
INSERT INTO Activity1 (user_id, session_id, activity_date, activity_type) VALUES ('1', '1', '2019-07-20', 'end_session');
INSERT INTO Activity1 (user_id, session_id, activity_date, activity_type) VALUES ('2', '4', '2019-07-20', 'open_session');
INSERT INTO Activity1 (user_id, session_id, activity_date, activity_type) VALUES ('2', '4', '2019-07-21', 'send_message');
INSERT INTO Activity1 (user_id, session_id, activity_date, activity_type) VALUES ('2', '4', '2019-07-21', 'end_session');
INSERT INTO Activity1 (user_id, session_id, activity_date, activity_type) VALUES ('3', '2', '2019-07-21', 'open_session');
INSERT INTO Activity1 (user_id, session_id, activity_date, activity_type) VALUES ('3', '2', '2019-07-21', 'send_message');
INSERT INTO Activity1 (user_id, session_id, activity_date, activity_type) VALUES ('3', '2', '2019-07-21', 'end_session');
INSERT INTO Activity1 (user_id, session_id, activity_date, activity_type) VALUES ('4', '3', '2019-06-25', 'open_session');
INSERT INTO Activity1 (user_id, session_id, activity_date, activity_type) VALUES ('4', '3', '2019-06-25', 'end_session');

-- WITH active_user AS (SELECT activity_date, user_id FROM Activity1 WHERE activity_date BETWEEN (DATE '2019-07-27' - INTERVAL '29 days') AND DATE '2019-07-27' GROUP BY activity_date, user_id)
-- SELECT activity_date AS day, COUNT(DISTINCT user_id) AS active_users FROM active_user GROUP BY activity_date;
-- 下面的查询效率更高,操作日期范围
-- '2019-07-27'::date - INTERVAL '29 days' 即是 '2019-07-27' 减去 29日
SELECT activity_date AS day, COUNT(DISTINCT user_id) AS active_users
FROM Activity1 WHERE activity_date BETWEEN '2019-07-27'::date - INTERVAL '29 days' AND '2019-07-27' GROUP BY activity_date;
-- INTERVAL关键字,用于表示一段时间或日期的间隔。可以用来表示日期和时间之间的差异，或在日期和时间上加上或减去一定的时间量。
-- 例:可以使用INTERVAL来查询某个日期范围内的记录，或为日期字段添加或减去特定的时间量。
-- SELECT * FROM your_TABLE WHERE your_date_column >= NOW() - INTERVAL '30 days'; 减去30日
-- UPDATE your_TABLE SET your_date_column = your_date_column + INTERVAL '1 hour'; 增加1小时


-- 1084. 销售分析III
-- Create TABLE IF NOT EXISTS Product (id INT  PRIMARY KEY, name VARCHAR(10), unit_price INT);
ALTER TABLE Product ADD COLUMN unit_price INT;
Create TABLE IF NOT EXISTS Sale (seller_id INT, product_id INT, buyer_id INT, sale_date DATE, quantity INT, price INT);

INSERT INTO Product (id, name, unit_price) VALUES ('1', 'S8', '1000');
INSERT INTO Product (id, name, unit_price) VALUES ('2', 'G4', '800');
INSERT INTO Product (id, name, unit_price) VALUES ('3', 'iPhone', '1400');

INSERT INTO Sale (seller_id, product_id, buyer_id, sale_date, quantity, price) VALUES ('1', '1', '1', '2019-01-21', '2', '2000');
INSERT INTO Sale (seller_id, product_id, buyer_id, sale_date, quantity, price) VALUES ('1', '2', '2', '2019-02-17', '1', '800');
INSERT INTO Sale (seller_id, product_id, buyer_id, sale_date, quantity, price) VALUES ('2', '2', '3', '2019-06-02', '1', '800');
INSERT INTO Sale (seller_id, product_id, buyer_id, sale_date, quantity, price) VALUES ('3', '3', '4', '2019-05-13', '2', '2800');

-- HAVING 关键字子句，对分组后的结果进行筛选
SELECT id AS product_id, name AS product_name
FROM product WHERE id IN (SELECT product_id FROM sale GROUP BY product_id HAVING MAX(sale_date) <= '2019-03-31' AND MIN(sale_date) >= '2019-01-01');


-- 596. 超过5名学生的课
Create TABLE IF NOT EXISTS Courses (student VARCHAR(255), class VARCHAR(255), PRIMARY KEY (student, class));

INSERT INTO Courses (student, class) VALUES ('A', 'Math');
INSERT INTO Courses (student, class) VALUES ('B', 'English');
INSERT INTO Courses (student, class) VALUES ('C', 'Math');
INSERT INTO Courses (student, class) VALUES ('D', 'Biology');
INSERT INTO Courses (student, class) VALUES ('E', 'Math');
INSERT INTO Courses (student, class) VALUES ('F', 'Computer');
INSERT INTO Courses (student, class) VALUES ('G', 'Math');
INSERT INTO Courses (student, class) VALUES ('H', 'Math');
INSERT INTO Courses (student, class) VALUES ('I', 'Math');

-- 查询 至少有5个学生 的所有class。
SELECT class FROM Courses GROUP BY class HAVING COUNT(student) >= 5;


-- 1729. 求关注者的数量
Create TABLE IF NOT EXISTS Followers(user_id INT, follower_id INT, PRIMARY KEY (user_id, follower_id));

INSERT INTO Followers (user_id, follower_id) VALUES ('0', '1');
INSERT INTO Followers (user_id, follower_id) VALUES ('1', '0');
INSERT INTO Followers (user_id, follower_id) VALUES ('2', '0');
INSERT INTO Followers (user_id, follower_id) VALUES ('2', '1');
-- 分组统计
SELECT user_id, COUNT(follower_id) AS followers_count FROM Followers GROUP BY user_id ORDER BY user_id ASC;


-- 619. 只出现一次的最大数字
Create TABLE IF NOT EXISTS my_numbers (num INT);

INSERT INTO my_numbers (num) VALUES ('8');
INSERT INTO my_numbers (num) VALUES ('8');
INSERT INTO my_numbers (num) VALUES ('3');
INSERT INTO my_numbers (num) VALUES ('3');
INSERT INTO my_numbers (num) VALUES ('1');
INSERT INTO my_numbers (num) VALUES ('4');
INSERT INTO my_numbers (num) VALUES ('5');
INSERT INTO my_numbers (num) VALUES ('6');
INSERT INTO my_numbers (num) VALUES ('1');
INSERT INTO my_numbers (num) VALUES ('4');
INSERT INTO my_numbers (num) VALUES ('5');
INSERT INTO my_numbers (num) VALUES ('6');
INSERT INTO my_numbers (num) VALUES ('11');

-- SELECT * FROM my_numbers GROUP BY num HAVING COUNT(num) = 1 ORDER BY num DESC LIMIT 1;
-- 如果没有符合MAX()函数条件的数据，MAX()函数将返回NULL。
WITH cte AS (SELECT * FROM my_numbers GROUP BY num HAVING COUNT(num) = 1)
SELECT MAX(num) AS num FROM cte AS m;


-- 1731. 每位经理的下属员工数量(INNER JOIN 和 LEFT JOIN 的用法比较)
-- Create TABLE IF NOT EXISTS Employees(id INT, name VARCHAR(20), reports_to INT, age INT, PRIMARY KEY(id));
ALTER TABLE Employees ADD COLUMN reports_to INT;
ALTER TABLE Employees ADD COLUMN age INT;

INSERT INTO Employees (id, name, reports_to, age) VALUES ('9', 'Hercy', NULL, '43');
INSERT INTO Employees (id, name, reports_to, age) VALUES ('6', 'Alice', '9', '41');
INSERT INTO Employees (id, name, reports_to, age) VALUES ('4', 'Bob', '9', '36');
INSERT INTO Employees (id, name, reports_to, age) VALUES ('2', 'Winston', NULL, '37');

SELECT e2.id, e2.name, COUNT(e1.reports_to) AS reports_count, ROUND(AVG(e1.age)) AS average_age
FROM employees e1 INNER JOIN employees e2 ON e1.reports_to = e2.id WHERE e1.reports_to IS NOT NULL GROUP BY e2.id, e2.name ORDER BY e2.id;

-- INNER JOIN返回两个或多个表中满足连接条件的记录。它只返回那些在两个表中有匹配的行。
-- 如果在一个表中有行在另一个表中没有匹配的行，那么这些行不会出现在结果集中。用于从两个或多个表中获取相关的数据。
-- 查询在SQL中用于解决从两个或多个表中检索满足特定关联条件的行的问题。当需要从多个表中提取相关数据时，通常会使用INNER JOIN。
-- 会根据指定的连接条件(通常是基于两个或多个表中的列之间的关系)来组合两个表中的行。它只返回那些在两个表中都有匹配的行，即满足连接条件的行。如果某一行在其中一个表中没有匹配的行，那么该行就不会出现在结果集中。
-- 假设有两个表，一个是employees（员工），另一个是departments（部门）。我们想获取每个员工及其所在的部门。
-- SELECT employees.name, departments.department_name FROM employees
-- INNER JOIN departments ON employees.department_id = departments.id;

-- LEFT JOIN返回左表（TABLE1）中的所有记录，以及右表（TABLE2）中匹配的记录。
-- 如果在右表中没有与左表中的某行匹配的行，则结果集中对应的列将包含NULL值。
-- 这使得LEFT JOIN在想要从主表（左表）中获取所有记录，并只获取与之相关的从表（右表）中的记录时非常有用。
-- 使用上面的employees和departments表。如果我们想获取所有员工的信息，即使某些员工没有与任何部门关联（可能是新员工或部门信息尚未输入），我们可以使用LEFT JOIN。
-- SELECT employees.name, departments.department_name FROM employees
-- LEFT JOIN departments ON employees.department_id = departments.id;
-- 在这个查询中，没有部门的员工的department_name列将显示为NULL。

SELECT e.id, e.name, COUNT(DISTINCT e2.id) AS reports_count, ROUND(AVG(e2.age)) AS average_age
FROM Employees e LEFT JOIN Employees e2 ON e.id = e2.reports_to
WHERE e.id IN (SELECT reports_to FROM Employees) GROUP BY e.id, e.name ORDER BY e.id;


-- 1789. 员工的直属部门
-- primary_flag 是一个枚举类型,值分别为('Y', 'N').如果值为'Y',表示该部门是员工的直属部门。如果值是'N',则否
CREATE TYPE primary_flag_enum AS ENUM ('Y', 'N');
Create TABLE IF NOT EXISTS Employee1 (id INT, department_id INT, primary_flag primary_flag_enum NOT NULL, PRIMARY KEY (id, department_id));

INSERT INTO Employee1 (id, department_id, primary_flag) VALUES ('1', '1', 'N');
INSERT INTO Employee1 (id, department_id, primary_flag) VALUES ('1', '2', 'N');
INSERT INTO Employee1 (id, department_id, primary_flag) VALUES ('2', '1', 'Y');
INSERT INTO Employee1 (id, department_id, primary_flag) VALUES ('2', '2', 'N');
INSERT INTO Employee1 (id, department_id, primary_flag) VALUES ('3', '3', 'N');
INSERT INTO Employee1 (id, department_id, primary_flag) VALUES ('4', '2', 'N');
INSERT INTO Employee1 (id, department_id, primary_flag) VALUES ('4', '3', 'Y');
INSERT INTO Employee1 (id, department_id, primary_flag) VALUES ('4', '4', 'N');

-- COUNT(1) 和 COUNT(*) 功能相同
-- WITH 子句(称为 Common TABLE Expressions，CTE(公共表 表达式)),临时结果集,每个 CTE 成员都是一个临时的结果集,它只在包含它的查询中有效。
-- COUNT(*) OVER (PARTITION BY id) AS cnt 窗口函数的使用,指定了一个窗口定义,它将数据分成多个分区,每个分区包含具有相同 id 值的行。窗口函数将在每个这样的分区上单独计算。
-- 这个查询将返回 Employee1 表中的所有行，但会添加一个额外的列 cnt 列，该列显示每个 id 对应的行数。这通常用于确定哪些 id 是唯一的(即 cnt 为 1 的那些)，或者用于其他需要按 id 分组进行计数的场景。
WITH cte AS (SELECT id, department_id, primary_flag, COUNT(1) OVER (PARTITION BY id) AS cnt FROM Employee1)
SELECT id, department_id FROM cte WHERE cnt = 1 OR primary_flag = 'Y';

-- 解法二:(功能等价，效率略微高一点，但是上面的易读性和重用性更好)
SELECT id, department_id
FROM (SELECT id, department_id, primary_flag, COUNT(*) OVER (PARTITION BY id) AS cnt FROM Employee1) sub WHERE cnt = 1 OR primary_flag = 'Y';


-- 610. 判断三角形
Create TABLE IF NOT EXISTS Triangle (x INT, y INT, z INT, PRIMARY KEY (x, y, z));

INSERT INTO Triangle (x, y, z) VALUES ('13', '15', '30');
INSERT INTO Triangle (x, y, z) VALUES ('10', '20', '15');
-- CASE WHEN xxxx = x THEN xxx ELSE xx END 即是 if xxxx = x { xxx } else { xx } 的句式
-- CASE xxxx WHEN x THEN xxx ELSE xx END 同上
SELECT *, CASE WHEN x + y > z AND x + z > y AND z + y > x THEN 'Yes' ELSE 'No' END AS triangle FROM triangle;


-- 1978. 上级经理已离职的公司员工
Create TABLE IF NOT EXISTS Employees1 (id INT, name VARCHAR(20), manager_id INT, salary INT, PRIMARY KEY (id));

INSERT INTO Employees1 (id, name, manager_id, salary) VALUES ('3', 'Mila', '9', '60301');
INSERT INTO Employees1 (id, name, manager_id, salary) VALUES ('12', 'Antonella', NULL, '31000');
INSERT INTO Employees1 (id, name, manager_id, salary) VALUES ('13', 'Emery', NULL, '67084');
INSERT INTO Employees1 (id, name, manager_id, salary) VALUES ('1', 'Kalel', '11', '21241');
INSERT INTO Employees1 (id, name, manager_id, salary) VALUES ('9', 'Mikaela', NULL, '50937');
INSERT INTO Employees1 (id, name, manager_id, salary) VALUES ('11', 'Joziah', '6', '28485');
-- 查找这些员工的id,他们的薪水严格少于$30000 并且他们的上级经理已离职.当一个经理离开公司时,他们的信息需要从员工表中删除掉,但是表中的员工的manager_id列还是设置的离职经理的id。
-- 子查询
SELECT id FROM employees1 WHERE salary < 30000 AND manager_id IS NOT NULL AND manager_id NOT IN (SELECT id FROM employees1) ORDER BY id;
-- 在大多数情况下，使用 LEFT JOIN 的查询会比使用子查询和 NOT IN 的查询更高效。
SELECT e1.id FROM employees1 e1 LEFT JOIN employees1 e2 on e1.manager_id = e2.id
             WHERE e1.salary < 30000 AND e1.manager_id IS NOT NULL AND e2.id IS NULL ORDER BY id;


-- 1321. 餐馆营业额变化增长
Create TABLE IF NOT EXISTS Customer1 (id INT, name VARCHAR(20), visited_on DATE, amount INT, PRIMARY KEY (id, visited_on));

INSERT INTO Customer1 (id, name, visited_on, amount) VALUES ('1', 'Jhon', '2019-01-01', '100');
INSERT INTO Customer1 (id, name, visited_on, amount) VALUES ('2', 'Daniel', '2019-01-02', '110');
INSERT INTO Customer1 (id, name, visited_on, amount) VALUES ('3', 'Jade', '2019-01-03', '120');
INSERT INTO Customer1 (id, name, visited_on, amount) VALUES ('4', 'Khaled', '2019-01-04', '130');
INSERT INTO Customer1 (id, name, visited_on, amount) VALUES ('5', 'Winston', '2019-01-05', '110');
INSERT INTO Customer1 (id, name, visited_on, amount) VALUES ('6', 'Elvis', '2019-01-06', '140');
INSERT INTO Customer1 (id, name, visited_on, amount) VALUES ('7', 'Anna', '2019-01-07', '150');
INSERT INTO Customer1 (id, name, visited_on, amount) VALUES ('8', 'Maria', '2019-01-08', '80');
INSERT INTO Customer1 (id, name, visited_on, amount) VALUES ('9', 'Jaze', '2019-01-09', '110');
INSERT INTO Customer1 (id, name, visited_on, amount) VALUES ('1', 'Jhon', '2019-01-10', '130');
INSERT INTO Customer1 (id, name, visited_on, amount) VALUES ('3', 'Jade', '2019-01-10', '150');
-- 计算以 7 天(某日期 + 该日期前的 6 天)为一个时间段的顾客消费平均值。average_amount 要保留两位小数。
-- 在 ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW 的窗口范围内计算的。这意味着对于每一行，它们都会计算包括当前行和前 6 行的数据。
WITH cte_visit AS (SELECT visited_on, SUM(amount) AS amount FROM Customer1 GROUP BY visited_on ORDER BY visited_on),
cte_avg_sale AS (SELECT visited_on, SUM(amount) OVER (ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS amount,
                        ROUND(AVG(amount) OVER (ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 2) AS average_amount,
                        ROW_NUMBER() OVER (ORDER BY visited_on) AS rn
                 FROM cte_visit ORDER BY visited_on)
SELECT visited_on, amount, average_amount FROM cte_avg_sale WHERE rn >= 7;

-- 解法二(双with操作):
-- 在SQL查询中,当你使用数字(如: 1)而不是列名时,数字指的是查询结果集中的列位置。
-- GROUP BY 1：1 指的是查询结果集中的第一列。因此，查询将根据第一列(在本例中是 cte2 c2.d，也就是 visited_on)的值进行分组。
-- ORDER BY 1 ASC：1 指的是查询结果集中的第一列。ASC 表示升序(ascending)。因此，查询结果将根据第一列的值以升序方式排序。
WITH cte1 AS (SELECT MIN(visited_on) + INTERVAL '6 days' AS md FROM customer1),
cte2 AS (SELECT DISTINCT visited_on d FROM customer1 WHERE visited_on >= (SELECT md FROM cte1))
SELECT c2.d AS visited_on, SUM(c1.amount) AS amount, ROUND(SUM(c1.amount) * 1.0 / 7, 2) AS average_amount
FROM cte2 c2 INNER JOIN customer1 c1 ON c2.d - c1.visited_on BETWEEN 0 AND 6 GROUP BY 1 ORDER BY 1 ASC;


-- 1667. 修复表中的名字
INSERT INTO Users (id, name) VALUES ('2', 'bOB');
INSERT INTO Users (id, name) VALUES ('6', 'aLice');
-- 修复名字，使得只有第一个字符是大写的，其余都是小写的。
-- SUBSTR(name, 1, 1): 字符串函数，用于从字符串name的第1个字符开始截取，截取1个字符。注意，SQL中的字符串位置是从1开始的
-- SUBSTR() 是 SUBSTRING() 的别名,功能完全相同
-- 在pgsql中 || 用于连接字符 与 CONCAT() 作用相同
SELECT id, UPPER(SUBSTR(TRIM(name), 1, 1)) || LOWER(SUBSTR(TRIM(name), 2)) AS name FROM users ORDER BY id;

-- CONCAT(): 字符串连接函数，用于将多个字符串连接成一个字符串。
-- LEFT(name, 1): 字符串函数，用于返回字符串name的左侧第一个字符。
-- SUBSTRING(name, 2): 字符串函数，用于从字符串name的第2个字符开始截取，直到字符串的末尾。注意，SQL中的字符串位置是从1开始的
SELECT id, CONCAT(UPPER(LEFT(name, 1)), LOWER(SUBSTRING(name, 2))) AS name FROM Users ORDER BY id;


-- 1527. 患某种疾病的患者
Create TABLE IF NOT EXISTS Patients (id INT, name VARCHAR(30), conditions VARCHAR(100), PRIMARY KEY (id));

INSERT INTO Patients (id, name, conditions) VALUES ('1', 'Daniel', 'YFEV COUGH');
INSERT INTO Patients (id, name, conditions) VALUES ('2', 'Alice', '');
INSERT INTO Patients (id, name, conditions) VALUES ('3', 'Bob', 'DIAB100 MYOP');
INSERT INTO Patients (id, name, conditions) VALUES ('4', 'George', 'ACNE DIAB100');
INSERT INTO Patients (id, name, conditions) VALUES ('5', 'Alain', 'DIAB201');

SELECT * FROM patients WHERE UPPER(conditions) LIKE 'DIAB1%' OR UPPER(conditions) LIKE '% DIAB1%';

-- 解法二:正则表达式
-- ~ :这是 PostgreSQL 中用于正则表达式匹配的操作符。如果 conditions 列中的值匹配给定的正则表达式，那么对应的记录就会被选中。
-- ^DIAB1：这个部分匹配任何以 "DIAB1" 开头的字符串。^ 是一个锚点，表示字符串的开始。
-- |：这是正则表达式中的 '或' 操作符，允许我们匹配多个模式中的任何一个。
-- \sDIAB1：这个部分匹配任何前面有一个空白字符(由 \s 表示，它匹配任何空白字符,如空格,制表符等)并且紧接着是 "DIAB1" 的字符串。
SELECT * FROM patients WHERE UPPER(conditions) ~ '^DIAB1|\sDIAB1';


-- 196. 删除重复的电子邮箱
Create TABLE IF NOT EXISTS Person (id INT, email VARCHAR(255), PRIMARY KEY (id));

INSERT INTO Person (id, email) VALUES ('1', 'john@example.com');
INSERT INTO Person (id, email) VALUES ('2', 'bob@example.com');
INSERT INTO Person (id, email) VALUES ('3', 'john@example.com');
-- 删除 所有重复的电子邮件,只保留一个具有最小 id 的唯一电子邮件。
DELETE FROM Person WHERE id NOT IN (SELECT MIN(id) FROM person GROUP BY email);

-- 解法二:窗口函数操作
-- 查询为 Person 表中的每行生成一个行号（row_num）。
-- ROW_NUMBER() 是一个窗口函数,用于为查询结果的每一行生成一个唯一的序列号。
-- OVER (PARTITION BY email ORDER BY id) 定义了窗口函数的分区和排序规则。数据首先根据 email 列进行分区，然后在每个分区内根据 id 列进行排序。因此，每个具有相同 email 的记录组都会从 1 开始重新编号。
DELETE FROM Person WHERE id IN (SELECT id FROM (SELECT id, ROW_NUMBER() OVER (PARTITION BY email ORDER BY id) AS rn FROM Person) s WHERE rn > 1);


-- 1484. 按日期分组销售产品
Create TABLE IF NOT EXISTS Activities (sell_date DATE, product VARCHAR(20));

INSERT INTO Activities (sell_date, product) VALUES ('2020-05-30', 'Headphone');
INSERT INTO Activities (sell_date, product) VALUES ('2020-06-01', 'Pencil');
INSERT INTO Activities (sell_date, product) VALUES ('2020-06-02', 'Mask');
INSERT INTO Activities (sell_date, product) VALUES ('2020-05-30', 'Basketball');
INSERT INTO Activities (sell_date, product) VALUES ('2020-06-01', 'Bible');
INSERT INTO Activities (sell_date, product) VALUES ('2020-06-02', 'Mask');
INSERT INTO Activities (sell_date, product) VALUES ('2020-05-30', 'T-Shirt');
-- 编写找出每个日期、销售的不同产品的数量及其名称。每个日期的销售产品名称应按词典序排列。
-- string_agg(product, ',') AS products：使用 string_agg() 函数将每个销售日期下的产品名称聚合成由逗号分隔的字符串
WITH cte AS (SELECT DISTINCT sell_date, product FROM Activities ORDER BY product)
SELECT sell_date, COUNT(DISTINCT product) AS num_sold, string_agg(product, ',') AS products FROM cte GROUP BY sell_date ORDER BY sell_date;


-- 1327. 列出指定时间段内所有的下单产品
-- Create TABLE IF NOT EXISTS Product (id INT, name VARCHAR(40), product_category VARCHAR(40), PRIMARY KEY (id));
ALTER TABLE Product ADD COLUMN product_category VARCHAR(40);
Create TABLE IF NOT EXISTS Orders (product_id INT, order_date DATE, unit INT);

INSERT INTO Product (id, name, product_category) VALUES ('11', 'Leetcode Solutions', 'Book');
INSERT INTO Product (id, name, product_category) VALUES ('12', 'Jewels of Stringology', 'Book');
INSERT INTO Product (id, name, product_category) VALUES ('13', 'HP', 'Laptop');
INSERT INTO Product (id, name, product_category) VALUES ('14', 'Lenovo', 'Laptop');
INSERT INTO Product (id, name, product_category) VALUES ('15', 'Leetcode Kit', 'T-shirt');

INSERT INTO Orders (product_id, order_date, unit) VALUES ('11', '2020-02-05', '60');
INSERT INTO Orders (product_id, order_date, unit) VALUES ('11', '2020-02-10', '70');
INSERT INTO Orders (product_id, order_date, unit) VALUES ('12', '2020-01-18', '30');
INSERT INTO Orders (product_id, order_date, unit) VALUES ('12', '2020-02-11', '80');
INSERT INTO Orders (product_id, order_date, unit) VALUES ('13', '2020-02-17', '2');
INSERT INTO Orders (product_id, order_date, unit) VALUES ('13', '2020-02-24', '3');
INSERT INTO Orders (product_id, order_date, unit) VALUES ('14', '2020-03-01', '20');
INSERT INTO Orders (product_id, order_date, unit) VALUES ('14', '2020-03-04', '30');
INSERT INTO Orders (product_id, order_date, unit) VALUES ('14', '2020-03-04', '60');
INSERT INTO Orders (product_id, order_date, unit) VALUES ('15', '2020-02-25', '50');
INSERT INTO Orders (product_id, order_date, unit) VALUES ('15', '2020-02-27', '50');
INSERT INTO Orders (product_id, order_date, unit) VALUES ('15', '2020-03-01', '50');
-- 要求获取在 2020 年 2 月份下单的数量不少于 100 的产品的名字和数目。
WITH cte AS (SELECT name AS product_name, SUM(unit) AS unit
             FROM product LEFT JOIN orders ON id = product_id WHERE order_date::text LIKE '2020-02%' GROUP BY name)
SELECT product_name, unit FROM cte WHERE unit >= 100;
-- 下面的执行效率可能会略微高一点
-- 注：这里的 SUM(unit) 虽然出现了两次，但只是计算一次
SELECT name AS product_name, SUM(unit) AS unit
FROM orders LEFT JOIN product ON id = product_id WHERE order_date::text LIKE '2020-02%' GROUP BY product_id, name HAVING SUM(unit) >= 100;


-- 1517. 查找拥有有效邮箱的用户
-- Create TABLE IF NOT EXISTS Users (id INT, name VARCHAR(30), mail VARCHAR(50), PRIMARY KEY (id));
ALTER TABLE Users ADD COLUMN mail VARCHAR(50);

INSERT INTO Users (id, name, mail) VALUES ('1', 'Winston', 'winston@leetcode.com');
INSERT INTO Users (id, name, mail) VALUES ('3', 'Annabelle', 'bella-@leetcode.com');
INSERT INTO Users (id, name, mail) VALUES ('4', 'Sally', 'sally.come@leetcode.com');
INSERT INTO Users (id, name, mail) VALUES ('5', 'Marwan', 'quarz#2020@leetcode.com');
INSERT INTO Users (id, name, mail) VALUES ('12', 'Jonathan', 'jonathanisgreat');
INSERT INTO Users (id, name, mail) VALUES ('16', 'David', 'david69@gmail.com');
INSERT INTO Users (id, name, mail) VALUES ('17', 'Shapiro', '.shapo@leetcode.com');
-- 查找具有有效电子邮件的用户。
-- 有效的电子邮件具有前缀名称和域，其中：
-- 前缀名称是字符串，可以包含字母(大写或小写),数字,下划线 '_' ,点 '.' 和 / 或 破折号 '-' 。前缀名称 必须 以字母开头。
-- 域 为 '@leetcode.com' ,其它的都不可以
-- 正则表达式的用法
SELECT * FROM users WHERE mail ~ '^[a-zA-Z][a-zA-Z0-9\_\.\-]*@leetcode\.com$';


-- 176. 第二高的薪水
Create TABLE IF NOT EXISTS Employee (id INT, salary INT, PRIMARY KEY (id));

INSERT INTO Employee (id, salary) VALUES ('11', '100');
INSERT INTO Employee (id, salary) VALUES ('12', '200');
INSERT INTO Employee (id, salary) VALUES ('13', '300');
-- 查询并返回 Employee 表中第二高的薪水。当不存在第二高的薪水,查询应该返回 null。
SELECT (SELECT salary FROM Employee GROUP BY salary ORDER BY salary DESC LIMIT 1 OFFSET 1) AS second_highest_salary;
-- 解法二:窗口函数操作
-- DENSE_RANK() 函数会赋予每个薪水一个唯一的排名，如果两个或更多的员工有相同的薪水，它们会获得相同的排名，并且下一个薪水会跳过这些排名。
-- MAX() 用于当不存在第二高的薪水时返回 null
WITH cte AS (SELECT salary, DENSE_RANK() OVER(ORDER BY salary DESC) AS dr FROM employee)
SELECT MAX(salary) AS second_highest_salary FROM cte WHERE cte.dr = 2;
-- 解法三:
SELECT MAX(salary) AS second_highest_salary FROM Employee WHERE salary < (SELECT MAX(salary) FROM Employee);


-- 570. 至少有5名直接下属的经理
-- Create TABLE IF NOT EXISTS Employees1 (id INT, name VARCHAR(255), department VARCHAR(255), manager_id INT, PRIMARY KEY (id));
ALTER TABLE Employees1 ADD COLUMN department VARCHAR(255);

INSERT INTO Employees1 (id, name, department, manager_id) VALUES ('101', 'John', 'A', NULL);
INSERT INTO Employees1 (id, name, department, manager_id) VALUES ('102', 'Dan', 'A', '101');
INSERT INTO Employees1 (id, name, department, manager_id) VALUES ('103', 'James', 'A', '101');
INSERT INTO Employees1 (id, name, department, manager_id) VALUES ('104', 'Amy', 'A', '101');
INSERT INTO Employees1 (id, name, department, manager_id) VALUES ('105', 'Anne', 'A', '101');
INSERT INTO Employees1 (id, name, department, manager_id) VALUES ('106', 'Ron', 'B', '101');
INSERT INTO Employees1 (id, name, department, manager_id) VALUES ('111', 'John', 'A', NULL);
INSERT INTO Employees1 (id, name, department, manager_id) VALUES ('112', 'Dan', 'A', '111');
INSERT INTO Employees1 (id, name, department, manager_id) VALUES ('113', 'James', 'A', '111');
INSERT INTO Employees1 (id, name, department, manager_id) VALUES ('114', 'Amy', 'A', '111');
INSERT INTO Employees1 (id, name, department, manager_id) VALUES ('115', 'Anne', 'A', '111');
INSERT INTO Employees1 (id, name, department, manager_id) VALUES ('116', 'Ron', 'B', '111');
-- 找出至少有五个直接下属的经理
SELECT name FROM Employees1 WHERE id IN (SELECT manager_id FROM Employees1 GROUP BY manager_id HAVING COUNT(id) >= 5);


-- 1934. 确认率
Create TABLE IF NOT EXISTS Signups (user_id INT, time_stamp timestamp, PRIMARY KEY (user_id));
CREATE TYPE action_type AS ENUM ('confirmed', 'timeout');
Create TABLE IF NOT EXISTS Confirmations (user_id INT, time_stamp TIMESTAMP, action action_type NOT NULL, PRIMARY KEY (user_id, time_stamp));

INSERT INTO Signups (user_id, time_stamp) VALUES ('3', '2020-03-21 10:16:13');
INSERT INTO Signups (user_id, time_stamp) VALUES ('7', '2020-01-04 13:57:59');
INSERT INTO Signups (user_id, time_stamp) VALUES ('2', '2020-07-29 23:09:44');
INSERT INTO Signups (user_id, time_stamp) VALUES ('6', '2020-12-09 10:39:37');

INSERT INTO Confirmations (user_id, time_stamp, action) VALUES ('3', '2021-01-06 03:30:46', 'timeout');
INSERT INTO Confirmations (user_id, time_stamp, action) VALUES ('3', '2021-07-14 14:00:00', 'timeout');
INSERT INTO Confirmations (user_id, time_stamp, action) VALUES ('7', '2021-06-12 11:57:29', 'confirmed');
INSERT INTO Confirmations (user_id, time_stamp, action) VALUES ('7', '2021-06-13 12:58:28', 'confirmed');
INSERT INTO Confirmations (user_id, time_stamp, action) VALUES ('7', '2021-06-14 13:59:27', 'confirmed');
INSERT INTO Confirmations (user_id, time_stamp, action) VALUES ('2', '2021-01-22 00:00:00', 'confirmed');
INSERT INTO Confirmations (user_id, time_stamp, action) VALUES ('2', '2021-02-28 23:59:59', 'timeout');
-- 用户的 确认率 是 'confirmed' 消息的数量除以请求的确认消息的总数。没有请求任何确认消息的用户的确认率为 0 。确认率四舍五入到 小数点后两位 。
-- UNION ALL 用于合并两个查询的结果集。与 UNION 不同，UNION ALL 会包含所有行，包括重复行。在这个例子中，由于两个查询不会返回相同的 user_id(第一部分只返回在 signups 但不在 confirmations 中的 user_id，而第二部分返回所有在 confirmations 中的 user_id)。
(SELECT user_id, 0.00 AS confirmation_rate FROM signups WHERE user_id NOT IN (SELECT user_id FROM confirmations))
UNION ALL
(SELECT user_id, ROUND(SUM(CASE WHEN action = 'confirmed' THEN 1 ELSE 0 END) * 1.0 / COUNT(action), 2) AS confirmation_rate
 FROM Confirmations GROUP BY user_id);

-- 解法一:
SELECT s.user_id, ROUND((SUM(CASE WHEN c.action = 'confirmed' THEN 1 ELSE 0 END) / count(*)::NUMERIC), 2) AS conFirmation_rate
FROM signups s LEFT JOIN confirmations c USING(user_id) GROUP BY s.user_id;

-- 解法二:
SELECT s.user_id, ROUND(AVG(CASE c.action WHEN 'confirmed' THEN 1 ELSE 0 END), 2) AS confirmation_rate
FROM Signups s LEFT JOIN Confirmations c USING(user_id) GROUP BY s.user_id;


-- 1193. 每月交易 I
CREATE TYPE transaction_state_type AS ENUM ('approved', 'declined');
Create TABLE IF NOT EXISTS Transactions1 (id INT, country VARCHAR(4), state transaction_state_type NOT NULL, amount INT, trans_date DATE,
                                          PRIMARY KEY (id));

INSERT INTO Transactions1 (id, country, state, amount, trans_date) VALUES ('121', 'US', 'approved', '1000', '2018-12-18');
INSERT INTO Transactions1 (id, country, state, amount, trans_date) VALUES ('122', 'US', 'declined', '2000', '2018-12-19');
INSERT INTO Transactions1 (id, country, state, amount, trans_date) VALUES ('123', 'US', 'approved', '2000', '2019-01-01');
INSERT INTO Transactions1 (id, country, state, amount, trans_date) VALUES ('124', 'DE', 'approved', '2000', '2019-01-07');
-- 查找每个月和每个国家/地区的事务数及其总金额、已批准的事务数及其总金额。
-- CASE WHEN 用法
SELECT to_char(trans_date, 'YYYY-MM') AS month, country, COUNT(id) AS trans_count,
       SUM(CASE state WHEN 'approved' THEN 1 ELSE 0 END) AS approved_count,
       SUM(amount) AS trans_total_amount, SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END) AS approved_total_amount
FROM transactions1 GROUP BY month, country;

-- 解法二:
SELECT to_char(trans_date, 'YYYY-MM') AS month, country, COUNT(id) AS trans_count,
       COUNT(*) FILTER (WHERE state = 'approved') AS approved_count, SUM(amount) AS trans_total_amount,
       COALESCE(SUM(amount) FILTER (WHERE state = 'approved'), 0) AS approved_total_amount
FROM transactions1 GROUP BY month, country;


-- 1174. 即时食物配送 II
Create TABLE IF NOT EXISTS Delivery (id INT, customer_id INT, order_date DATE, customer_pref_delivery_date DATE, PRIMARY KEY (id));

INSERT INTO Delivery (id, customer_id, order_date, customer_pref_delivery_date) VALUES ('1', '1', '2019-08-01', '2019-08-02');
INSERT INTO Delivery (id, customer_id, order_date, customer_pref_delivery_date) VALUES ('2', '2', '2019-08-02', '2019-08-02');
INSERT INTO Delivery (id, customer_id, order_date, customer_pref_delivery_date) VALUES ('3', '1', '2019-08-11', '2019-08-12');
INSERT INTO Delivery (id, customer_id, order_date, customer_pref_delivery_date) VALUES ('4', '3', '2019-08-24', '2019-08-24');
INSERT INTO Delivery (id, customer_id, order_date, customer_pref_delivery_date) VALUES ('5', '3', '2019-08-21', '2019-08-22');
INSERT INTO Delivery (id, customer_id, order_date, customer_pref_delivery_date) VALUES ('6', '2', '2019-08-11', '2019-08-13');
INSERT INTO Delivery (id, customer_id, order_date, customer_pref_delivery_date) VALUES ('7', '4', '2019-08-09', '2019-08-09');
-- 如果顾客期望的配送日期和下单日期相同，则该订单称为 「即时订单」，否则称为「计划订单」。
--「首次订单」是顾客最早创建的订单。我们保证一个顾客只会有一个「首次订单」。
-- 编写解决方案以获取即时订单在所有用户的首次订单中的比例。保留两位小数。
WITH cte AS (SELECT MIN(order_date) AS order_date, MIN(customer_pref_delivery_date) AS customer_pref_delivery_date
             FROM Delivery GROUP BY customer_id)
SELECT ROUND(SUM(CASE WHEN order_date = customer_pref_delivery_date THEN 1 ELSE 0 END)::numeric / COUNT(*) *100, 2) AS immediate_percentage FROM cte;


-- 550. 游戏玩法分析 IV
Create TABLE IF NOT EXISTS Activity2 (player_id INT, device_id INT, event_date DATE, games_played INT, PRIMARY KEY (player_id, event_date));

INSERT INTO Activity2 (player_id, device_id, event_date, games_played) VALUES ('1', '2', '2016-03-01', '5');
INSERT INTO Activity2 (player_id, device_id, event_date, games_played) VALUES ('1', '2', '2016-03-02', '6');
INSERT INTO Activity2 (player_id, device_id, event_date, games_played) VALUES ('2', '3', '2017-06-25', '1');
INSERT INTO Activity2 (player_id, device_id, event_date, games_played) VALUES ('3', '1', '2016-03-02', '0');
INSERT INTO Activity2 (player_id, device_id, event_date, games_played) VALUES ('3', '4', '2018-07-03', '5');
-- 计算在首次登录的第二天再次登录的玩家的 比率，四舍五入到小数点后两位。即需要计算从首次登录日期开始至少连续两天登录的玩家的数量，然后除以玩家总数。
-- 窗口函数操作
-- 限制相差天数为1
-- lead(, x)用于提取从当前行开始下面某x行的数据,即是得到排序后日期最相近的x条记录
-- lead(event_date, 1) OVER (PARTITION BY player_id ORDER BY event_date) AS next_date：使用LEAD窗口函数计算每个玩家下一次活动的日期。LEAD函数会查看指定偏移量的下一行。在这偏移量是1，所以它会返回下一个event_date。
-- row_number() OVER (PARTITION BY player_id ORDER BY event_date) AS rn：使用ROW_NUMBER窗口函数为每个玩家的活动分配一个行号，按照event_date排序。这样，每个玩家的第一次活动将具有行号1。
-- 可以在同一次查询中取出同一字段的前N行的数据(Lag)和后N行的数据(Lead)作为独立的列。
-- 得到首次登陆的记录，也就是按照用户ID分组后日期最小的记录
WITH cte AS (SELECT player_id, event_date, lead(event_date, 1) OVER (PARTITION BY player_id ORDER BY event_date) AS next_date,
                    row_number() OVER (PARTITION BY player_id ORDER BY event_date) AS rn FROM Activity2)
SELECT ROUND(SUM(CASE WHEN event_date + 1 = next_date THEN 1 ELSE 0 END)::numeric / COUNT(*), 2) AS fraction FROM cte WHERE rn = 1;

-- 解法二(avg):
WITH cte AS (SELECT player_id, event_date, lead(event_date, 1) OVER (PARTITION BY player_id ORDER BY event_date) AS next_date,
                    row_number() OVER (PARTITION BY player_id ORDER BY event_date) AS rn FROM Activity2)
SELECT ROUND(AVG(CASE WHEN event_date + 1 = next_date THEN 1 ELSE 0 END), 2) AS fraction FROM cte WHERE rn = 1;


-- 1045. 买下所有产品的客户
Create TABLE IF NOT EXISTS Customer2 (customer_id INT NOT NULL, product_id INT);
Create TABLE Product2 (id INT, PRIMARY KEY (id));

INSERT INTO Customer2 (customer_id, product_id) VALUES ('1', '5');
INSERT INTO Customer2 (customer_id, product_id) VALUES ('2', '6');
INSERT INTO Customer2 (customer_id, product_id) VALUES ('3', '5');
INSERT INTO Customer2 (customer_id, product_id) VALUES ('3', '6');
INSERT INTO Customer2 (customer_id, product_id) VALUES ('1', '6');

INSERT INTO Product2 (id) VALUES ('5');
INSERT INTO Product2 (id) VALUES ('6');
-- 查询 Customer 表中购买了 Product 表中所有产品的客户的 id。
WITH cte AS (SELECT customer_id, COUNT(DISTINCT product_id) AS num FROM Customer2 GROUP BY customer_id)
SELECT customer_id FROM cte WHERE num = (SELECT COUNT(*) FROM Product2);
-- 解法二:
-- 如果product2表中的产品数量是固定的，并且相对较小，那么=操作可能会更快，因为它只需要一个确切的匹配。
-- 如果product2表中的产品数量很大或者经常变动，那么IN操作可能会更灵活，因为它不需要每次产品数量变动时都重新调整查询。
SELECT customer_id FROM Customer2 GROUP BY customer_id HAVING COUNT(DISTINCT product_id) IN (SELECT COUNT(*) FROM product2);
SELECT customer_id FROM Customer2 GROUP BY customer_id HAVING COUNT(DISTINCT product_id) = (SELECT COUNT(*) FROM product2);


-- 180. 连续出现的数字
Create TABLE IF NOT EXISTS Logs (id SERIAL PRIMARY KEY, num INT);

INSERT INTO Logs (num) VALUES ('1');
INSERT INTO Logs (num) VALUES ('1');
INSERT INTO Logs (num) VALUES ('1');
INSERT INTO Logs (num) VALUES ('2');
INSERT INTO Logs (num) VALUES ('1');
INSERT INTO Logs (num) VALUES ('2');
INSERT INTO Logs (num) VALUES ('2');
-- 查询所有至少连续出现三次的数字。
SELECT DISTINCT l1.num AS consecutive_nums
FROM Logs l1, Logs l2, Logs l3 WHERE l1.id = l2.id -1 AND l2.id = l3.id -1 AND l1.num = l2.num AND l2.num = l3.num;

-- 解法二:
-- LEAD() 函数获取指定偏移量的下一个行的值，而 LAG() 函数获取指定偏移量的上一个行的值。
-- 第一个查询使用 LEAD() 函数，它查找连续三个相同的数字，这些数字是按 id 排序后的连续行中的值。
-- 第二个查询使用 LAG() 函数，它查找的是按 id 排序的连续三个行中是否有相同的数字。
WITH cte AS (SELECT id, num AS num1, LEAD(num, 1) OVER(ORDER BY id) num2, LEAD(num, 2) OVER(ORDER BY id) num3 FROM logs)
SELECT DISTINCT num1 AS consecutive_nums FROM cte WHERE num1 = num2 AND num1 = num3;

WITH cte AS (SELECT num AS num1, LAG(num, 1) OVER(ORDER BY id) AS num2, LAG(num, 2) OVER(ORDER BY id) AS num3 FROM logs)
SELECT DISTINCT num1 AS consecutive_nums FROM cte WHERE num1 = num2 AND num1 = num3;

-- 解法三(推荐):
WITH cte AS (SELECT num, (id - ROW_NUMBER() OVER(PARTITION BY num ORDER BY id)) AS rn FROM Logs)
SELECT DISTINCT num AS consecutive_nums FROM cte GROUP BY num, rn HAVING COUNT(*) >= 3;


-- 1164. 指定日期的产品价格
Create TABLE IF NOT EXISTS Products2 (product_id INT, new_price INT, change_date DATE, PRIMARY KEY (product_id, change_date));

INSERT INTO Products2 (product_id, new_price, change_date) VALUES ('1', '20', '2019-08-14');
INSERT INTO Products2 (product_id, new_price, change_date) VALUES ('2', '50', '2019-08-14');
INSERT INTO Products2 (product_id, new_price, change_date) VALUES ('1', '30', '2019-08-15');
INSERT INTO Products2 (product_id, new_price, change_date) VALUES ('1', '35', '2019-08-16');
INSERT INTO Products2 (product_id, new_price, change_date) VALUES ('2', '65', '2019-08-17');
INSERT INTO Products2 (product_id, new_price, change_date) VALUES ('3', '20', '2019-08-18');
-- 找出在 2019-08-16 时全部产品的价格，假设所有产品在修改前的价格都是 10 
WITH cte1 AS (SELECT product_id, max(change_date) AS last_date FROM Products2 WHERE change_date <= '2019-08-16' GROUP BY product_id),
cte2 AS (SELECT DISTINCT product_id FROM Products2),
cte3 AS (SELECT p.product_id, new_price FROM Products2 p INNER JOIN cte1 ON p.product_id = cte1.product_id AND p.change_date = last_date)
SELECT cte2.product_id, (CASE WHEN new_price IS NULL THEN 10 ELSE new_price END) AS price
FROM cte2 LEFT JOIN cte3 ON cte2.product_id = cte3.product_id;

-- 解法二(推荐):窗口函数
WITH cte AS (SELECT *, RANK() OVER(PARTITION BY product_id ORDER BY change_date DESC) AS rk FROM Products2 WHERE change_date <= '2019-08-16')
SELECT DISTINCT p.product_id, (CASE WHEN cte.new_price > 0 THEN cte.new_price ELSE 10 END) AS price
FROM Products2 p LEFT JOIN cte USING(product_id) WHERE cte.rk = 1 OR cte.new_price IS NULL;


-- 1204. 最后一个能进入巴士的人
Create TABLE IF NOT EXISTS Queue (person_id INT PRIMARY KEY, person_name VARCHAR(30), weight INT, turn INT);

INSERT INTO Queue (person_id, person_name, weight, turn) VALUES ('5', 'Alice', '250', '1');
INSERT INTO Queue (person_id, person_name, weight, turn) VALUES ('4', 'Bob', '175', '5');
INSERT INTO Queue (person_id, person_name, weight, turn) VALUES ('3', 'Alex', '350', '2');
INSERT INTO Queue (person_id, person_name, weight, turn) VALUES ('6', 'John Cena', '400', '3');
INSERT INTO Queue (person_id, person_name, weight, turn) VALUES ('1', 'Winston', '500', '6');
INSERT INTO Queue (person_id, person_name, weight, turn) VALUES ('2', 'Marie', '200', '4');
-- 有一队乘客在等着上巴士。然而，巴士有 1000千克 的重量限制，所以其中一部分乘客可能无法上巴士。
-- 找出 最后一个 上巴士且不超过重量限制的乘客，并报告 person_name。题目测试用例确保顺位第一的人可以上巴士且不会超重。

-- 窗口函数(window functions), 总重量排序
WITH cte AS (SELECT person_name, SUM(weight) OVER (ORDER BY turn) AS total FROM Queue ORDER BY turn)
SELECT person_name FROM cte WHERE total <= 1000 ORDER BY total DESC LIMIT 1;


-- 1907. 按分类统计薪水
Create TABLE IF NOT EXISTS Accounts (account_id INT PRIMARY KEY, income INT);

INSERT INTO Accounts (account_id, income) VALUES ('3', '108939');
INSERT INTO Accounts (account_id, income) VALUES ('2', '12747');
INSERT INTO Accounts (account_id, income) VALUES ('8', '87709');
INSERT INTO Accounts (account_id, income) VALUES ('6', '91796');
-- 查询每个工资类别的银行账户数量。 工资类别如下：
-- "Low Salary"：所有工资 严格低于 20000 美元。
-- "Average Salary"： 包含 范围内的所有工资 [$20000, $50000] 。
-- "High Salary"：所有工资 严格大于 50000 美元。
-- 结果表必须包含所有三个类别。如果某个类别中没有帐户，则报告 0 
-- UNION ALL 和 UNION 都是用于合并两个或多个 SELECT 语句的结果集的操作符,
-- UNION：它会自动去除合并结果集中的重复行。即如果两个 SELECT 语句返回的结果集中有相同的行，那么这些行在最终的 UNION 结果集中只会出现一次。
-- UNION ALL：它不会去除重复行。它会简单地合并所有 SELECT 语句的结果集，包括任何重复的行。
-- 因为 UNION 需要检查并去除重复行，所以它的性能通常比 UNION ALL 差一些。如果你确定合并的 SELECT 语句不会产生重复行，或者即使产生了重复行你也希望保留它们，那么使用 UNION ALL 通常是更好的选择，因为它避免了额外的处理步骤。
(SELECT 'Low Salary' AS category, COUNT(*) AS accounts_count FROM Accounts WHERE income < 20000)
UNION ALL
(SELECT 'Average Salary' AS category, COUNT(*) AS accounts_count FROM Accounts WHERE income BETWEEN 20000 AND 50000)
UNION ALL
(SELECT 'High Salary' AS category, COUNT(*) AS accounts_count FROM Accounts WHERE income > 50000);

-- 解法二(交叉连接):
-- (VALUES ('Low Salary'), ('Average Salary'), ('High Salary')) AS Categories(category)
-- 内联视图（或称为值列表），它创建了一个临时的单行表Categories，包含三个固定的category值：'Low Salary'、'Average Salary'和'High Salary'。
-- CROSS JOIN 将Categories子查询中的每一行与Accounts`表中的每一行进行连接，从而产生一个包含所有可能组合的临时结果集。
-- 注:一般情况尽量避免使用 CROSS JOIN, 在数据量大时相当消耗资源
-- COUNT()函数用于计算每个分组中的行数（即账户数量）。FILTER 子句用于进一步过滤这些行，只包括满足特定条件的行。
-- 在这个例子中，FILTER子句包含了一个WHERE条件，该条件根据category和income列的值来过滤行。具体地说，它检查以下条件：
-- 对于'Low Salary'类别，只计算income小于20000的账户。
-- 对于'Average Salary'类别，只计算income在20000到50000之间的账户。
-- 对于'High Salary'类别，只计算income大于50000的账户。
SELECT category, COUNT(account_id) FILTER (
    WHERE (category = 'Low Salary' AND income < 20000)
              OR (category = 'Average Salary' AND income BETWEEN 20000 AND 50000)
              OR (category = 'High Salary' AND income > 50000)) AS accounts_count
FROM (VALUES ('Low Salary'), ('Average Salary'), ('High Salary')) AS Categories(category)
    CROSS JOIN Accounts GROUP BY category;


-- 626. 换座位
Create TABLE IF NOT EXISTS Seat (id INT PRIMARY KEY, student VARCHAR(255));

INSERT INTO Seat (id, student) VALUES ('1', 'Abbot');
INSERT INTO Seat (id, student) VALUES ('2', 'Doris');
INSERT INTO Seat (id, student) VALUES ('3', 'Emerson');
INSERT INTO Seat (id, student) VALUES ('4', 'Green');
INSERT INTO Seat (id, student) VALUES ('5', 'Jeames');
-- 编写方案来交换每两个连续的学生的座位号。如果学生的数量是奇数，则最后一个学生的id不交换。按 id升序 返回结果表。
-- 若id是偶数，减1,若id是奇数，加1;问题在于当总数为奇数时，最后一个id应保持不变，加1会导致空出一位。
-- 解决此问题:找到最后一位，让它保持不变就可以了。
-- 双重 CASE WHEN 判断
SELECT (CASE WHEN id % 2 = 0 THEN id -1 ELSE (CASE WHEN id = (SELECT COUNT(DISTINCT id) FROM seat) THEN id ELSE id +1 END) END) AS id, student
FROM seat ORDER BY id;


-- 1341. 电影评分
Create TABLE IF NOT EXISTS Movies (movie_id INT PRIMARY KEY, title VARCHAR(30));
-- Create TABLE IF NOT EXISTS Users (id INT PRIMARY KEY, name VARCHAR(30));
Create TABLE IF NOT EXISTS movie_rating (movie_id INT, user_id INT, rating INT, created_at DATE, PRIMARY KEY (movie_id, user_id));

INSERT INTO Movies (movie_id, title) VALUES ('1', 'Avengers');
INSERT INTO Movies (movie_id, title) VALUES ('2', 'Frozen 2');
INSERT INTO Movies (movie_id, title) VALUES ('3', 'Joker');

INSERT INTO Users (id, name) VALUES ('21', 'Daniel');
INSERT INTO Users (id, name) VALUES ('22', 'Monica');
INSERT INTO Users (id, name) VALUES ('23', 'Maria');
INSERT INTO Users (id, name) VALUES ('24', 'James');

INSERT INTO movie_rating (movie_id, user_id, rating, created_at) VALUES ('1', '21', '3', '2020-01-12');
INSERT INTO movie_rating (movie_id, user_id, rating, created_at) VALUES ('1', '22', '4', '2020-02-11');
INSERT INTO movie_rating (movie_id, user_id, rating, created_at) VALUES ('1', '23', '2', '2020-02-12');
INSERT INTO movie_rating (movie_id, user_id, rating, created_at) VALUES ('1', '24', '1', '2020-01-01');
INSERT INTO movie_rating (movie_id, user_id, rating, created_at) VALUES ('2', '21', '5', '2020-02-17');
INSERT INTO movie_rating (movie_id, user_id, rating, created_at) VALUES ('2', '22', '2', '2020-02-01');
INSERT INTO movie_rating (movie_id, user_id, rating, created_at) VALUES ('2', '23', '2', '2020-03-01');
INSERT INTO movie_rating (movie_id, user_id, rating, created_at) VALUES ('3', '21', '3', '2020-02-22');
INSERT INTO movie_rating (movie_id, user_id, rating, created_at) VALUES ('3', '22', '4', '2020-02-25');
-- 查找评论电影数量最多的用户名。如果出现平局，返回字典序较小的用户名。
-- 查找在 February 2020 平均评分最高 的电影名称。如果出现平局，返回字典序较小的电影名称。
-- 字典序,即按字母在字典中出现顺序对字符串排序，字典序较小则意味着排序靠前。
(SELECT u.name AS results FROM users u LEFT JOIN movie_rating mr ON u.id = mr.user_id GROUP BY u.name ORDER BY COUNT(mr.movie_id) DESC, u.name LIMIT 1)
UNION ALL
(SELECT title AS results FROM movies LEFT JOIN movie_rating USING (movie_id) WHERE to_char(created_at, 'YYYY-MM') = '2020-02' GROUP BY title ORDER BY AVG(rating) DESC, title ASC LIMIT 1);


-- 602. 好友申请II：谁有最多的好友
Create TABLE IF NOT EXISTS request_accepted (requester_id INT not null, accepter_id INT null, accept_date date null, PRIMARY KEY (requester_id, accepter_id));

INSERT INTO request_accepted (requester_id, accepter_id, accept_date) VALUES ('1', '2', '2016-06-03');
INSERT INTO request_accepted (requester_id, accepter_id, accept_date) VALUES ('1', '3', '2016-06-08');
INSERT INTO request_accepted (requester_id, accepter_id, accept_date) VALUES ('2', '3', '2016-06-08');
INSERT INTO request_accepted (requester_id, accepter_id, accept_date) VALUES ('3', '4', '2016-06-09');
-- 找出拥有最多的好友的人和他拥有的好友数目。生成的测试用例保证拥有最多好友数目的只有 1 个人。
WITH cte AS ( (SELECT requester_id AS id, COUNT(*) AS num FROM request_accepted GROUP BY requester_id)
UNION ALL
(SELECT accepter_id AS id, COUNT(*) AS num FROM request_accepted GROUP BY accepter_id) )
SELECT id, SUM(num) AS num FROM cte GROUP BY id ORDER BY num DESC LIMIT 1;

-- 解法二:
WITH cte AS ( (SELECT requester_id AS id FROM request_accepted)
UNION ALL
(SELECT accepter_id AS id FROM request_accepted) )
SELECT id, COUNT(*) AS num FROM cte GROUP BY id ORDER BY num DESC LIMIT 1;


-- 585. 2016年的投资
Create TABLE IF NOT EXISTS Insurance (id INT PRIMARY KEY, tiv_2015 float, tiv_2016 float, lat float NOT NULL, lon float NOT NULL);

INSERT INTO Insurance (id, tiv_2015, tiv_2016, lat, lon) VALUES ('1', '10', '5', '10', '10');
INSERT INTO Insurance (id, tiv_2015, tiv_2016, lat, lon) VALUES ('2', '20', '20', '20', '20');
INSERT INTO Insurance (id, tiv_2015, tiv_2016, lat, lon) VALUES ('3', '10', '30', '20', '20');
INSERT INTO Insurance (id, tiv_2015, tiv_2016, lat, lon) VALUES ('4', '10', '40', '40', '40');
-- 查询 2016年 (tiv_2016) 所有满足下述条件的投保人的投保金额之和：
-- 在 2015年的投保额 (tiv_2015) 至少跟一个其他投保人在 2015 年的投保额相同。
-- 所在的城市必须与其他投保人都不同(也就是说 (lat, lon) 不能跟其他任何一个投保人完全相同)。
-- tiv_2016 四舍五入的 两位小数。
--  COUNT(id) OVER (PARTITION BY tiv_2015) 统计tiv_2015的值相同的id的数量
--  COUNT(id) OVER (PARTITION BY CONCAT(lat, lon)) 统计CONCAT(lat, lon)的值相同的id的数量
WITH cte AS (SELECT tiv_2016,
                    COUNT(id) OVER (PARTITION BY tiv_2015) AS cnt1,
                    COUNT(id) OVER (PARTITION BY CONCAT(lat, lon)) AS cnt2 FROM Insurance)
SELECT ROUND(SUM(tiv_2016)::numeric, 2) AS tiv_2016 FROM cte WHERE cnt1 > 1 AND cnt2 = 1;


-- 185. 部门工资前三高的所有员工
Create TABLE IF NOT EXISTS Employee2 (id INT PRIMARY KEY, name VARCHAR(255), salary INT, department_id INT);
Create TABLE IF NOT EXISTS Department2 (id INT PRIMARY KEY, name VARCHAR(255));

INSERT INTO Employee2 (id, name, salary, department_id) VALUES ('1', 'Joe', '85000', '1');
INSERT INTO Employee2 (id, name, salary, department_id) VALUES ('2', 'Henry', '80000', '2');
INSERT INTO Employee2 (id, name, salary, department_id) VALUES ('3', 'Sam', '60000', '2');
INSERT INTO Employee2 (id, name, salary, department_id) VALUES ('4', 'Max', '90000', '1');
INSERT INTO Employee2 (id, name, salary, department_id) VALUES ('5', 'Janet', '69000', '1');
INSERT INTO Employee2 (id, name, salary, department_id) VALUES ('6', 'Randy', '85000', '1');
INSERT INTO Employee2 (id, name, salary, department_id) VALUES ('7', 'Will', '70000', '1');

INSERT INTO Department2 (id, name) VALUES ('1', 'IT');
INSERT INTO Department2 (id, name) VALUES ('2', 'Sales');
-- 查询公司每个部门中谁赚的钱最多。一个部门的 高收入者 是指一个员工的工资在该部门的 工资中 排名前三。
-- 编写解决方案,找出每个部门中 收入高的员工。
WITH cte AS (SELECT e.id, e.name AS employee, salary, d.name AS department,
                    DENSE_RANK() OVER(PARTITION BY department_id ORDER BY salary DESC) AS drk
             FROM Employee2 e LEFT JOIN Department2 d ON e.department_id = d.id GROUP BY e.id, salary, d.name)
SELECT department, employee, salary FROM cte WHERE drk <= 3;
-- 解法二(推荐):
WITH cte AS (SELECT id, department_id, name AS employee, salary,
                    DENSE_RANK() OVER(PARTITION BY department_id ORDER BY salary DESC) AS drk FROM Employee2 GROUP BY id, salary)
SELECT d.name AS department, employee, salary FROM cte LEFT JOIN department2 d ON cte.department_id = d.id WHERE drk <= 3 ORDER BY d.id, drk;


