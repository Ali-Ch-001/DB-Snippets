/* 21L-6003 Lab3*/
CREATE DATABASE L216003Lab3

create table hotel(
hotelno varchar(10) primary key,
hotelname varchar(20),
city varchar(20),
)

insert into hotel values('fb01', 'Grosvenor', 'London');
insert into hotel values('fb02', 'Watergate', 'Paris');
insert into hotel values('ch01', 'Omni Shoreham', 'London');
insert into hotel values('ch02', 'Phoenix Park', 'London');
insert into hotel values('dc01', 'Latham', 'Berlin');

 -- create a table named hotel

 create table room(

roomno numeric(5),
hotelno varchar(10),
type varchar(10),
price decimal(5,2),
primary key (roomno, hotelno),
foreign key (hotelno) REFERENCES hotel(hotelno)
)


insert into room values(501, 'fb01', 'single', 19);
insert into room values(601, 'fb01', 'double', 29);
insert into room values(701, 'fb01', 'family', 39);
insert into room values(1001, 'fb02', 'single', 58);
insert into room values(1101, 'fb02', 'double', 86);
insert into room values(1001, 'ch01', 'single', 29.99);
insert into room values(1101, 'ch01', 'family', 59.99);
insert into room values(701, 'ch02', 'single', 10);
insert into room values(801, 'ch02', 'double', 15);
insert into room values(901, 'dc01', 'single', 18);
insert into room values(1001, 'dc01', 'double', 30);
insert into room values(1101, 'dc01', 'family', 35);

create table guest(
guestno numeric(5),
guestname varchar(20),
guestaddress varchar(50),
primary key (guestno)
)

insert into guest values(10001, 'John Kay', '56 High St, London');
insert into guest values(10002, 'Mike Ritchie', '18 Tain St, London');
insert into guest values(10003, 'Mary Tregear', '5 Tarbot Rd, Aberdeen');
insert into guest values(10004, 'Joe Keogh', '2 Fergus Dr, Aberdeen');
insert into guest values(10005, 'Carol Farrel', '6 Achray St, Glasgow');
insert into guest values(10006, 'Tina Murphy', '63 Well St, Glasgow');
insert into guest values(10007, 'Tony Shaw', '12 Park Pl, Glasgow');

create table booking(
hotelno varchar(10),
guestno numeric(5),
datefrom date,
dateto date,
roomno numeric(5),
primary key (hotelno, guestno, datefrom),
foreign key (roomno, hotelno) REFERENCES room(roomno, hotelno),
foreign key (guestno) REFERENCES guest(guestno)
)

 

insert into booking values('fb01', 10001, '04-04-01', '04-04-08', 501);
insert into booking values('fb01', 10004, '04-04-15', '04-05-15', 601);
insert into booking values('fb01', 10005, '04-05-02', '04-05-07', 501);
insert into booking values('fb01', 10001, '04-05-01', null, 701);
insert into booking values('fb02', 10003, '04-04-05', '10-04-04', 1001);
insert into booking values('ch01', 10006, '04-04-21', null, 1101);
insert into booking values('ch02', 10002, '04-04-25', '04-05-06', 801);
insert into booking values('dc01', 10007, '04-05-13', '04-05-15', 1001);
insert into booking values('dc01', 10003, '04-05-20', null, 1001);



SELECT *
FROM hotel
where city like '%London%'
ORDER by hotelname DESC


SELECT *
FROM hotel
where hotelname like '__t%'


SELECT *
FROM booking
where dateto IS NULL

SELECT guestname, guestaddress
FROM guest
WHERE guestaddress Like '%Glasgow%'
AND (guestname Like 'Tony%' OR guestname Like '%Farrel');

 

SELECT DISTINCT roomno,hotelno
FROM booking
WHERE Year(datefrom) >=2005 AND Year(datefrom) <=2010
OR Year(dateto) >=2005 AND Year(dateto) <=2010



SELECT roomno,hotelno
FROM room
WHERE roomno = 1001
  AND type = 'single'
  AND (price>= 20.0 OR price<= 40.0);



SELECT roomno, hotelno,price
FROM room
WHERE price = (SELECT MAX(price) FROM room);


SELECT CONCAT('The hotel whose id is ', hotelno, ' is in ', city, ' and its name is ', hotelname, '.') AS hotel_info
FROM hotel


SELECT ('The hotel whose id is '+ hotelno +' is in ' + city+ ' and its name is '+ hotelname + '.' ) AS hotel_info
FROM hotel


SELECT room.hotelno,type,hotelname,city
FROM room
join hotel on (hotel.hotelno = room.hotelno)
WHERE type = 'double' OR type = 'family'


SELECT DISTINCT hotelname,type
FROM hotel
INNER JOIN room ON ( room.hotelno = hotel.hotelno)
WHERE type IN ('single', 'double')
  AND room.hotelno NOT IN (SELECT room.hotelno FROM room WHERE type = 'family');




SELECT DISTINCT room.roomno , type , price , room.hotelno , guestno
FROM room
INNER JOIN booking on (booking.hotelno = room.hotelno)
WHERE guestno IN (10003, 10007)
  AND guestno NOT IN (SELECT guestno FROM booking WHERE guestno = 10001);
