create table customers (
    id integer primary key,
    name varchar(255),
    birth_date date
);

create table accounts(
    account_id varchar(40) primary key ,
    customer_id integer references customers(id),
    currency varchar(3),
    balance float,
    "limit" float
);

create table transactions (
    id serial primary key ,
    date timestamp,
    src_account varchar(40) references accounts(account_id),
    dst_account varchar(40) references accounts(account_id),
    amount float,
    status varchar(20)
);

INSERT INTO customers VALUES (201, 'John', '2021-11-05');
INSERT INTO customers VALUES (202, 'Anny', '2021-11-02');
INSERT INTO customers VALUES (203, 'Rick', '2021-11-24');

INSERT INTO accounts VALUES ('NT10204', 201, 'KZT', 1000, null);
INSERT INTO accounts VALUES ('AB10203', 202, 'USD', 100, 0);
INSERT INTO accounts VALUES ('DK12000', 203, 'EUR', 500, 200);
INSERT INTO accounts VALUES ('NK90123', 201, 'USD', 400, 0);
INSERT INTO accounts VALUES ('RS88012', 203, 'KZT', 5000, -100);

INSERT INTO transactions VALUES (1, '2021-11-05 18:00:34.000000', 'NT10204', 'RS88012', 1000, 'commited');
INSERT INTO transactions VALUES (2, '2021-11-05 18:01:19.000000', 'NK90123', 'AB10203', 500, 'rollback');
INSERT INTO transactions VALUES (3, '2021-06-05 18:02:45.000000', 'RS88012', 'NT10204', 400, 'init');

--LABORATORY WORK 7
--1
--SQL provides large-object data types for character data (clob) and binary data (blob).
--blob: binary large object - object is a large collection of uninterpreted binary data (whose interpretation is left to an application outside of the database system)
--clob: character large object - object is a large collection of character data
--When a query returns a large object, a pointer is returned rather than the large object itself.

--2
--Privilege - type of authorization, that allows chosen users to modify data
--A Role - is a way to distinguish among various users as far as what these users can access/update in the database.
--User -the one who sees the database data, having different possibilities for changes in dependence on privileges
--2a
create role accountant;
grant select, update  on transactions, accounts, customers to accountant;
create role administrator;
grant all privileges  on transactions, accounts, customers to administrator;
create role support;
grant select  on transactions, accounts, customers to support;
--2b
create user user_1;
grant accountant to user_1;
create user user_2;
grant accountant to user_2;
create user user_3;
grant administrator to user_3;
create user user_4;
grant administrator to user_4;
create user user_5;
grant support to user_5;
create user user_6;
grant support to user_6;
--2c
alter role user_4 CREATEROLE;
--2d
revoke update on accounts, customers, transactions from user_1;

--3a
--Teacher said that we don't learn it on the lecture
--3b
ALTER table transactions
alter column src_account SET not null,
alter column dst_account SET not null;

--4
--Teacher said that we don't learn it on the lecture

--5a
create unique index five_a on accounts (customer_id, currency);
--5b
create index five_b on accounts(currency, balance);

--6
BEGIN;
UPDATE accounts SET balance = balance - 400 WHERE account_id = 'RS88012';
SAVEPOINT sp1;
UPDATE accounts SET balance = balance + 400 WHERE account_id = 'NT10204';
ROLLBACK to sp1;
COMMIT;