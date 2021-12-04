--1a
CREATE FUNCTION First_func(p1 INTEGER)
    RETURNS integer AS $$
BEGIN
RETURN p1 + 1;
END; $$
LANGUAGE plpgsql;
SELECT First_func(3);
--1b
CREATE FUNCTION Second_func(p1 INTEGER, p2 INTEGER)
    RETURNS integer AS $$
BEGIN
RETURN p1 + p2;
END; $$
LANGUAGE plpgsql;
SELECT Second_func(4, 7);
--1c
CREATE FUNCTION Third_func(p1 INTEGER)
    RETURNS BOOLEAN AS $$
BEGIN
IF p1 % 2 = 0 THEN
    RETURN TRUE;
ELSE
    RETURN FALSE;
END IF;
END; $$
LANGUAGE plpgsql;
SELECT Third_func(4);
DROP FUNCTION Third_func(p1 INTEGER);
--1d
CREATE FUNCTION Fourth_func(p1 VARCHAR(30))
    RETURNS BOOLEAN AS $$
BEGIN
    IF p1 == 'password1' THEN
        RETURN TRUE;
    ELSE RETURN FALSE;
    end if;
END; $$
LANGUAGE plpgsql;
--1e
CREATE FUNCTION Fifth_func(p1 INTEGER, OUT s1 INTEGER, OUT s2 INTEGER)
    AS $$
BEGIN
s1:= p1 * 2;
s2:= p1 * 3;
END; $$
LANGUAGE plpgsql;
SELECT Fifth_func(10);

--2a
CREATE TABLE emp (
    empname text,
    last_date timestamp
);

CREATE FUNCTION emp_stamp() RETURNS trigger AS $$
    BEGIN

        NEW.last_date := current_timestamp;
        RETURN NEW;
    END;$$
LANGUAGE plpgsql;

CREATE TRIGGER emp_stamp BEFORE INSERT OR UPDATE ON emp
    FOR EACH ROW EXECUTE FUNCTION emp_stamp();
--2b
CREATE TABLE emp2 (
    empname text,
    birth_date timestamp,
    age INTERVAL
);

CREATE FUNCTION emp_stamp2() RETURNS trigger AS $$
    BEGIN

        UPDATE emp2
        SET age = AGE(current_time, birth_date)
        WHERE birth_date <> '0-0-0';
        RETURN NEW;
    END;$$
LANGUAGE plpgsql;

CREATE TRIGGER emp_stamp2 AFTER INSERT OR UPDATE ON emp2
    FOR EACH ROW EXECUTE FUNCTION emp_stamp2();

INSERT INTO emp2 (empname, birth_date)
VALUES ('MEME', '2011-06-24');

select * FROM emp2;

DROP TRIGGER  emp_stamp2 ON emp2;
Drop FUNCTION emp_stamp2();
DROP TABLE emp2;

SELECT AGE(current_date,'2011-06-24');

--3
--What is the difference between procedure and function?
--The main functional difference between a function and a stored procedure is that a function returns a result,
-- whereas a stored procedure does not.
-- This is because the intention behind a stored procedure is to perform some sort of activity and then finish,
-- which would then return control to the caller.

--4a
CREATE TABLE Task4ab (
    id INTEGER PRIMARY KEY,
    name varchar,
    date_of_birth date,
    age INTEGER,
    salary INTEGER,
    workexperince INTEGER,
    discount INTEGER
);

select * FROM Task4ab;

INSERT INTO Task4ab(id, name, date_of_birth, age, salary, workexperince, discount)
VALUES (1, 'Mike', '2000-03-22', age(current_date, date_of_birth), 60000, 10, 1);

CREATE PROCEDURE First_proc() AS $$
    BEGIN
        UPDATE Task4ab
        SET salary = salary + salary * 0.1,
            discount = discount + 10
        WHERE workexperince >= 2;

        UPDATE Task4ab
        SET discount = discount + 1
        WHERE workexperince >= 5;

    END;$$
LANGUAGE plpgsql;