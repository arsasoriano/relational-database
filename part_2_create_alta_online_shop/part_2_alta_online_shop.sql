create database alta_online_shop;
use alta_online_shop;

create table user (
	id int not null auto_increment,
	nama varchar(255) not null,
	gender enum('LAKI_LAKI', 'PEREMPUAN'),
	created_at datetime default now(),
	updated_at datetime default now(),
	primary key (id)
);

create table operator (
	id int not null auto_increment,
	nama varchar(255) not null,
	created_at datetime default now(),
	updated_at datetime default now(),
	primary key (id)
);

create table product_type (
	id int not null auto_increment,
	nama varchar(255) not null,
	created_at datetime default now(),
	updated_at datetime default now(),
	primary key (id)
);

create table product (
	id int not null auto_increment,
	nama varchar(255) not null,
	price int not null,
	product_type_id int not null,
	operator_id int not null,
	created_at datetime default now(),
	updated_at datetime default now(),
	primary key (id),
	foreign key (product_type_id) references product_type(id),
	foreign key (operator_id) references operator(id)
);

create table product_description (
	id int not null auto_increment,
	description mediumtext not null,
	product_id int not null,
	created_at datetime default now(),
	updated_at datetime default now(),
	primary key (id),
	foreign key (product_id) references product(id)
);

create table payment_method(
	id int not null auto_increment,
	nama varchar(255) not null,
	created_at datetime default now(),
	updated_at datetime default now(),
	primary key (id)
);

create table transaction (
	id int not null auto_increment,
	user_id int not null,
	payment_method_id int not null,
	status enum('PENDING', 'SUCCESS', 'FAILED'),
	created_at datetime default now(),
	updated_at datetime default now(),
	primary key (id),
	foreign key (user_id) references user(id),
	foreign key (payment_method_id) references payment_method(id)
);

create table transaction_detail (
	id int not null auto_increment,
	product_id int not null,
	qty int not null,
	price int not null,
	transaction_id int not null,
	created_at datetime default now(),
	updated_at datetime default now(),
	primary key (id),
	foreign key (transaction_id) references transaction(id),
	foreign key (product_id) references product(id)
);

show tables;




