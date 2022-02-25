---Çalýþma sorularý:

--Brazil'de bulunan müþterilerin þirket adý,temsilciadý,adres,þehir,ülke bilgilerini  döndürürün. 
select CompanyName,ContactName,[address],City,Country
from 
Customers
where Country='Brazil'
order by  CompanyName

select CompanyName,ContactName,[address],city,Country
from 
Customers
where 
Country !='Brazil'
order by  CompanyName

Select CompanyName,Country
from Customers
where Country='Spain' or Country ='France'or Country ='Germany'
order by Country

select  CompanyName
from 
Customers 
where Fax is null 
order by CompanyName

--Londra yada parsite bulunan müþterilerimi bulun ... 
select CompanyName,ContactName,City,Country
from 
Customers
where City ='London' or City ='Paris'
--hem mexico d.f  'de ikamet edecek. Hmde ContactTitle Bilgisi 'owner'olan müþterileri getirin.

--C ile baþlayan ürünlerin fiyatlarý  ve isimlerini .
Select CompanyName,ContactName,Address,City,Country
from 
Customers
where  City ='México D.F.' and  ContactTitle='Owner'

--Adý (FirstName )' a' harfi ile baþlayan çalýþanlarýmýn adý,soyad, doðumtarihini .
select FirstName,LastName,BirthDate
from 
Employees 
where 
FirstName like 'A%'

--Ýsminde 'Resturant'geçen miþterilermin þirket isimleri 
select CompanyName 
from 
Customers
where  CompanyName like '%restaurant%' 

--50$ dolar ile 100$ dolara araqsýnda bulunan ürünlerin adlarý ve fiyatlarý ... .. 
select ProductName,UnitPrice
from 
Products 
where 
UnitPrice between 50 and 100

--1Temmuz1996 ile 31 aralýk 1996 tarhileri arasýndaki sipariþlerin siparis_.id ve sipariþtarhilerini gösterin .... 
select OrderID,OrderDate
from Orders
where OrderDate between '1996-07-01' and'1996-12-31'

--Müþterilermizi ülkeye göre sýralýyalým ...
select distinct Country ,CompanyName
from 
Customers
order by Country asc

select ProductName,UnitPrice
from Products
order by UnitPrice desc

--ürünlerimi en pahalýdan en ucuza doðru sýlayýnýz.Ama stoklarýný küçükten büyüðe doðru gösteriniz .ürün adý vefiyatý basýnýz. 
select ProductName,UnitPrice,UnitsInStock
from
Products
order by UnitPrice desc ,UnitsInStock asc;

--1Numaralý kategoride kaç ürün vardýr. 
select  COUNT(*)  ProductName
from 
Products 
where CategoryID =1 

--En pahalý 5 ürün 
select top 5 productName,UnitPrice
from 
products
order by unitprice

--Ürünlerin toplam maliyetini 
Select Sum (unitprice*Quantity)
from
[Order Details]

--Þirketim nekadar  cirosu vardýr. 
select  sum (unitprice*quantity*(1-Discount)) as totalCiro
from [Order Details]

--Ortalama ürün fiyatýný 
select Avg(unitPrice) ortalamaurunfiyat
from
Products

--EN UCUZ ÜRÜN ADI  GELSÝN  (iç-içe)
Select ProductName,UnitPrice
from Products
where UnitPrice=(select Min(unitprice)
from Products)

--En az kazandýran sipariþ 
select top 1  OrderID,sum(UnitPrice*Quantity) as [en az getirisi olan sipariþ ]
from 
[Order Details]
group by OrderID 
order by [en az getirisi olan sipariþ ] asc

--Müþterilerin içinde en uzun isme sahip olan müþteri (harf sayýsýný.)
--Len()
select 
top 1 CompanyName, len(CompanyName) as isimunzunlu
from
Customers
order by isimunzunlu

--ÇAIÞANLARIN AD SOYAD VE YAÞLARINI GÖSTERÝN 
select 
FirstName as isim,LastName as soyad,DATEDIFF(Year,BirthDate,GETDATE()) as Yas
from Employees

--Hangi ÜRÜNDEN TOPLAM KAÇ ADET ALINMIÞ 
select OrderId,Sum(Quantity) as [Toplam siparis Tutar]
from [Order Details]
group by OrderID 
order by [Toplam siparis Tutar] desc

--Hangi sipariþte toplam nekadar kazanmýþým.
select  OrderID ,Sum(Quantity*UnitPrice) as maliyet
from [Order Details]
group by OrderID
order by  maliyet desc

--Hangi kategoride toplam kaç adet ürn bulunuyor..
select CategoryID ,COUNT(CategoryId) as ToplamUrunsayisi
from 
Products
group by CategoryID

--1000 Adetten fazla satýlan ürünler?
select ProductID,Sum(Quantity) as toplamsiparismiktari 
from  [Order Details]
group by  ProductID
having sum (Quantity)>1000 

--Hangi Müþterilerim hiç sipariþ vermemiþdir?
select   CompanyName
from Customers
where CustomerID not in (select distinct  CustomerID from 
Orders)

--Hangi Ürün hangi kategoride.
select CategoryName,ProductName
from
Categories c inner join Products p 
on 
c.CategoryID=p.CategoryID

--Hangi tedarikçi hangi ürününü saðlýyor.
select CompanyName as supplier ,ProductName as product 
from 
Suppliers s inner join Products p 
on s.SupplierID = p.SupplierID

--Hangi sipariþ hangi kargo þirketi ile ne zaman gönderildiðinin bilgisini veren sql cümleciðiniz yazýnýz?
select CompanyName as firma ,OrderID as siparis ,ShippedDate as tarih 
from Shippers s inner join  Orders o 
on 
s.ShipperID=o.ShipVia

--sql trigger çalýþma sorularý--

--Hangi sipariþi hangi müþteri vermiþ hangi çalýþan almýþ hangi tarihte ,hangi kargo þirketi tarafýndan gönderilmiþ hangi üründenkaç adet alýnmýþ,hangi fiyattan alýnmýþ ürün hangi kategoride,bu ürünü hangi tedarikçi saðlamýþ

use Northwind
select * from Customers c inner join Orders o
on c.CustomerID=o.CustomerID
inner join Employees e on o.EmployeeID=e.EmployeeID
inner join Shippers sh on sh.ShipperID=o.ShipVia
inner join [Order Details] od on od.OrderID=o.OrderID
inner join Products p on od.ProductID=p.ProductID
inner join Categories ct on p.CategoryID=ct.CategoryID
inner join Suppliers sp on sp.SupplierID=p.SupplierID
order by o.OrderID asc








