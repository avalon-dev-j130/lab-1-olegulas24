/*
 * TODO(Студент): Опишите процесс создания базы данных
 * 1. Создайте все таблицы, согласно предложенной диаграмме.
 * 2. Опишите все необходимые отношения между таблицами.
 * 3. Добавьте в каждую таблицу минимум три записи.
 */
create table Roles 
(
    id int not null unique
        generated always as
        identity(start with 1, increment by 1),
    name varchar(255)  not null primary key 
);

create table UsersInfo 
(
    id int not null primary key
        generated always as
        identity(start with 1, increment by 1),
    name varchar(255) not null,
    surname varchar(255) not null
);

create table Users
(
    id int not null unique
        generated always as
        identity(start with 1, increment by 1),
    email varchar(255)  not null primary key,
    password varchar(255) not null,
    info int not null unique
        references UsersInfo(id),
    role int references Roles(id)
);

create table Orders
(
    id int not null primary key
        generated always as
        identity(start with 1, increment by 1),
    users int not null 
        references Users(id),
    created timestamp not null 
);

create table Suppliers 
(
    id int not null unique
        generated always as
        identity(start with 1, increment by 1),
    name varchar(255) not null primary key,
    address varchar(255),
    phone varchar(255) not null,
    representative varchar(255)
);

create table Products 
(
    id int not null unique
        generated always as
        identity(start with 1, increment by 1),
    code varchar(255) not null primary key,
    title varchar(255),
    supplier int not null 
        references Suppliers(id),
    initial_price double not null,
    retail_value double not null
);

create table Order2Products 
(
    orders int not null 
        references Orders(id),
    products int not null
        references Products(id)
);

insert into Roles(name) 
       values('Кассир'),('Директор'),('Продавец');

insert into UsersInfo(name, surname) 
       values('Василий', 'Васильев'),('Иван', 'Иванов'),('Петр', 'Петров');

insert into Users(email, password, info, role) 
       values('vas@mail.ru', '123456', 1, 1),('ivan@mail.ru', '123456', 2, 1),('pet@mail.ru', '123456', 3, 3);

insert into Suppliers(name, address, phone, representative) 
       values('Роман', 'Какая-то улица1', '111', 'ОАО'),('Стас', 'Какая-то улица2', '222', 'ПАО'),('Илья', 'Какая-то улица3', '333', 'ЗАО');

insert into Products(code, title, supplier, initial_price, retail_value) 
       values('111', 'Рыба', 1, 245, 275),('222', 'Мясо', 2, 270, 300),('333', 'Молоко', 3, 45, 58);

insert into Orders(users, created) 
       values(1, '2020-01-24 10:00:00'),(2, '2020-01-24 09:00:00'),(3, '2020-01-24 11:00:00');

insert into Order2Products(orders, products) 
       values(1, 1),(1,2),(3,1);