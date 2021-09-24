create table customers(
    id integer PRIMARY KEY,
    full_name varchar(50) NOT NULL,
    timestamp timestamp NOT NULL ,
    delivery_address text NOT NULL
);

create table products(
    id varchar PRIMARY KEY,
    name varchar(50) UNIQUE NOT NULL ,
    description text,
    price double precision NOT NULL CHECK (price > 0 )
);

create table orders(
    code integer PRIMARY KEY ,
    customer_id integer ,
    total_sum double precision NOT NULL ,
    is_paid boolean NOT NULL ,
    foreign key(customer_id) references customers(id)
);

create table order_items(
    order_code integer,
    product_id varchar,
    quantity integer NOT NULL,
    foreign key (order_code) references orders(code),
    foreign key (product_id) references products(id)
);



create table students(
    full_student_name varchar(50) PRIMARY KEY,
    age smallint NOT NULL ,
    birth_date date NOT NULL ,
    gender varchar(10) NOT NULL ,
    average_grade numeric(2,1) NOT NULL ,
    information_about_ourself text,
    the_need_for_a_dormitory boolean NOT NULL ,
    additional_info text
);
create table instructors(
    full_instructor_name varchar(50) PRIMARY KEY ,
    speaking_languages text NOT NULL ,
    work_experience smallint NOT NULL ,
    the_possibility_of_having_remote_lessons boolean NOT NULL
);
create table lesson_participants(
    lesson_title varchar(50) NOT NULL ,
    teaching_instructor varchar(50) NOT NULL ,
    studying_students varchar(50) NOT NULL ,
    room_number smallint NOT NULL ,
    foreign key (teaching_instructor) references instructors(full_instructor_name),
    foreign key (studying_students) references students(full_student_name)
);

insert into customers
    values (27, 'AibekLOL', 'January 28 18:01:15 2027', 'Gashinin, 44');

update order_items
    set quantity = quantity + 5
    where quantity < 20;

delete from order_items where quantity > 10;