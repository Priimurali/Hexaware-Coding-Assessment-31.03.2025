-- create database and use it
create database asset_management;
use asset_management;
drop database asset_management;
-- create employees table
create table employees (
    employee_id int primary key identity(1,1),
    name varchar(100) not null,
    department varchar(100) not null,
    email varchar(100) unique not null,
    password varchar(255) not null
);

-- create assets table
create table assets (
    asset_id int primary key identity(1,1),
    name varchar(100) not null,
    type varchar(50) not null,
    serial_number varchar(100) unique not null,
    purchase_date date not null,
    location varchar(100) not null,
    status varchar(50) check (status in ('in use', 'decommissioned', 'under maintenance')),
    owner_id int,
    foreign key (owner_id) references employees(employee_id) on delete set null
);

-- create maintenance records table
create table maintenance_records (
    maintenance_id int primary key identity(1,1),
    asset_id int not null,
    maintenance_date date not null,
    description text not null,
    cost decimal(10,2) not null,
    foreign key (asset_id) references assets(asset_id) on delete cascade
);

-- create asset allocations table
create table asset_allocations (
    allocation_id int primary key identity(1,1),
    asset_id int not null,
    employee_id int not null,
    allocation_date date not null,
    return_date date null,
    foreign key (asset_id) references assets(asset_id) on delete cascade,
    foreign key (employee_id) references employees(employee_id) on delete cascade
);

-- create reservations table
create table reservations (
    reservation_id int primary key identity(1,1),
    asset_id int not null,
    employee_id int not null,
    reservation_date date not null,
    start_date date not null,
    end_date date not null,
    status varchar(50) check (status in ('pending', 'approved', 'canceled')),
    foreign key (asset_id) references assets(asset_id) on delete cascade,
    foreign key (employee_id) references employees(employee_id) on delete cascade
);

