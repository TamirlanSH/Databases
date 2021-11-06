create table dealer (
    id integer primary key ,
    name varchar(255),
    location varchar(255),
    charge float
);

INSERT INTO dealer (id, name, location, charge) VALUES (101, 'Ерлан', 'Алматы', 0.15);
INSERT INTO dealer (id, name, location, charge) VALUES (102, 'Жасмин', 'Караганда', 0.13);
INSERT INTO dealer (id, name, location, charge) VALUES (105, 'Азамат', 'Нур-Султан', 0.11);
INSERT INTO dealer (id, name, location, charge) VALUES (106, 'Канат', 'Караганда', 0.14);
INSERT INTO dealer (id, name, location, charge) VALUES (107, 'Евгений', 'Атырау', 0.13);
INSERT INTO dealer (id, name, location, charge) VALUES (103, 'Жулдыз', 'Актобе', 0.12);

create table client (
    id integer primary key ,
    name varchar(255),
    city varchar(255),
    priority integer,
    dealer_id integer references dealer(id)
);

INSERT INTO client (id, name, city, priority, dealer_id) VALUES (802, 'Айша', 'Алматы', 100, 101);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (807, 'Даулет', 'Алматы', 200, 101);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (805, 'Али', 'Кокшетау', 200, 102);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (808, 'Ильяс', 'Нур-Султан', 300, 102);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (804, 'Алия', 'Караганда', 300, 106);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (809, 'Саша', 'Шымкент', 100, 103);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (803, 'Маша', 'Семей', 200, 107);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (801, 'Максат', 'Нур-Султан', null, 105);

create table sell (
    id integer primary key,
    amount float,
    date timestamp,
    client_id integer references client(id),
    dealer_id integer references dealer(id)
);

INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (201, 150.5, '2012-10-05 00:00:00.000000', 805, 102);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (209, 270.65, '2012-09-10 00:00:00.000000', 801, 105);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (202, 65.26, '2012-10-05 00:00:00.000000', 802, 101);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (204, 110.5, '2012-08-17 00:00:00.000000', 809, 103);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (207, 948.5, '2012-09-10 00:00:00.000000', 805, 102);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (205, 2400.6, '2012-07-27 00:00:00.000000', 807, 101);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (208, 5760, '2012-09-10 00:00:00.000000', 802, 101);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (210, 1983.43, '2012-10-10 00:00:00.000000', 804, 106);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (203, 2480.4, '2012-10-10 00:00:00.000000', 809, 103);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (212, 250.45, '2012-06-27 00:00:00.000000', 808, 102);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (211, 75.29, '2012-08-17 00:00:00.000000', 803, 107);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (213, 3045.6, '2012-04-25 00:00:00.000000', 802, 101);

-- drop table client;
-- drop table dealer;
-- drop table sell;

-----------------------------------------------------------------------------
--1

--a
select * from dealer join client on dealer.id = client.dealer_id;
--b
select d, c.name, c.city, c.priority, s.id, s.date, s.amount
from dealer d
left join client c on d.id = c.dealer_id
left join sell s on c.id = s.client_id
where c.name is not null and c.city is not null and c.priority is not null
and s.id is not null and s.date is not null and s.amount is not null;
--c
select dealer, client
from dealer inner join client on client.city = dealer.location;
--d
select s.id, s.amount, c.name, c.city
from sell s inner join client c on s.client_id = c.id
where s.amount >= 100 and s.amount <= 500;
--e
select * from dealer d left join client c on d.location = c.city;
--f
select c.name, c.city, d.name, d.charge
from client c join dealer d on c.dealer_id = d.id;
--g
select c.name, c.city, d from  client c
join dealer d on dealer_id = d.id
where d.charge > 0.12;
--h
select c.name, c.city, s.id, s.date, s.amount, d.name,d.charge
from client c
join dealer d on c.dealer_id = d.id
join sell s on c.id = s.client_id;
--i
select c.name, c.priority,d.name, s.id, s.amount
from dealer d
left join client c on d.id = c.dealer_id
left join sell s on c.id = s.client_id
where s.amount >= 2000 and c.priority is not null;

--2

--a
create view t_2_a as
select s.date , COUNT(DISTINCT s.client_id), AVG(s.amount), SUM(s.amount)
from sell s
group by s.date;
drop view t_2_a ;
--b
create view t_2_b as
select s.date, s.amount
from sell s
order by s.amount desc
limit 5;
drop view t_2_b ;
--c
create view t_2_c as
select  d, COUNT(s.amount), AVG(s.amount), SUM(s.amount)
from sell s
join dealer d on d.id = s.dealer_id
GROUP BY d;
drop view t_2_c;
--d
create view t_2_d as
select d, SUM(amount * d.charge)
from sell s
join dealer d ON d.id = s.dealer_id
group by d;
drop view t_2_d;
--e
create view t_2_e as
select d.location, COUNT(s.amount), AVG(s.amount), SUM(s.amount)
from dealer d
join sell s on d.id = s.dealer_id
group by d.location;
drop view t_2_e;
--f
create view t_2_f as
select c.city, COUNT(s.amount), AVG(s.amount * (d.charge + 1)), SUM(s.amount * (d.charge + 1))
from client c
join dealer d on c.dealer_id = d.id
join sell s on c.id = s.client_id
group by c.city;
drop view t_2_f;
--g
create view t_2_g
as select c.city, sum(s.amount * (d.charge + 1)) as totalexpense, sum(s.amount) as totalamount from client c
join sell s on c.id = s.client_id
join dealer d on s.dealer_id = d.id and c.city = d.location
group by c.city;
drop view t_2_g;