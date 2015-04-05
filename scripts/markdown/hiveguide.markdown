% Hive Guide by Treasure Data
% @treasuredata

# HiveQL Overview

This document was prepared by [Treasure Data, Inc.](http://www.treasuredata.com). If you don't want to run your own Hive cluter, [check us out](http://www.treasuredata.com).

## About Apache Hive

The Hive query language (HiveQL) is the primary data processing method for Treasure Data. HiveQL is powered by [Apache Hive](http://hive.apache.org/). [Treasure Data](http://www.treasuredata.com/) is a cloud data platform that allows users to collect, store, and analyze their data on the cloud. Treasure Data manages its own Hadoop cluster, which accepts queries from users and executes them using the Hadoop MapReduce framework. HiveQL is one of the languages it supports.

## Hive Example Query Catalog

If you're looking for dozens of HiveQL templates, please visit Treasure Data's example query catalog page.

[HiveQL Example Query Catalog](https://examples.treasuredata.com/)

1. [E-Commerce](https://examples.treasuredata.com/queries?tag=E-commerce)
2. [Gaming](https://examples.treasuredata.com/queries?tag=E-commerce)
3. [Web Logs](https://examples.treasuredata.com/queries?tag=Web+Logs)
4. [Point of Sale](https://examples.treasuredata.com/queries?tag=PoS+%28Point+of+Sale%29)

## SELECT Statement Syntax

Here's the syntax of Hive's SELECT statement.

```sql
SELECT [ALL | DISTINCT] select_expr, select_expr, ...
FROM table_reference
[WHERE where_condition]
[GROUP BY col_list]
[HAVING having_condition]
[CLUSTER BY col_list | [DISTRIBUTE BY col_list] [SORT BY col_list]]
[LIMIT number]
```

SELECT is the projection operator in SQL. The points are:

* `SELECT` scans the table specified by the `FROM` clause
* `WHERE` gives the condition of what to filter
* `GROUP BY` gives a list of columns which specify how to aggregate the records
* `CLUSTER BY`, `DISTRIBUTE BY`, `SORT BY` specify the sort order and algorithm
* `LIMIT` specifies how many # of records to retrieve

### Computing with Columns

When you select the columns, you can manipulate column values using either arithmetic operators or function calls. Math, date, and string functions are popular.

* [List of Arithmetic Operators](#arithmetic-operators)
* [List of Functions](#hive-functions)

Here's an example query that uses both operators and functions.

```sql
SELECT upper(name), sales_cost FROM products
``` 

### WHERE Clauses

A `WHERE` clause is used to filter the result set by using *predicate operators* and *logical operators*. Functions can also be used to compute the condition.

* [List of Predicate Operators](#predicate-operators)
* [List of Logical Operators](#logical-operators)
* [List of Functions](#hive-functions)

Here's an example query that uses a WHERE clause.

```sql
SELECT name FROM products WHERE name = 'stone of jordan';
```

### GROUP BY Clauses

A `GROUP BY` clause is frequently used with *aggregate functions*, to group the result set by columns and apply aggregate functions over each group. Functions can also be used to compute the grouping key.

* [List of Aggregate Functions](#hive-aggregate-functions)
* [List of Functions](#hive-functions)

Here's an example query that groups and counts by category.

```sql
SELECT category, count(1) FROM products GROUP BY category;
```

### HAVING Clauses

A `HAVING` clause lets you filter the groups produced by `GROUP BY`, by applying *predicate operators* to each groups.

* [List of Predicate Operators](#predicate-operators)

Here's an example query that groups and counts by category, and then retrieves only counts > 10;

```sql
SELECT category, count(1) AS cnt FROM products GROUP BY category HAVING cnt > 10;
```

### Example Queries

Here are some basic examples. The underlying table consists of three fields: `ip`, `url`, and `time`.

```sql
--Number of Records
SELECT COUNT(1) FROM www_access;

--Number of Unique IPs
SELECT COUNT(1) FROM ( \
  SELECT DISTINCT ip FROM www_access \
) t;

--Number of Unique IPs that Accessed the Top Page
SELECT COUNT(distinct ip) FROM www_access \
  WHERE url='/';

--Number of Accesses per Unique IP
SELECT ip, COUNT(1) FROM www_access \
  GROUP BY ip LIMIT 30;

--Unique IPs Sorted by Number of Accesses
SELECT ip, COUNT(1) AS cnt FROM www_access \
  GROUP BY ip
  ORDER BY cnt DESC LIMIT 30;

--Number of Accesses After a Certain Time
SELECT COUNT(1) FROM www_access \
  WHERE TD_TIME_RANGE(time, "2011-08-19", NULL, "PDT")

--Number of Accesses Each Day
SELECT \
  TD_TIME_FORMAT(time, "yyyy-MM-dd", "PDT") AS day, \
  COUNT(1) AS cnt \
FROM www_access \
GROUP BY TD_TIME_FORMAT(time, "yyyy-MM-dd", "PDT")
```

[TD_TIME_RANGE UDF](https://docs.treasuredata.com/articles/udfs#tdtimerange) is simple and efficient to use. Please refer to the Performance Tuning section for more information.

NOTE: The `time` column is a special column that is always present and stores the UNIX timestamp of the log.

## INSERT Statement Syntax

Here's the syntax of Hive's INSERT statement.

```sql
INSERT OVERWRITE TABLE tablename1 select_statement1 FROM from_statement;
INSERT INTO TABLE tablename1 select_statement1 FROM from_statement;
```

* INSERT OVERWRITE will overwrite any existing data in the table.
* INSERT INTO will append to the table, keeping the existing data intact.
* If record doesn't include `time` column, `time` column is imported [TD_SCHEDULED_TIME()](http://docs.treasuredata.com/articles/udfs#tdscheduledtime).
* If record includes `time` column, `time` coulmn should be Unixtime.

NOTE: Query doesn't allow multiple inserts.

# Hive Built-in Operators

This article lists all built-in operators supported by Hive 0.10.0 (CDH 4.3.1).

## Predicate Operators {#predicate-operators}

  Operator                  Types                 Description
  ------------------------- --------------------- -------------------------------------------------------------
  A = B                     All primitive types   TRUE if expression A is equal to expression B otherwise FALSE
  A \<=\> B                 All primitive types   Returns same result with EQUAL(=) operator for non-null operands,
                                                  but returns TRUE if both are NULL, FALSE if one of the them is
                                                  NULL (as of version 0.9.0)
  A == B                    None!                 Fails because of invalid syntax. SQL uses =, not ==
  A \<\> B                  All primitive types   NULL if A or B is NULL, TRUE if expression A is NOT equal to
                                                  expression B otherwise FALSE
  A != B                    All primitive types   A synonym for the \<\> operator
  A \< B                    All primitive types   NULL if A or B is NULL, TRUE if expression A is less than
                                                  expression B otherwise FALSE
  A \<= B                   All primitive types   NULL if A or B is NULL, TRUE if expression A is less than or
                                                  equal to expression B otherwise FALSE
  A \> B                    All primitive types   NULL if A or B is NULL, TRUE if expression A is greater than
                                                  expression B otherwise FALSE
  A \>= B                   All primitive types   NULL if A or B is NULL, TRUE if expression A is greater than or
                                                  equal to expression B otherwise FALSE
  A [NOT] BETWEEN B AND C   All primitive types   NULL if A, B or C is NULL, TRUE if A is greater than or equal to
                                                  B AND A less than or equal to C otherwise FALSE. This can be
                                                  inverted by using the NOT keyword. (as of version 0.9.0)
  A IS NULL                 all types             TRUE if expression A evaluates to NULL otherwise FALSE
  A IS NOT NULL             All types             FALSE if expression A evaluates to NULL otherwise TRUE
  A [NOT] LIKE B            strings               NULL if A or B is NULL, TRUE if string A matches the SQL simple
                                                  regular expression B, otherwise FALSE. The comparison is done
                                                  character by character. The \_ character in B matches any character
                                                  in A(similar to . in posix regular expressions) while the % character
                                                  in B matches an arbitrary number of characters in A(similar to .\* in
                                                  POSIX regular expressions) e.g. 'foobar' like 'foo' evaluates to FALSE
                                                  where as 'foobar' like 'foo\_ \_ \_' evaluates to TRUE and so does
                                                  'foobar' like 'foo%'
  A [NOT] RLIKE B           strings               NULL if A or B is NULL, TRUE if any (possibly empty) substring of A
                                                  matches the Java regular expression B, otherwise FALSE.
                                                  E.g. 'foobar' RLIKE 'foo' evaluates to FALSE whereas 'foobar' RLIKE
                                                  '\^f.\*r\$' evaluates to TRUE.
  A REGEXP B                strings               Same as RLIKE


## Arithmetic Operators {#arithmetic-operators}

  Operator   Types     Description
  ---------- --------- --------------------------------------------------------------------------------------------------
  A + B      Numbers   Gives the result of adding A and B. The type of the result is the same as the common parent
                       (in the type hierarchy) of the types of the operands. e.g. since every integer is a float,
                       therefore float is a containing type of integer so the + operator on a float and an int will result
                       in a float.
  A - B      Numbers   Gives the result of subtracting B from A. The type of the result is the same as the common parent
                       (in the type hierarchy) of the types of the operands.
  A \* B     Numbers   Gives the result of multiplying A and B. The type of the result is the same as the common parent
                       (in the type hierarchy) of the types of the operands. Note that if the multiplication causing overflow,
                       you will have to cast one of the operators to a type higher in the type hierarchy.
  A / B      Numbers   Gives the result of dividing B from A. The result is a double type.
  A % B      Numbers   Gives the reminder resulting from dividing A by B. The type of the result is the same as the common
                       parent(in the type hierarchy) of the types of the operands.
  A & B      Numbers   Gives the result of bitwise AND of A and B. The type of the result is the same as the common parent
                       (in the type hierarchy) of the types of the operands.
  A | B      Numbers   Gives the result of bitwise OR of A and B. The type of the result is the same as the common parent
                       (in the type hierarchy) of the types of the operands.
  A \^ B     Numbers   Gives the result of bitwise XOR of A and B. The type of the result is the same as the common parent
                       (in the type hierarchy) of the types of the operands.
  \~A        Numbers   Gives the result of bitwise NOT of A. The type of the result is the same as the type of A.

## Logical Operators {#logical-operators}

  Operator                   Types   Description
  -------------------------  ------- -------------------------------------------------------------------------------------
  A AND B                    boolean TRUE if both A and B are TRUE, otherwise FALSE. NULL if A or B is NULL
  A && B                     boolean Same as A AND B
  A OR B                     boolean TRUE if either A or B or both are TRUE; FALSE OR NULL is NULL; otherwise FALSE
  A || B                     boolean Same as A OR B
  NOT A                      boolean TRUE if A is FALSE or NULL if A is NULL. Otherwise FALSE.
  ! A                        boolean Same as NOT A
  A IN (val1, val2, ...)     boolean TRUE if A is equal to any of the values
  A NOT IN (val1, val2, ...) boolean TRUE if A is not equal to any of the values

## Operators for Complex Types

  Operator   Types                           Description
  ---------- ------------------------------- -----------------------------------------------------------------------------
  A[n]       A is an Array and n is an int   Returns the nth element in the array A. The first element has index 0
                                             e.g. if A is an array comprising of ['foo', 'bar'] then A[0] returns 'foo'
                                             and A[1] returns 'bar'.
  M[key]     M is a Map and key has type K   Returns the value corresponding to the key in the map e.g. if M is a map
                                             comprising of {'f' -\> 'foo', 'b' -\> 'bar', 'all' -\> 'foobar'} then M['all']
                                             returns 'foobar'
  S.x        S is a struct                   Returns the x field of S. e.g for struct foobar {int foo, int bar}
                                             foobar.foo returns the integer stored in the foo field of the struct.

# Hive Built-in Functions {#hive-functions}

This article lists all built-in functions supported by Hive 0.10.0 (CDH 4.3.1).

## Mathematical Functions

  Return Type   Name(Signature)                    Description
  ------------- ---------------------------------- --------------------------------------------------------------------------
  double        round(double a)                    Returns the rounded BIGINT value of the double
  double        round(double a, int d)             Returns the double rounded to d decimal places
  bigint        floor(double a)                    Returns the maximum BIGINT value that is equal or less than the double
  bigint        ceil(double a)                     Returns the minimum BIGINT value that is equal or greater than the double
                ceiling(double a)  
  double        rand(), rand(int seed)             Returns a random number (that changes from row to row) that is distributed
                                                   uniformly from 0 to 1. Specifiying the seed will make sure the generated
                                                   random number sequence is deterministic.
  double        exp(double a)                      Returns e^a^ where e is the base of the natural logarithm
  double        ln(double a)                       Returns the natural logarithm of the argument
  double        log10(double a)                    Returns the base-10 logarithm of the argument
  double        log2(double a)                     Returns the base-2 logarithm of the argument
  double        log(double base, double a)         Return the base "base" logarithm of the argument
  double        pow(double a, double p)            Return a^p^
                power(double a, double p) 
  double        sqrt(double a)                     Returns the square root of a
  string        bin(bigint a)                      Returns the number in binary format (see [here](http://dev.mysql.com/doc/refman/5.0/en/string-functions.html#function_bin))
  string        hex(bigint a) hex(string a)        If the argument is an int, hex returns the number as a string in hex format.
                                                   Otherwise if the number is a string, it converts each character into its hex
                                                   representation and returns the resulting string. (see [here](http://dev.mysql.com/doc/refman/5.0/en/string-functions.html#function_hex))
  string        unhex(string a)                    Inverse of hex. Interprets each pair of characters as a hexidecimal number
                                                   and converts to the character represented by the number.
  string        conv(bigint num, int from, int to) Converts a number from a given base to another (see [here](http://dev.mysql.com/doc/refman/5.0/en/mathematical-functions.html#function_conv))
                conv(STRING num, int from, int to)
  double        abs(double a)                      Returns the absolute value
  int double    pmod(int a, int b)                 Returns the positive value of a mod b
                pmod(double a, double b)           Returns the positive value of a mod b
  double        sin(double a)                      Returns the sine of a (a is in radians)
  double        asin(double a)                     Returns the arc sin of x if -1\<=a\<=1 or null otherwise
  double        cos(double a)                      Returns the cosine of a (a is in radians)
  double        acos(double a)                     Returns the arc cosine of x if -1\<=a\<=1 or null otherwise
  double        tan(double a)                      Returns the tangent of a (a is in radians)
  double        atan(double a)                     Returns the arctangent of a
  double        degrees(double a)                  Converts value of a from radians to degrees
  double        radians(double a)                  Converts value of a from degrees to radians
  int double    positive(int a)                    Returns a
                positive(double a) 
  int double    negative(int a)                    Returns -a
                negative(double a)
  float         sign(double a)                     Returns the sign of a as '1.0' or '-1.0'
  double        e()                                Returns the value of e
  double        pi()                               Returns the value of pi

## Collection Functions

  Return Type   Name(Signature)                      Description
  ------------- ------------------------------------ -------------------------------------------------------------------------
  int           size(Map\<K.V\>)                     Returns the number of elements in the map type
  int           size(Array\<T\>)                     Returns the number of elements in the array type
  array\<K\>    map\_keys(Map\<K.V\>)                Returns an unordered array containing the keys of the input map
  array\<V\>    map\_values(Map\<K.V\>)              Returns an unordered array containing the values of the input map
  boolean       array\_contains(Array\<T\>, value)   Returns TRUE if the array contains value
  array\<t\>    sort\_array(Array\<T\>)              Sorts the input array in ascending order according to the natural ordering
                                                     of the array elements and returns it

## Type Conversion Functions

  Return Type                     Name(Signature)          Description
  ------------------------------- ------------------------ -------------------------------------------------------------------
  binary                          binary(string|binary)    Casts the parameter into a binary
  Expected "=" to follow "type"   cast(expr as \<type\>)   Converts the results of the expression expr to \<type\>
                                                           e.g. cast('1' as BIGINT) will convert the string '1' to it integral
                                                           representation. A null is returned if the conversion does not
                                                           succeed.

## Date Functions
  Return Type   Name(Signature)                                    Description
  ------------- -------------------------------------------------- -----------------------------------------------------------
  string        from\_unixtime(bigint unixtime[, string format])   Converts the number of seconds from unix epoch (1970-01-01
                                                                   00:00:00 UTC) to a string representing the timestamp of that
                                                                   moment in the current system time zone in the format of
                                                                   "1970-01-01 00:00:00"
  bigint        unix\_timestamp()                                  Gets current time stamp using the default time zone.
  bigint        unix\_timestamp(string date)                       Converts time string in format `yyyy-MM-dd HH:mm:ss` to
                                                                   Unix time stamp, return 0 if fail:
                                                                   `unix\_timestamp('2009-03-20 11:30:01') = 1237573801`
  bigint        unix\_timestamp(string date, string pattern)       Convert time string with given pattern (see [here](http://docs.oracle.com/javase/8/docs/api/java/text/SimpleDateFormat.html))
                                                                   to Unix time stamp, return 0 if fail:
                                                                   `unix_timestamp('2009-03-20', 'yyyy-MM-dd') = 1237532400`
  string        to\_date(string timestamp)                         Returns the date part of a timestamp string:
                                                                   `to\_date("1970-01-01 00:00:00") = "1970-01-01"`
  int           year(string date)                                  Returns the year part of a date or a timestamp string:
                                                                   1. `year("1970-01-01 00:00:00") = 1970`
                                                                   2. `year("1970-01-01") = 1970`
  int           month(string date)                                 Returns the month part of a date or a timestamp string:
                                                                   1. `month("1970-11-01 00:00:00") = 11`
                                                                   2. `month("1970-11-01") = 11`
  int           day(string date) dayofmonth(date)                  Return the day part of a date or a timestamp string:
                                                                   1. `day("1970-11-01 00:00:00") = 1`
                                                                   2. `day("1970-11-01") = 1`
  int           hour(string date)                                  Returns the hour of the timestamp:
                                                                   1. `hour('2009-07-30 12:58:59') = 12`
                                                                   2. `hour('12:58:59') = 12`
  int           minute(string date)                                Returns the minute of the timestamp
  int           second(string date)                                Returns the second of the timestamp
  int           weekofyear(string date)                            Return the week number of a timestamp string:
                                                                   1. `weekofyear("1970-11-01 00:00:00") = 44`
                                                                   2. `weekofyear("1970-11-01") = 44`
  int           datediff(string enddate, string startdate)         Return the number of days from startdate to enddate:
                                                                   `datediff('2009-03-01', '2009-02-27') = 2`
  string        date\_add(string startdate, int days)              Add a number of days to startdate:
                                                                   `date_add('2008-12-31', 1) = '2009-01-01'`
  string        date\_sub(string startdate, int days)              Subtract a number of days to startdate:
                                                                   `date_sub('2008-12-31', 1) = '2008-12-30'`
  timestamp     from\_utc\_timestamp(timestamp, string timezone)   Assumes given timestamp is UTC and converts to
                                                                   given timezone
  timestamp     to\_utc\_timestamp(timestamp, string timezone)     Assumes given timestamp is in given timezone and
                                                                   converts to UTC
## Conditional Functions

The `T` below represents any type (i.e., these functions are generic).

  Return Type   Name(Signature)                                              Description
  ------------- ------------------------------------------------------------ -------------------------------------------------
  T             if(boolean testCondition, T valueTrue, T valueFalseOrNull)   Return valueTrue when testCondition is true,
                                                                             returns valueFalseOrNull otherwise
  T             COALESCE(T v1, T v2, ...)                                    Return the first v that is not NULL,
                                                                             or NULL if all v's are NULL
  T             CASE a WHEN b THEN c [WHEN d THEN e]\* [ELSE f] END          When a = b, returns c; when a = d,
                                                                             return e; else return f
  T             CASE WHEN a THEN b [WHEN c THEN d]\* [ELSE e] END            When a = true, returns b; when c = true,
                                                                             return d; else return e

# Hive Built-in Aggregate Functions {#hive-aggregate-functions}

This article lists all built-in aggregate functions (UDAF) supported by Hive 0.10.0 (CDH 4.3.1).

## Aggregate Functions (UDAF)

  Return Type                 Name(Signature)                                                 Description
  --------------------------- --------------------------------------------------------------- --------------------------------
  bigint                      count(\*), count(expr), count(DISTINCT expr[, expr\_.])         **count(\*)** - Returns the total number of
                                                                                              retrieved rows, including rows containing
                                                                                              NULL values;
                                                                                              **count(expr)** - Returns the number of rows
                                                                                              for which the supplied expression is
                                                                                              non-NULL;
                                                                                              **count(DISTINCT expr[, expr])** - Returns
                                                                                              the number of rows for which the supplied
                                                                                              expression(s) are unique and non-NULL.
  double                      sum(col), sum(DISTINCT col)                                     Returns the sum of the elements in the group
                                                                                              or the sum of the distinct values of the
                                                                                              column in the group
  double                      avg(col), avg(DISTINCT col)                                     Returns the average of the elements in
                                                                                              the group or the average of the distinct
                                                                                              values of the column in the group
  double                      min(col)                                                        Returns the minimum of the column
                                                                                              in the group
  double                      max(col)                                                        Returns the maximum value of the column
                                                                                              in the group
  double                      variance(col), var\_pop(col)                                    Returns the variance of a numeric column
                                                                                              in the group
  double                      var\_samp(col)                                                  Returns the unbiased sample variance of
                                                                                              a numeric column in the group
  double                      stddev\_pop(col)                                                Returns the standard deviation of a
                                                                                              numeric column in the group
  double                      stddev\_samp(col)                                               Returns the unbiased sample standard deviation
                                                                                              of a numeric column in the group
  double                      covar\_pop(col1, col2)                                          Returns the population covariance of a pair of
                                                                                              numeric columns in the group
  double                      covar\_samp(col1, col2)                                         Returns the sample covariance of a pair of a
                                                                                              numeric columns in the group
  double                      corr(col1, col2)                                                Returns the Pearson coefficient of correlation of
                                                                                              a pair of a numeric columns in the group
  double                      percentile(BIGINT col, p)                                       Returns the exact p^th^ percentile of a column in
                                                                                              the group (does not work with floating
                                                                                              point types). p must be between 0 and 1.
                                                                                              NOTE: A true percentile can only be computed
                                                                                              for integer values.
                                                                                              Use PERCENTILE\_APPROX if your input
                                                                                              is non-integral.
  array\<double\>             percentile(BIGINT col, array(p~1~ [, p~2~]...))                 Returns the exact percentiles p~1~, p~2~, ... of
                                                                                              a column in the group (does not work
                                                                                              with floating point types). p~i~ must be
                                                                                              between 0 and 1.
                                                                                              NOTE: A true percentile can only be computed
                                                                                              for integer values.
                                                                                              Use PERCENTILE\_APPROX if your input
                                                                                              is non-integral.
  double                      percentile\_approx(DOUBLE col, p [, B])                         Returns an approximate p^th^ percentile of a
                                                                                              numeric column (including floating point types)
                                                                                              in the group. The B parameter controls
                                                                                              approximation accuracy at the cost of memory.
                                                                                              Higher values yield better approximations,
                                                                                              and the default is 10,000.  When the number
                                                                                              of distinct values in col is smaller than B,
                                                                                              this gives an exact percentile value.
  array\<double\>             percentile\_approx(DOUBLE col, array(p~1~ [, p~2~]...) [, B])   Same as above, but accepts and returns an array
                                                                                              of percentile values instead of a single one.
  array\<struct {'x','y'}\>   histogram\_numeric(col, b)                                      Computes a histogram of a numeric column
                                                                                              in the group using b non-uniformly spaced
                                                                                              bins.  The output is an array of size b of
                                                                                              double-valued (x,y) coordinates that represent
                                                                                              the bin centers and heights.
  array                         collect\_set(col)                                             Returns a set of objects with duplicate elements
                                                                                              eliminated


# Further Resources

## Hive Syntax Checker

If you would like to experiment with the Hive SQL syntax, we made our
Hive Syntax linter publicly available [here](https://sql.treasuredata.com).

## Official Online Docs

Here are the official Hive tutorial and language manual.

* [The official Hive tutorial](https://cwiki.apache.org/confluence/display/Hive/Tutorial) covers the basics of HiveQL.
* [The official Hive language manual](https://cwiki.apache.org/confluence/display/Hive/LanguageManual) covers all features of HiveQL.
