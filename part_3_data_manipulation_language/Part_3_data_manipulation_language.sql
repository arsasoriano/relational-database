-- Release 1
use alta_online_shop;
-- 1.a insert 5 operators to operator table
show tables;
describe operator;
insert into operator (nama,created_at) values ('Gloria Aten','2023-01-20 20:45:02');
insert into operator (nama,created_at) values ('Svanhildr Brice','2023-01-22 21:45:02');
insert into operator (nama,created_at) values ('Salud Helena','2023-01-01 20:45:02');
insert into operator (nama,created_at) values ('Asim Helene','2023-01-25 20:45:02');
insert into operator (nama) values ('Tegan Deepti');
select * from operator;

-- 1.b insert 3 product type
show tables;
insert into product_type (nama) values ('Pulsa');
insert into product_type (nama) values ('Paket data');
insert into product_type (nama) values ('Paket telefon');
select * from product_type; 

-- 1.c insert 2 product with product type id = 1 and operator id = 3
show tables;
describe product; 
insert into product (nama,price,product_type_id,operator_id) values ('Pulsa 5000','5500',1,3);
insert into product (nama,price,product_type_id,operator_id) values ('Pulsa 10000','10500',1,3);
select * from product;

-- 1.d insert 3 product with product type id = 2 and operator id = 1
show tables;
describe product; 
insert into product (nama,price,product_type_id,operator_id) values ('Paket data 6gb','60000',2,1);
insert into product (nama,price,product_type_id,operator_id) values ('Paket data 8gb','80000',2,1);
insert into product (nama,price,product_type_id,operator_id) values ('Paket data 10gb','100000',2,1);
select * from product;

-- 1.e insert 3 product with product type id = 3 and operator id = 4
show tables;
describe product; 
insert into product (nama,price,product_type_id,operator_id) values ('Paket telefon 10 menit','10000',3,4);
insert into product (nama,price,product_type_id,operator_id) values ('Paket telefon 20 menit','20000',3,4);
insert into product (nama,price,product_type_id,operator_id) values ('Paket telefon 30 menit','30000',3,4);
select * from product;

-- 1.f insert product description to all product
show tables;
describe product_description;
insert into product_description (description,product_id) 
values 
	('Paket data 2 gb dengan harga 20000',1),
    ('Paket data 4 gb dengan harga 40000',2),
    ('Pulsa dengan harga 5500',3),
    ('Pulsa dengan harga 10500',4),
    ('Paket data 6 gb dengan harga 60000',5),
    ('Paket data 8 gb dengan harga 80000',6),
    ('Paket data 10 gb dengan harga 100000',7),
    ('Paket telefon dengan harga 10000',8),
    ('Paket telefon dengan harga 20000',9),
    ('Paket telefon dengan harga 30000',10);
select * from product_description;

-- 1.g insert 3 payment method
show tables;
describe payment_method;
insert into payment_method (nama)
values
	('VA'),
    ('Transfer bank'),
    ('E money');
select * from payment_method;

-- 1.h insert 5 user to user table
describe user;
insert into user (nama,gender)
values
	('Emilia_Fabius','PEREMPUAN'),
    ('Perceval_Ilari','LAKI_LAKI'),
    ('Claribel_Atalyah','PEREMPUAN'),
    ('Amadeus_Leonhard','LAKI_LAKI'),
    ('Selahattin_Faina','PEREMPUAN');
select * from user;

-- 1.i insert 3 transaction to each user
describe transaction;
insert into transaction (user_id,payment_method_id,status)
values
	(1,1,'PENDING'),
    (1,2,'SUCCESS'),
    (1,3,'FAILED'),
    (2,2,'SUCCESS'),
    (2,1,'SUCCESS'),
    (2,3,'SUCCESS'),
    (3,3,'FAILED'),
    (3,1,'SUCCESS'),
    (3,2,'SUCCESS'),
    (4,2,'SUCCESS'),
    (5,3,'PENDING');
select * from transaction;

-- insert 3 product to each transaction
describe transaction_detail;
insert into transaction_detail (product_id,qty,price,transaction_id)
values
	(1,1,20000,1),
    (2,2,80000,3),
    (3,2,11000,3),
    (1,3,60000,2),
    (2,2,80000,2),
    (3,1,5500,2),
    (3,4,22000,1),
    (2,2,80000,1),
    (1,1,20000,3);
select * from transaction_detail;

-- 2.a Tampilkan nama user / pelanggan dengan gender Laki-laki / M.
select id, nama, gender from user u where u.gender = 'LAKI_LAKI';

-- 2.b Tampilkan product dengan id = 3.
select * from product where id = 3;

-- 2.c Tampilkan data pelanggan yang created_at dalam range 7 hari kebelakang
-- dan mempunyai nama mengandung kata ‘a’.
select * from user where created_at > date_sub(now(),interval 7 day) and nama like '%a%';

-- 2.d Hitung jumlah user / pelanggan dengan status gender Perempuan.
select count(*) as jum_gender_perempuan from user where gender = 'PEREMPUAN';

-- 2.e Tampilkan data pelanggan dengan urutan sesuai nama abjad
select * from user order by nama asc; 

-- 2.f Tampilkan 5 data transaksi dengan product id = 3
select 
	* 
from 
	transaction t 
where 
	id in 
	(select transaction_id from transaction_detail where product_id = 3) 
limit 5;

-- 3.a Ubah data product id 1 dengan nama ‘product dummy’.
update product set nama = 'product dummy' where id = 3;
select * from product;

-- 3.b Update qty = 3 pada transaction detail dengan product id 1.
update transaction_detail set qty = 3 where product_id = 1;
select * from transaction_detail;

-- 4.a Delete data pada tabel product dengan id 1.
select * from transaction_detail;
delete from transaction_detail where product_id = 1;
select * from product_description;
delete from product_description where product_id = 1;
delete from product where id = 1;
select * from product;

-- 4.b Delete pada tabel product dengan product-type id 1.
select * from product_description;
delete from product_description where id = 3;
delete from product_description where id = 4;
select * from transaction_detail where product_id between 3 and 4;
delete from transaction_detail where product_id = 3;
delete from product where product_type_id = 1;
select * from product where product_type_id = 1;

-- Release 2
-- 1 Gabungkan data transaksi dari user id 1 dan user id 2.
select 
	t.*,u.nama,u.gender 
from 
	transaction t 
left join 
	user u on u.id = t.user_id 
where 
	user_id between 1 and 2;
    
-- 2 Tampilkan jumlah harga transaksi user id 1.
select 
	 sum(price) as jumlah_harga
from 
	transaction t 
inner join 
	transaction_detail dt on t.id = dt.transaction_id 
where user_id = 1;

-- 3 Tampilkan total transaksi dengan product type 2.
select 
	count(*) as `total transaksi`
from 
	transaction_detail td 
inner join 
	product p on td.product_id = p.id
where
	p.product_type_id = 2;

-- 4 Tampilkan semua field table product dan field name table product type yang saling berhubungan.
select 
	p.*, 
    pt.nama
from 
	product p
left join 
	product_type pt on p.product_type_id = pt.id;
    
-- 5 Tampilkan semua field table transaction, field name table product dan field name table user.
select 
	t.*,
    p.nama as `nama product`,
    u.*
from 
	transaction t
left join
	user u
on
	u.id = t.user_id
left join 
	transaction_detail td 
on 
	td.transaction_id = t.id
left join
	product p
on
	p.id = td.transaction_id;
    
-- 8 Tampilkan data products yang tidak pernah ada di tabel transaction_details dengan sub-query.
select 
	td.product_id as `transaction details`,
    p.* 
from 
	transaction_detail td 
right join 
	product p 
on 
	td.product_id = p.id 
where 
	p.id 
in 
	(select id from product p2 where id !=2);



