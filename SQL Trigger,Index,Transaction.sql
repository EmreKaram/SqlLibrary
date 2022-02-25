create proc ShipperInsert

(
@cn nvarchar (50),
@p nvarchar (20),
@shipperId int  output 
)
as 
insert Shippers(CompanyName,Phone)
values(@cn,@p)
SET @shipperId =@@IDENTITY
---1.yÖNTEM 

DECLARE @shipper_Id int 
exec ShipperInsert 'AhmetKargo','5454235545',@shipperId=@shipper_Id output
select @shipper_Id

---2.Yöntem 

Declare @shipper_Id int 
exec ShipperInsert 'MehmeTKargo','45235456423123',@shipper_Id output
select @shipper_Id

---Triggers (Tetikliyiciler)

--===Dml Triggers === 
---Bir tabloda insert ,update ve delete iþlemleri gerçekleþtiðinde devreye giren yapýlar. ..

----Ýnserted Table 
---Eðer bir tabloda insert iþlemi yapýlýyorsa arka planda iþlemler ilk önce ram 'de oluþturulan  inserted  isimli bir  tabloya eklenir .Eðer iþlemde   bir problem çýkmaz ise inserted tablosundaki verileri gidip,  ilgli tabloya insert eder. .... Ýþlem bittiðinde  oluþturulan inserted tablosu silinir. ...


---Deleted table 

--Eðer bir tabloda delete iþlemi yapýlýyorsa  iþlemler ilk önce ram'de oluþturulan deleted isimli bir tabloya yazýlýr.Eðer iþlemde herhangi bir problem olmaz ise fiziksel tabloda delete iþlmei gerçekleþir...Fiziksel silme eylemi gerçekleþtiðinde ram üzerinde bulunan deleted tablosuda silinecektir...

---Eðer bir tobloda update iþlemi yapýlýyor ise ramde updateed isimli tablo oluþturulmaz!!!!!....
--Sql serverda güncelleme mantýðý þu þekilde çalýþýr. .Önce silinir (delete) ,Sonra eklenir (Ýnserted)

--Eðer bir tabloda update iþlemi gerçekliyor ise iki tablo birden oluþturulur...
--Not: Update yaparken güncellenecek olan kaydýn orjinali deleted tablosunda ,güncelledendikten sonraki hali ise inserted tablosunda bulunur...
--çÜNKÜ GÜNCELLEMEK DEMEK KAYDI ÖNCE SÝLMEK SONRA EKLEMEK DEMEKTÝR.. 

-----==Trigger Tanýmlama==-----
--Create Trigger [TriggerAdý] 
--on  [Ýþlem yapýlak olan tabloadý]
----After --- veya insert,update,delete 
--as 
--[Kodlar ]

--Dikkat 
--Tanýmlanan Triggerlara ilgili tablonun içerisindeki tirggers sekmesi altýndan eriþebilirisiniz. 

Create trigger OrnekTrigger
on employees
after insert 
as 
select * from Employees


insert Employees (FirstName ,LastName) values ('test1','test2') 


-----Örnek 
--Tedarikçiler tablosundan bir veri silindiðinde tüm ürünlerin fiyatý otomatik olarak 10 artsýn..
create trigger triggertedarikciler
on suppliers
after delete 
as 
update urunler set UnitPrice = UnitPrice +10 
select * from Products
----
Delete from Suppliers where SupplierID=31
--Örnek2 
---Region tablosundaki bir veri güncellendðinde ,Kategoriler tablosunda "Kýrýmýzý et " adýnda bir kategori olusssun...

Create Trigger trgTedarikGuncellendigýnde
on Region 
for update

as 
insert  Categories(CategoryName) values ('Kýrýmýzý et')




update Region set RegionDescription='Güney' where RegionID=5


----------


Create Table LogTablosu 
(
Id int primary key identity (1,1),
Rapor nvarchar(max)

)


Alter Trigger triggerPersoneller 
on employees 
after delete 
as 
Declare @Adi nvarchar(max),@Soyadi nvarchar(max)
select @Adi =FirstName ,@Soyadi=LastName
from deleted
insert LogTablosu values ('Adý +Soyadý '+ @Adi+'  '+@Soyadi+'Olan personel '+ SUSER_SNAME()+'Tarafýndan'
+cast(GETDATE()as nvarchar(max) )+'Tarafýndan silinmiþtir')



delete from Employees where EmployeeID =13
--suser_sname() =>>> O anki server üzerindeki aktif olan kullanýcýn bilgilerini getiren fuctionýn adý ..

----------------------------------------------------------------------------------------------------------
---Ornek 4 
--Personeller tablosunda gerçekleþtiði anda devreye giren  ve bir lof tablosuna "Adý..... olan personel......yeni adýyla deðiþtirilerek...kullancýsý tarafýndan..... tarhinde güncelenmiþtir..."


Create Trigger trgPersonellerRapor
on employees
after update 
as 
declare @eskiad nvarchar(max),@yeniad nvarchar(max)
select @eskiad= FirstName  from deleted
select @yeniad = FirstName from inserted
insert  LogTablosu values ('Adý'+ @eskiad +'Olan personel'+@yeniad+ 'yeni adý ile deðiþtirilecek '+SUSER_SNAME()+'Kullanýsý tarafýndan '+ CAST (GETDATE() as nvarchar(max))+'tarhinde güncellendi')



update Employees set FirstName ='Mehmet'   where  EmployeeID =12





---==Multiple Actions Triggers==-----
--Birden fazla aksiyonu tetiklemek için kullanýlýr ...

Create Trigger MultiTrigger
on  employees 
after delete ,insert 
as 
print 'Trigger çalýþma iþlemini tamamladý ...'



insert Employees (FirstName ,LastName) values ('test1','test2')
Delete  from Employees where  EmployeeID= 16


--Instead of trigger 
--Þuana kadar insert ,update ,delete iþlemleri yapýlýrken  þu þ iþlemleri yap mantýðý ile çalýþtýk (yanýnda da sunu yap.) 
--Ýnstead of triggerlar da ise insert update delete iþlmelerinin yerine þu iþlemleri yap dieceðiz...(Yerine þunu yap) 


--Create Trigger (Tiriggeradý)
--on tabloadý
--instead of delete,update,insert
--as 
--komutlar 

---Personller tablosunda update iþlemi gerçekleþtiði anda yapýlacak olan güncelleþitrme yerine bir log tablosuna "Adý ..olan personel ... yeni adý ile deðiþtirielecek.... kullanýsýsý tarafýndan .... tarhiinde  güncellenmek istendi.." kalýbýnda rapor verin 

Create Trigger trgPresonellerRaporInstead
on 
employees 
instead of update

as

declare @eskiad nvarchar(max),@yeniad nvarchar(max)
select @eskiad= FirstName  from deleted
select @yeniad =FirstName  from inserted
insert  LogTablosu values ('Adý'+@eskiad+'olan personel'+@yeniad+'Yeni adi ile deðiþtirilecek'+SUSER_NAME()+'Kullanýcýsý tarafýndan '+CAST (GETDATE()as nvarchar(max))+'tarihinde güncellenmek istendi..' )

-----------------------------------
Update Employees set FirstName= 'Adam1Bilge' where EmployeeID =15


--Örnek 6 
--Personeller tablosunda  adý "Andrew"olan kaydýn silinmesini engelleyen  ama diðerlerine izin veren triggerý yazýnýz?

---DDL- Trigger
--Create ,alter ve drop iþlemleri sonucunda ve sürecinde devreye girmenizi saðlayan yapýdýr.

--triggerlar--

--personeller tablosunda adý 'Andrew' olan kayýdýn silinmesini engelleyen 
--ama diðerlerine izn veren triggeri yazýnýz

create trigger AndrewTrigger
on employees
after delete
as
declare @adi nvarchar (max)

select
@adi=FirstName
from deleted
if @adi='Andrew'
	begin	
		print 'Bu kayýdý silemezsin'
		rollback --yapýlan tüm iþlemleri geri alýr..
 end

 delete from Employees where EmployeeID=10

 --DDL-- Trigger

--create ,alter ve drop iþlemleri sonucunda ve sürecinde devreye girmenizi saðlayan yapýdýr.

create trigger DDL_Trigger
on Database
for drop_table ,alter_table,create_function,create_procedure --vs.
as print 'BLABLAB'
rollback

--programmability => DatabaseTriggers klasöründe oluþur.

--Trigger devre dýþý býrakma:
disable trigger DDL_Trigger on database
--Trigger aktifleþtirme
enable trigger DDL_Trigger on database

--c# 'da event yapýsýna benzer

--Sipariþ verdiðimde sipariþ verdiðim miktar kadar stoktaki miktardan düþün.

create trigger StokGuncelleme 
on[Order Details]
after insert
as 
	declare @satilanurunid int,@satilanmiktar int
	select @satilanurunid=ProductID,@satilanmiktar=Quantity
	from inserted

		update Products set UnitsInStock-=@satilanmiktar
		where ProductID=@satilanurunid

		select * from Products

insert [Order Details]
(OrderID,ProductID,UnitPrice,Quantity,Discount)
values (10526,4,18,3,0)

alter trigger StokEkleCýkar
on [Order Details]
after update
as
declare @ProId int,@EskiMiktar smallint,@YeniMiktar smallint
select @ProId=ProductID, @EskiMiktar=Quantity
from 
deleted 
select @YeniMiktar=Quantity
from 
inserted

update Products set UnitsInStock +=(@EskiMiktar-@YeniMiktar)
where ProductID =@ProId


select * from Products
select * from [Order Details]

update [Order Details] set Quantity =19 
where OrderID=10248 and ProductID=1

create trigger mesajver
on [Order Details]
for insert ,update,delete
as 
	if (Exists(select * from inserted) and exists(select * from deleted))
	print 'Update iþlemi baþarý ile gerçekleþti'
	else if (Exists(select * from inserted) )
	print 'Ýnsert iþlemi baþarýlý'
	else if (exists(select * from deleted) )
	print 'Delete iþlemi baþarýlý'

--shippers tablosunda silinen kayýtlarý yedek db'deki kargolar tablosuna yedeklemeye çalýþýn

create trigger kargoyedekle 
on shippers 
after delete
as 
	declare @cn nvarchar(50),@p nvarchar (50)
	select @cn=CompanyName,@p=Phone from deleted
	insert yedek.dbo.kargolar
	values (@cn,@p)

	select * from Shippers 
	
	delete from Shippers where ShipperID=8
    select * from yedek.dbo.Kargolar

create table logfile
(
Id int primary key identity,
Silenkisi nvarchar (50),
Tarih datetime constraint Dv_Tarih default (getdate())
)

create trigger urunkoruma 
on products
instead of delete
as 
	insert logfile values (SUSER_NAME(),DEFAULT)
	print 'iz kaydedildi'

delete from Products where ProductID=83
select * from Products where ProductID=83

create trigger viewolsuturdu
on database 
after drop_view 
as
	print'View silindi'


drop view Invoices
	--DLL TRÝGGERLARDA ÝNSTEAD OF KULLANILMAZ
alter trigger tabloduzenlemeengel
on database 
after alter_view
AS
	Print 'tabloda deðiþiklik yapamazsýn'
	rollback --instead of'daki gibi geri iþlemi yapmaz.

	disable 

create trigger veritabanýolusturmaengeli
on all server 
for create_database
as
	raiserror('Yetkin yok malesef',16,2)
	rollback

	create database BilgeAdam

disable trigger veritabanýolusturmaengeli on all server
---------------------------Transaction------------------
create database BankaDB
go 
use bankadb
go 
create table Hesap
(
Id int primary key identity ,
Ad nvarchar (50) ,
Bakiye money ,
TcKimlikNo char (11)
)
insert  Hesap
values ('mehmet',100,'12341234'),
('baran',0,'534252345'),
('alper',1000,'123412341')

--transaction kullanmazsak neler olur

begin try
	update Hesap set Bakiye -=200 where TcKimlikNo='123412341'
	raiserror ('elektrikler kesildi',16,2)
	update Hesap set Bakiye +=200 where TcKimlikNo='534252345'

	end try

	begin catch 
	print 'Beklenmedik bir hata meydana gelmiþ bulunmakta lütfen daha sonra tekrar deneyiniz'
	end catch

	--transaction  kullanýlarak bu hatanýn önüne nasýl geçilir inceleyelim.

	begin try
	begin tran --transaction iþlemi baþlar
	update Hesap set Bakiye-=200 where TcKimlikNo='123412341'
	raiserror ('elektrikler kesildi',16,2) --hata oluþturmak için 
	update Hesap set Bakiye+=200 where TcKimlikNo='534252345'
	commit tran --transaciton baþarýlý bir þekilde sonlandýrýlýr.
	end try

	begin catch
	print 'Beklenmedik bri hata meydana geldi'

	rollback tran--transaction baþarýsýz bir þekilde sonlandýrýlýr.
	--ve yapýlan baþarýlý iþlemler geri alýnýr.

	end catch

	insert Hesap 
	values ('Yasin',500,'78987654')

	begin try
	begin tran --transaction iþlemi baþlar
	update Hesap set Bakiye-=500 where TcKimlikNo='78987654'
	update Hesap set Bakiye+=200 where TcKimlikNo='534252345'
	commit tran --transaciton baþarýlý bir þekilde sonlandýrýlýr.
	end try

	begin catch
	print 'Beklenmedik bri hata meydana geldi'

	rollback tran--transaction baþarýsýz bir þekilde sonlandýrýlýr.
	--ve yapýlan baþarýlý iþlemler geri alýnýr.
	end catch


	------Ýndex Yapýsý--------

--sql indexlemenin amacý iþlyen veririn dah azz veri okunarak sorgu sonuncunun dah akýsa sürede 
--getirebilmesini saðlamak.Ýndeksleme kullanýlarak tablonun tamamýný okumaktansa oluþturulacak olan index key aracýlýðý ile
--okumak ve istediðimiz kayýda ulaþabilmemiz daha hýzlý bir þekilde mümkün olacaktýr.
--bu sayede tamamlanmasý saatler süren sorgunu uygun idexler kullanýlarak saniyler içerisinde getirlemeisni aðlayabilirsiniz.
--ancak tablomuzda bir güncelleme iþlemi uygularsanýz, bu güncelleme iþlemi index olmayan tabloya göre biraz daha uzun sürecektir.

create database IndexDeneme1
go
use Index_deneme1
go
create table kisi
(
id int primary key identity,
ad nvarchar (50),
soyad nvarchar (50),
telno char (11)
)
