create database wallet;

use wallet;

create table personWallet(
personId int primary key ,
remain decimal(10,2) not null check (remain >=0),
personPass varchar(255)  not null ,
personName nvarchar(50) not null
);
create table payment(
paymentId  int auto_increment primary key,
personId int not null,
paymentDate datetime default current_timestamp,
paymentValue decimal(10,2) not null check (paymentValue > 0),
constraint fk_payment_person
foreign key (personId) references personWallet(personId)

);