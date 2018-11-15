drop table updates;
drop table ticket_technicians;
drop table tickets;
drop table unit_technicians;
drop table unit_supervisors;
drop table users;
drop table units;
drop table hibernate_sequence;



create table hibernate_sequence (
    next_val bigint
);

insert into hibernate_sequence values ( 1000000 );

create table units (
    id          bigint primary key,
    name        varchar(255) not null unique,
    description varchar(8000),
    email       varchar(255),
    phone       varchar(255),
    location    varchar(255)
);

create table users (
    id          bigint primary key,
    type        varchar(255) default 'REGULAR',
    username    varchar(255) not null unique,
    hash        varchar(255) not null,
    enabled     boolean not null default true,
    first_name  varchar(255),
    last_name   varchar(255),
    email       varchar(255) not null unique,
    phone       varchar(255),
    department  varchar(255),
    unit_id     bigint references units(id)
);

create table unit_supervisors (
    unit_id         bigint not null references units(id),
    supervisor_id   bigint not null references users(id)
);

create table unit_technicians (
    unit_id         bigint not null references units(id),
    technician_id   bigint not null references users(id)
);

create table tickets (
    id                      bigint primary key,
    created_by              bigint not null references users(id),
    created_for_name        varchar(255),
    created_for_email       varchar(255) not null,
    created_for_phone       varchar(255),
    created_for_department  varchar(255),
    subject                 varchar(255) not null,
    details                 varchar(8000),
    location                varchar(255),
    unit_id                 bigint not null references units(id),
    priority                varchar(255) default 'MEDIUM',
    status                  varchar(255) default 'OPEN',
    date_created            datetime default now(),
    date_assigned           datetime,
    date_updated            datetime,
    date_closed             datetime
);

create table ticket_technicians (
    ticket_id       bigint not null references tickets(id),
    technician_id   bigint not null references users(id)
);

create table updates (
    id              bigint primary key,
    ticket_id       bigint references tickets(id),
    technician_id   bigint references users(id),
    details         varchar(8000),
    date            datetime
);




insert into units (id, name) values (1, 'Accounts & Password');
insert into units (id, name) values (2, 'Network Access');
insert into units (id, name) values (3, 'Computer Labs & Classroom');
insert into units (id, name) values (4, 'Software');
insert into units (id, name) values (5, 'Hardware');
insert into units (id, name) values (6, 'Library');
insert into units (id, name) values (7, 'House Keeping');
insert into units (id, name) values (8, 'International Dept');
insert into units (id, name) values (9, 'University Club');

-- All hash are bcrypt('abcd')
insert into users (id, type, username, hash, first_name, last_name, email) values
    (1, 'ADMIN', 'admin', '$2a$10$v2/oF1tdBlXxejoMszKW3eNp/j6x8CxSBURUnVj006PYjYq3isJjO',
        'System', 'Admin', 'mzuckerberg@calstate.edu');
		

insert into users (id, type, username, hash, first_name, last_name, email, unit_id) values
    (2, 'SUPERVISOR', 'bblake', '$2a$10$9PJIPq9PMYHd9L8kb66/Nuu7DDQqq29eOsVF1F8SnPZ2UfD6KC/ly',
        'Bellamy', 'Blake', 'bblake@calstate.edu', 1);
insert into users (id, type, username, hash, first_name, last_name, email, unit_id) values
    (3, 'SUPERVISOR', 'mkane', '$2a$10$9PJIPq9PMYHd9L8kb66/Nuu7DDQqq29eOsVF1F8SnPZ2UfD6KC/ly',
        'Marcus', 'Kane', 'mkane@calstate.edu', 2);
insert into users (id, type, username, hash, first_name, last_name, email, unit_id) values
    (4, 'SUPERVISOR', 'cgriffin', '$2a$10$9PJIPq9PMYHd9L8kb66/Nuu7DDQqq29eOsVF1F8SnPZ2UfD6KC/ly',
        'Clarke', 'Griffin', 'cgriffin@calstate.edu', 3);
insert into users (id, type, username, hash, first_name, last_name, email, unit_id) values
    (5, 'SUPERVISOR', 'rreyes', '$2a$10$9PJIPq9PMYHd9L8kb66/Nuu7DDQqq29eOsVF1F8SnPZ2UfD6KC/ly',
        'Raven', 'Reyes', 'rreyes@calstate.edu', 4);
insert into users (id, type, username, hash, first_name, last_name, email, unit_id) values
    (6, 'SUPERVISOR', 'mgreen', '$2a$10$9PJIPq9PMYHd9L8kb66/Nuu7DDQqq29eOsVF1F8SnPZ2UfD6KC/ly',
        'Monty', 'Green', 'mgreen@calstate.edu', 5);
insert into users (id, type, username, hash, first_name, last_name, email, unit_id) values
    (7, 'SUPERVISOR', 'tjaha', '$2a$10$9PJIPq9PMYHd9L8kb66/Nuu7DDQqq29eOsVF1F8SnPZ2UfD6KC/ly',
        'Thelonious', 'Jaha', 'tjaha@calstate.edu', 6);
insert into users (id, type, username, hash, first_name, last_name, email, unit_id) values
    (8, 'SUPERVISOR', 'jjordan', '$2a$10$9PJIPq9PMYHd9L8kb66/Nuu7DDQqq29eOsVF1F8SnPZ2UfD6KC/ly',
        'Jasper', 'Jordan', 'jjordan@calstate.edu', 7);
insert into users (id, type, username, hash, first_name, last_name, email, unit_id) values
    (9, 'SUPERVISOR', 'lemori', '$2a$10$9PJIPq9PMYHd9L8kb66/Nuu7DDQqq29eOsVF1F8SnPZ2UfD6KC/ly',
        'Lincon', 'emori', 'lemori@calstate.edu', 8);
insert into users (id, type, username, hash, first_name, last_name, email, unit_id) values
    (10, 'SUPERVISOR', 'hmiller', '$2a$10$9PJIPq9PMYHd9L8kb66/Nuu7DDQqq29eOsVF1F8SnPZ2UfD6KC/ly',
        'Harper', 'Miller', 'hmiller@calstate.edu', 9);
		
		

insert into users (id, type, username, hash, first_name, last_name, email, unit_id) values
    (11, 'TECHNICIAN', 'cjensen', '$2a$10$Q8G5BtMC.C5oonZzvBS.0usxJ2fpccf.I46pw3IGi.zorntvTSYbK',
        'Clay', 'Jensen', 'cjensen@calstate.edu', 1);
insert into users (id, type, username, hash, first_name, last_name, email, unit_id) values
    (12, 'TECHNICIAN', 'tpadilla', '$2a$10$d8lhouzPhxZ.nLCaqjh5gevTyA3tZDUMwuy2WAsWAm.i/ag/btcxe',
        'Tony', 'Padilla', 'tpadilla@calstate.edu', 2);
insert into users (id, type, username, hash, first_name, last_name, email, unit_id) values
    (13, 'TECHNICIAN', 'jdavis', '$2a$10$Q8G5BtMC.C5oonZzvBS.0usxJ2fpccf.I46pw3IGi.zorntvTSYbK',
        'Jessica', 'Davis', 'jdavis@calstate.edu', 3);
insert into users (id, type, username, hash, first_name, last_name, email, unit_id) values
    (14, 'TECHNICIAN', 'jfoley', '$2a$10$d8lhouzPhxZ.nLCaqjh5gevTyA3tZDUMwuy2WAsWAm.i/ag/btcxe',
        'Justin', 'Foley', 'jfoley@calstate.edu', 4);
insert into users (id, type, username, hash, first_name, last_name, email, unit_id) values
    (15, 'TECHNICIAN', 'bwalker', '$2a$10$d8lhouzPhxZ.nLCaqjh5gevTyA3tZDUMwuy2WAsWAm.i/ag/btcxe',
        'Bryce', 'Walker', 'bwalker@calstate.edu', 5);
insert into users (id, type, username, hash, first_name, last_name, email, unit_id) values
    (16, 'TECHNICIAN', 'astandall', '$2a$10$d8lhouzPhxZ.nLCaqjh5gevTyA3tZDUMwuy2WAsWAm.i/ag/btcxe',
        'Alex', 'Standall', 'astandall@calstate.edu', 6);
insert into users (id, type, username, hash, first_name, last_name, email, unit_id) values
    (17, 'TECHNICIAN', 'zdempsey', '$2a$10$d8lhouzPhxZ.nLCaqjh5gevTyA3tZDUMwuy2WAsWAm.i/ag/btcxe',
        'Zach', 'Dempsey', 'zdempsey@calstate.edu', 7);
insert into users (id, type, username, hash, first_name, last_name, email, unit_id) values
    (18, 'TECHNICIAN', 'tdown', '$2a$10$d8lhouzPhxZ.nLCaqjh5gevTyA3tZDUMwuy2WAsWAm.i/ag/btcxe',
        'Tyler', 'Down', 'tdown@calstate.edu', 8);
insert into users (id, type, username, hash, first_name, last_name, email, unit_id) values
    (19, 'TECHNICIAN', 'hbaker', '$2a$10$d8lhouzPhxZ.nLCaqjh5gevTyA3tZDUMwuy2WAsWAm.i/ag/btcxe',
        'Hannah', 'Baker', 'hbaker@calstate.edu', 9);
		
		
insert into users (id, type, username, hash, first_name, last_name, email, unit_id) values
    (19, 'REGULAR', 'jayv', '$2a$10$d8lhouzPhxZ.nLCaqjh5gevTyA3tZDUMwuy2WAsWAm.i/ag/btcxe',
        'Jay', 'Variya', 'jayvariya@gmail.com', null);

insert into unit_supervisors (unit_id, supervisor_id) values (1, 2);
insert into unit_supervisors (unit_id, supervisor_id) values (2, 3);
insert into unit_supervisors (unit_id, supervisor_id) values (3, 4);
insert into unit_supervisors (unit_id, supervisor_id) values (4, 5);
insert into unit_supervisors (unit_id, supervisor_id) values (5, 6);
insert into unit_supervisors (unit_id, supervisor_id) values (6, 7);
insert into unit_supervisors (unit_id, supervisor_id) values (7, 8);
insert into unit_supervisors (unit_id, supervisor_id) values (8, 9);
insert into unit_supervisors (unit_id, supervisor_id) values (9, 10);

insert into unit_technicians (unit_id, technician_id) values (2,11);
insert into unit_technicians (unit_id, technician_id) values (3,12);
insert into unit_technicians (unit_id, technician_id) values (4,13);
insert into unit_technicians (unit_id, technician_id) values (5,14);
insert into unit_technicians (unit_id, technician_id) values (6,15);
insert into unit_technicians (unit_id, technician_id) values (7,16);
insert into unit_technicians (unit_id, technician_id) values (8,17);
insert into unit_technicians (unit_id, technician_id) values (9,18);
insert into unit_technicians (unit_id, technician_id) values (10,19);