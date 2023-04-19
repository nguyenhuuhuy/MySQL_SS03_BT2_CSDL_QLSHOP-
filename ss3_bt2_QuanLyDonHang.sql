create database java10_md4_ss3_bt2_QuanLyBang;
use java10_md4_ss3_bt2_QuanLyBang;
create table Customer(
cID int auto_increment primary key,
Name varchar(25),
cAge tinyint
);

create table Orders(
oID int auto_increment primary key,
cID int,
oDate datetime,
oTotalPrice int,
foreign key(cID) references Customer(cID)
);

create table Product (
pID int auto_increment primary key,
pName varchar(25),
pPrice int
);

create table OrderDetail (
oID int,
pID int,
odQTY int,
primary key(oID,pID),
foreign key(oID) references Orders(oID),
foreign key(pID) references Product(pID)
);

insert into Customer(Name, cAge) values
('Minh Quan',10),
('Ngoc Oanh',20),
('Hong Ha',50);

insert into Orders(cID,oDate) values
(1,'2006/03/21'),
(2,'2006/03/23'),
(1,'2006/03/16');

insert into Product (pName,pPrice) values
('May Giat',3),
('Tu Lanh',5),
('Dieu Hoa',7),
('Quat',1),
('Bep Dien',2);

insert into orderDetail (oID,pID,odQTY) values
(1,1,3),
(1,3,7),
(1,4,2),
(2,1,1),
(3,1,8),
(2,5,4),
(2,3,3);

-- Hiển thị các thông tin  gồm oID, oDate, oPrice của tất cả các hóa đơn trong bảng Order
select oID,oDate,oTotalPrice from Orders;  
-- Hiển thị danh sách các khách hàng đã mua hàng, và danh sách sản phẩm được mua bởi các khách
select customer.Name , product.pName,orderdetail.odQTY
from customer
join orders on customer.cID = orders.cID
join orderdetail on orders.oID = orderdetail.oID
join product on product.pID = orderdetail.pID;

-- Hiển thị tên những khách hàng không mua bất kỳ một sản phẩm nào 
select customer.Name
from customer
where not exists (select orders.cID from orders where customer.cID = orders.cID);
-- Hiển thị mã hóa đơn, ngày bán và giá tiền của từng hóa đơn (giá một hóa đơn được tính bằng tổng giá bán của từng loại mặt hàng xuất hiện trong hóa đơn. Giá bán của từng loại được tính = odQTY*pPrice)

select orders.oID, orders.oDate, concat(orderdetail.odQTY * product.pPrice) as Total
from (((customer
join orders on customer.cID = orders.cID)
join orderdetail on orders.oID = orderdetail.oID)
join product on product.pID = orderdetail.pID)
order by oID ASC;