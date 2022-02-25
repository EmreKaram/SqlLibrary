--Sp (Stored Procedure) 


--Genel özellikler: 

--Normal sorgulardan daha hýzlý çalýþýr.
--Çünkü normal sorgular  execute edilerken "Execute plan "iþlemi yapýlýr. Bu iþlem sýrasýnda hangi tablodan veri çekilce hangi kolondan veri çekilcek ,hangi kolondan gelecek,bunlar nerden gelecek.
---Bir sorgu her çalýþtýrýldýðýnda bu iþlemler yukarýda bahsettiðim gibi devam eder.ve siz her her execute ettiðinizde bu iþlemler tekrarlanýr.
---Fakat sorgularýnýzý store procedure olarak  çalýþtýrýsanýz. Bu execuýte plan denilen iþlem sadece bir kere yapýlýr ve buda ilk çalýþma zamanýnda olur.
--Diðer .alýþmalarda bu iþlemler yapýlmaz.
--Bundan dolayý hýz performans artýþý saðlanýr..
--Ýçerisinde select ,insert ,update ,delete iþlemlerini yapabilirisiniz.
--iç içe kullanabilirisiniz.
--içlerinde function 'lar oluþturulabilir.
--Sorgularýmýzýn dýþardan alacaðý deðerler parametre olarak  store procedure'lere geçirilebildiðinden dolayý sorgularýmýzýn "sql injection " yemelerinin önüne geçilmiþ olur.Bu yönüyle de güvenlidir. 
--Stored Procedure fiziksel bir veri tabaný nesnesidir. Bu neden le create komutu ile oluþturulur.
--Fziksel olarak ilgli veri tabanýna "Programmbility"=>>>>"Stored Procedure " kombinasyonu ile eriþebilirsiniz.
--Taslak---
--Create  proc yada procedure [isim]
--(
--varsa parametreler. 

--)As
--Yazýlacak sorgu,kodlar,þartlar,fonksiyonlar,komutlar

Create proc sp_ornek
(
@Id int --Aksi belirtilmedi sürece bu yapýnýn parametre yapýsý inputtur.
)As

select * from Employees where EmployeeID =@Id

--Dikkat 
--Prosedürün parametrelerinin tanýmlarken parantez kullanmak zorunlu deðidlidr. 
--Ama baþlagýnçta okunabilirliði arttýrmak için kullanmanýz önerilir. 

Create Proc sp_Ornek2
@Id int,
@Parametre2 int ,
@Parametre3  nvarchar(max)
as 
select * from Employees where EmployeeID =@Id

--Stored Procedures Kullanýmý

--Stored procedure yapýlarýnýn "exec" komutu ile çalýþtýrabilrirsiniz.

exec sp_ornek 3

exec sp_Ornek2 5,80,'Bilge Adam '
----==Geriye deðer döndüren Stored Procedure yapýsý.

Create proc  UrunGetir 
(
@Fiyat money 

)
As
select * from Products where UnitPrice>@Fiyat 

return @@Rowcount --Yukarýda yapýlan iþlemde kaç satýr eklendiðini bize döndürecek.

exec UrunGetir 90
---Bu þekilde  geriye dönülen deðeri elde etmeksiniz kullanabilisin.

Declare @sonuc int 
exec @sonuc= UrunGetir 50
print  cast(@sonuc as nvarchar(max))+'Adet kadar ürün bu iþlemden etkilendi...' 
--Yukarýda  yapýlan iþlem neticeisnde dönen deðeri  deðiþken üzerine aktardýk print ile bastýk. Nvarchar cast ettik.

---==Output ile deðer döndürme==
create proc sp_ornek3
(
@Id int,
@Adi nvarchar(Max)  output, --output parametere içerisindeki deðeri dýþarý göndermek için kullanýlýr.
@Soyadi nvarchar(max) output

)
as 
select 
@Adi=FirstName, @Soyadi=LastName 
from 
Employees  where EmployeeID =@Id

--Kullanýmý 

Declare @Adi nvarchar (max),@Soyadi nvarchar(max)

exec sp_ornek3 3,@Adi output ,@Soyadi output

select @Adi+' '+@Soyadi

create proc sp_ornek4
(
@Fiyat money,
@Adi nvarchar(Max)  output --output parametere içerisindeki deðeri dýþarý göndermek için kullanýlýr.
)
as 
select 
@Adi=ProductName
from 
Products  where UnitPrice >  @Fiyat
Declare @Adi nvarchar (max)
exec sp_ornek4 50,@Adi output 
select @Adi

create proc sp_category

(@unitPrice money, 
@categoryName nvarchar(max) output
)
as
select @categoryName = CategoryName 
from Products
join Categories C
on C.CategoryID = ProductID
where Products.UnitPrice > @unitPrice

declare @category nvarchar(max)
exec sp_category 50, @category output
select @category

--Örnek: 
--Dýþarýdan aldðý isim soyisim ve sehir bilgilerini Personller tablosundaki ilgili kolonlara ekleyen  stored Procedure yazýnýz.

create Proc sp_PersonelEkle
(
@Ad nvarchar (Max),
@Soyad nvarchar (max),
@sehir nvarchar(max)
)
as

insert Employees (FirstName,LastName,City) values ( @Ad,@Soyad,@sehir)

exec sp_PersonelEkle 'AHMET','DENÝZ','Ankara'

select * from Employees


--==Parametrelere Varsayýlan deðer atama==

Create Proc sp_personelEkle2
(
@Ad nvarchar (Max) ='test',
@Soyad nvarchar(Max)='test',
@Sehir nvarchar(Max)='test'
)
as 
insert Employees(FirstName,LastName,City)values (@Ad,@Soyad,@Sehir)

exec sp_PersonelEkle 

--PRODUCT TABLOSUNA üRÜN ADI ,FÝYATI _CATEGORY ÝD BÝLGÝLERÝNÝ EKLEYEN BÝR SP YAZINIZ.

CREATE PROCEDURE [Urunekle]
--create proc
(
@UrunAd nvarchar (20),
@BirimFiyat money ,
@KatId int 
)
as 

insert Products(ProductName,UnitPrice,CategoryID)
values (@UrunAd,@BirimFiyat,@KatId)
EXEC Urunekle 'Ananas',3,11
execute Urunekle 'portakal',5,11
Urunekle 'portakal',5,11
--Parametre isimlerini biliyorsanýz ,Bu þekilde sýrayý öenmsemeden doldurabilirisiniz.
exec Urunekle @KatId=5,@UrunAd='test',@BirimFiyat=3 

--Ayný parametreleri ve productId parametresini kullanarak ürünleri update etmek için bir sp yazýnýz.

Create proc UrunGuncelle

(
@UrunAd nvarchar(20),@BirimFiyat money,@KatId int ,@UrunId int
)
as

	Update Products
	set ProductName =@UrunAd ,UnitPrice =@BirimFiyat,CategoryID =@KatId
	where ProductID=@UrunId

exec UrunGuncelle 'Ceviz',4,8,82

select * from Categories

insert Categories (CategoryName) values('Others')

create Proc KategoriKontrolluUrunEkleme
(@Ad nvarchar(50),@fiyat money,@KatId int ,@Stok int)
as
declare @enBuyukKatId int
select  @enBuyukKatId= MAX(CategoryID) from Categories
if @enBuyukKatId<@KatId
	begin 
		print'Girdiðiniz deðerde kategori bulunmadýðý için kategori idsi 12 olarak others adanýndaki categori olarak düzenlendi..'
		set @KatId=12
	end	

	insert Products (ProductName,UnitPrice,CategoryID,UnitsInStock) 
	values(@Ad,@fiyat,@KatId,@Stok)

--Çalýþtýrma Kýsmý 

exec KategoriKontrolluUrunEkleme 'Bilgisayar',4,30,44
-----------------------------------------------------------------

---Ürün ýd 'ye göre Ad getiren sp yazýnýz.
create  proc UrunIdyeGoreGetir 
(
@Id int 
)
with encryption
as
select ProductName from 
Products
where  ProductID=@Id

declare @urunAd nvarchar(50),@id int =4 
exec @urunAd = UrunIdyeGoreGetir @id

--print Cast(@id as nvarchar )+'numaralý aradýðýn  ürün'+ @urunAd




























