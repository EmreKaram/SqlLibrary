use Northwind

select * from Employees

select FirstName,LastName from Employees

select FirstName as AD,LastName as SOYAD from Employees

select Ad=FirstName,Soyad=LastName from Employees

select'Doðum Tarihi'=BirthDate from Employees

select City from Employees

select distinct City from Employees

select (TitleOfCourtesy+''+FirstName+' '+LastName) as Isim from Employees

--Deger Atama.
declare @AdSoyad nvarchar(50) ,@yas int
select @AdSoyad='Emre Karamahmut' ,@yas=18
select @AdSoyad AdSoyad ,@yas Yas

declare @UrunAd nvarchar(50)
set @UrunAd=(select ProductName from Products)
select @UrunAd --Hata Alýr.

declare @UrunAd nvarchar (50
set @UrunAd=(select ProductName from Products where ProductID=1)
select @UrunAd 

declare @UrunAd01 nvarchar(50)
select @UrunAd01=ProductName from Products where UnitsInStock>50
select @UrunAd01

select FirstName,LastName,TitleOfCourtesy from Employees where TitleOfCourtesy='Mr.'

select FirstName,LastName,BirthDate from Employees where YEAR(BirthDate)=1960

--And Kullanýmý.
select FirstName,LastName,BirthDate from Employees where YEAR(BirthDate)>=1950 and YEAR(BirthDate)<=1961

select (TitleOfCourtesy+''+FirstName+''+LastName) as Isim ,Title as Gorev ,BirthDate='Doðum Tarihi' ,Country as Ulke
from Employees 
where Country='UK' and (TitleOfCourtesy='Mrs.' or TitleOfCourtesy='Ms.') 

select (TitleOfCourtesy+''+FirstName+''+LastName) as Isim ,YEAR(GETDATE())-YEAR(BirthDate) as Yas
from Employees
where TitleOfCourtesy='Mr.' or YEAR(GETDATE())-YEAR(BirthDate)>60

select Region,FirstName,LastName from Employees where Region is null

select Region,FirstName,LastName from Employees where region is not null

select * from Employees where EmployeeID>2 and EmployeeID<=8 order by FirstName asc 

select FirstName,LastName,BirthDate,HireDate,Title,TitleOfCourtesy from Employees order by 6,4 desc

select FirstName,LastName,TitleOfCourtesy,YEAR(GETDATE())-YEAR(BirthDate) as Yas
from Employees
where TitleOfCourtesy is not null
order by TitleOfCourtesy,Yas desc

--Between Kullanýmý.
select FirstName,LastName,YEAR(BirthDate) as [Dogum Yýlý]
from Employees
where YEAR(BirthDate) between 1952 and 1960
order by [Dogum Yýlý] desc

select FirstName,LastName
from Employees
where FirstName between 'Janet' and 'Robert'
order by FirstName

--In Kullanýmý.
select TitleOfCourtesy+''+FirstName+' '+LastName as Isim
from Employees
where TitleOfCourtesy in('Dr.','Mr.')

select FirstName,LastName,YEAR(BirthDate) as DogumYili
from Employees
where YEAR(BirthDate) in (1950,1955,1960)

select top 3* from Employees

select top 5 FirstName,LastName,TitleOfCourtesy
from Employees
order by TitleOfCourtesy desc

select top 25 percent FirstName,LastName,Title,YEAR(GETDATE())-YEAR(BirthDate) as Yas
from Employees
order by Yas desc

--Adi Michael olanlar.
select FirstName
from Employees
where FirstName like 'Michael'

--Adinin ilk harfi A ile basalayanlar.
select FirstName,LastName,Title
from Employees
where FirstName like 'A%'

--Adinin son harfi N ile bitenler.
select FirstName,LastName,Title
from Employees
where FirstName like '%N'

--Adinin icerisinde E harfi gecenler.
select FirstName,LastName,Title
from Employees
where FirstName like '%E%'
Order by 1 desc

--Adinin ilk harfi A veya L olanlar.
select FirstName,LastName,Title
from Employees
where FirstName like 'A%' or FirstName like 'L%'

--2.Yol
select FirstName,LastName,Title
from Employees
where FirstName like '[AL]%'

--Adinin icerisinde R veya T bulunanlar.
select FirstName,LastName,Title
from Employees
where FirstName like '%[RT]%'

--Adýnýn ilk harfi J ile R aralýðýnda olanlar.
select FirstName,LastName,Title
from Employees
where FirstName like '%A_E%'

--A ile E arasýnda iki karakter olanlar
select FirstName,LastName,Title
from Employees
where FirstName like '%A__E%' --Alt tire ile sayýsý artar

--Adýnýn ilk harfi M olmayanlar.
--1.Yol
select FirstName,LastName,Title
from Employees
where FirstName not like 'M%'

--2.Yol
select FirstName,LastName,Title
from Employees 
where  FirstName like '[^M]%'
order by 1

--Adý T  harfi ile bitmeyeneler. 
select FirstName,LastName,Title
from Employees
where FirstName like '%[^T]'

--Adýnýn ilk harfi A ile I aralaðýnda bulunmayanlar.
--1.Yol
select FirstName,LastName,Title
from Employees 
where FirstName not like '[A-I]%'

--2.Yol 
select FirstName,LastName,Title
from Employees
where FirstName like '[^A-I]%'
order by 1

--Adýnýn 2.harfi A veya T olmayanalar.
select FirstName,LastName,Title
from Employees
where FirstName like '_[^AT]%'
order by 2

--Adýnýn ilk iki harfi LA,LN,AA VEYA AN olanlar.
select FirstName,LastName,Title
from Employees
where  FirstName like '[LA][AN]%'
--Ýlk karakter için  l veya a'dan birisini , 2.karakter için
--a veya n'den birini seçeceðiz.la,ln,aa ve an olur.

--Ýçerisinde _ geçen isimlerin listelenmesi:
-- '_' Karakterinin özel bir anlamý vardýr ve tek bir karakter yerine 
--geçer ancak [] içinde belirtmeye kalkarsam sýrada bir karakterden farký yoktur.

select FirstName,LastName,Title
from Employees
where FirstName like '%[_]%'

select FirstName,LastName,Title
from Employees
where FirstName like '%\_%' escape '\'

--Customers tablosundaki CustomerId'sinin 2 harfi A ,4.harfi T olanlarýn 
--%10'luk kýsmýný getiren sorguyu yazýnýz.
select TOP 10  PERCENT CustomerID,CompanyName,ContactName
from Customers 
where CustomerID like '_A_T%'

--VeriTabaný iþlemleri:

--1)Ýnsert:Bir veritabanýndaki tablolardan birine kayýt eklemek için kullanýlan komut. 
/*
Ýnsert into <tablo adi> (<Sütun_Ýsimleri>) 
values <Sütün_Deðerleri >
*/

insert into Categories (CategoryName,Description)
values('Baklagiller' ,'Kýymetlidir bunlardaki vitamin.')

--Aþaðýdaki insert iþlemi baþarýsýz olacak. 
--Çünkü categories tablosundaki null geçilemeyen CategoryName stünü  için bir deðer atamasýnda bulunmadýk. 
--Bir tablonun null deðer içermeyen stunlarýnda insert iþlemi sýrasýnda mutlaka deðer atamasýnda bulunmmalýyýz.
--(Eðer identiy özelliði aktif ise buraya karýþmadan devam edebiliririz.)
--Otomatik artan özelliði bizim yerimize ilgli kolona deðerini gönderecektir. 

insert into Categories (Description)
values ('kategori adý girilmeli ')

--Eðer bir balo stünlarýrýn hepsine veri gireceksek tablo adýndan sonra stün adlarýný açýktan belirtmenize gerek yoktur.
--Direkt values ile stunlarýn içine deðerleri atayabilirsiniz. 
--Ancak dikkat etmeniz gereken stunlarýn verilerini girerken yapýlarýna dikkat etmeni gerekmektedir. 
--(DATA TYPE) TABLONUN YAPISINA UYGUNLUÐA DÝKKAT ETMEK LAZIM.
--(Yani CompanyName sütünu  phone sütüundan önce olduðu için values kýsmýnda ilk belirticeðimiz deðer companyname
--sütununa ait  olmalý aksi halde sutunlarý veri tiplerinin uyuölu olduðu bir durum denk gelirse iþste busefer yanlýþ datalar girersiniz. 
insert into Shippers values
('MNG KARGO' ,'(212) 556 32 89')

--Eðer stun isimlerini belitirsek verileri belirttiðimiz sýrada girmeliyiz. 
 insert into Shippers (Phone,CompanyName)
 values ('(216) 459 12 41','Aras Kargo')

--Customer Tablosuna 'Bilge Adam' þirketini ekleyiniz.
insert into Customers (CustomerID,CompanyName)
values ('BLGDM','Bilge Adam') 

--2) Update:Bir tablodaki kayýtlarýn güncellemek için kullanýlýr. 
--Dikkat edilmesi gerekn hangi kaydu güncelleyeceðimizi açýktan ifade etmeniz gerekiyor.
--Aksi halde tüm kayýtlarý güncellerisin.

select *
into Calýsanlar
from Employees

 /*
 Update <TabloAdi> 
 set <sütun_adi> = <yenideðer> ,<sütun_adi> = <yenideðer> ,<sütun_adi> = <yenideðer> ,<sütun_adi> = <yenideðer>
 */

--Customers tablosundaki customerId sütünun tipi nchar(5)' tir.
--Yani ,bu stün  identity olarak belirtilemez ,Dolayýsý ile bu tabloya bir kayýt girerken customerId sütutuna da kendimzi veri girmeliyiz. 
Update Calýsanlar
set  LastName ='Oðuz'
--ÇALIÞANLAR TABLOSUNDAKÝ BÜTÜN KAYITLARIN SOYADI BÝLGÝSÝ DEÐÝÞTÝRÝLECEKDÝR.ÇÜNKÜ GÜNCELLEME ÝÞLEMÝNÝ YAPARKEN HANGÝ KAYIT GÜNCELLENECEK AÇIKTAN BELÝRTMEDÝK (Ýstenmeyen durumdur.)

update Employees 
set FirstName ='Ali' ,LastName ='Mehmet'
where EmployeeID=11
--Sadece ýd deðeri 11 olan kaydýn bilgisini güncelledik .Bir kayýt güncellenirken en güzel yol ýd üzeriden yapmaktýr. Eðer firstName yapsaydým ,ayný  ada sahip kiþiler hepsi güncellenecektir. 
--Tekillik saðlanmasý için ýd üzerinden iþlem yapýlýr. 
select * from Employees
where EmployeeID =11

--Product tablosu altýndaki ürnleri ürünler adý altýndaki urunler tablosuna kopyalayýn.
--Her bir ürünün birim fiyatý üzerinden %5 zam yapalým.
select * 
into urunler
from Products
--Products tablosundaki veriler,Urunler tablosuna kopyalandý. 
Update urunler
set UnitPrice = UnitPrice+ (UnitPrice*0.05)
select * from  urunler

--3)Delete:Bir tabloddan kayýt silmek için kullanacaðýmýz komuttur. 
--Ayný update iþlemi gibi dikkat etmeniz gerekir.
--Çünkü birden fazla kayýt yanlýþlýkla silinebilir. 

/*
Delete from <Tablo_Adi>
*/
delete from Employees where EmployeeID =11 --Tek kayýt silinecektir.

drop table Calýsanlar

select * into calýsanlar from Employees

delete from calýsanlar 
where FirstName ='Michael'

---Ünvaný Mr. ve Dr. olanlarý silinmesi.
delete  from calýsanlar
where TitleOfCourtesy in('Dr.','Mr.')

-------------------------Dml Bitis-----------------------------------

--Aggregate Functions 

--1)Tarih Fonksiyonlarý 
--DatePart () Kullanýmý: Bir tarih bilgisinden istediðimiz kýsmý elde etmemiz saðlýyor .
Select  FirstName,LastName,DATEPART(YY,BirthDate) as [yýl]
from Employees 
order by yýl desc --Yýl bilgisini alýr.

select FirstName,LastName ,DATEPART(DY,BirthDate) as [Day of Year] 
from Employees
order by [Day of Year] desc --Yýlýn Kaçýncý günü 

--Yýlýn Kaçýncý ayý.
select  FirstName,LastName,DATEPART(M,BirthDate) as [Mouth]
from Employees
order by Mouth desc

--Yýlýn Kaçýncý haftasý.
select  FirstName,LastName ,DATEPART(WK,BirthDate)as [week of year]
from  Employees
order by [week of year] desc 

 --Haftanýn kaçýncý günü.
select  FirstName ,LastName,DATEPART(DW,BirthDate) as [day of week]
from Employees
order by [day of week] DESC

select FirstName,LastName,DATEPART(HH,GETDATE()) AS SAAT  
from Employees 
order by SAAT DESC --Saat getirir. 

select FirstName,LastName,DATEPART(MI,GETDATE()) as Dakika
from Employees 
order by [dakika] desc--Dakika getirir. 

select  FirstName,LastName, DATEPART(SS,GETDATE())AS SANÝYE
from Employees
ORDER BY SANÝYE DESC--Saniye getirir.

select FirstName,LastName ,datepart (MS,getdate())salise
from Employees
order by salise DESC

--DateDiff() kullanýmý:Ýki tarih arasýndaki farký verir. 
select (FirstName+' '+LastName) as  isim ,DATEDIFF(YEAR ,BirthDate,GETDATE())as yas,
DATEDIFF(DAY , HireDate ,GETDATE()) as [ödenen prim gün]
from Employees

select 
FirstName,LastName,DATEDIFF(hour,BirthDate ,GETDATE()) as  [kaç saat geçti]
from Employees

--String Function:
select 5+9 as toplam ,5-9  as fark ,5*9 as çarpým,5/3 as bolum ,5%2 as  [mod]
--Not : Select ile mutlaka from kullanýmý zorunlu deðil.

select 'Bilge adam' as mesaj
print 'Bilge adama hoþgeldin';

select ASCII('A') AS [ASCII Kodu] --ascii kodunu verir. 65

Select char(65) as [Karakter]

select CHARINDEX(',','umit.vatansever@bilgeadam.com')as Konum ;  
--Ýndexler 1 'den baþlýyor ..
--Aratmak istediðiniz  karakteri ve metin bulunduðu yeri verir. 
--Eðer Bulamazsa 0 döndürür.

select LEFT('Bilge Adam',4) as [Soldan karakter sayýsý]

select RIGHT('Bilge Adam',6) as [Sagdan karakter sayýsý]

select LEN('Bilge Adam') as [Karakter adeti]

select LOWER('BÝLGE ADAM') AS [Hepsi Kücük]

select UPPER('Bilge adam') as [Hepsi büyük]

select LTRIM ('                             Bilge Adam')as [Soldaki boþluklarý silecek]

select RTRIM('Bilge Adam                            ') as [Saðdaki Boþluklarý siler]

select LEN ( LTRIM(RTRIM('                   Bilge Adam                            '))) as [Tüm boþluklarý siler]

--Trim ile alabilirsin.

select  replace ('birbirlerinine','bir','uc') as [metinlerin yerine yenisini atar]

select SUBSTRING('Bilge adam yazýlým kursuna hoþgeldiniz.',4,6) as 'Alt string''leri oluþturulur.'
--Yanyana iki tane  tek týrnak yazdýðýmýzda ,bu ifade tek týrnak yerine geçer.
--(Tek týrnak özel bir anlam ifade ettiðinden dolayý.)

select REVERSE('Bilge Adam Akamdemi') as 'Tersine Çevir'--Reverse Ters Çevirir

select 'Bilge Adam'+SPACE(30)+'Akademi' as [Belirtilen miktarda boþuk koyar.]

select  REPLICATE('Bilge',5) AS 'Belirtilen metin ,belirtilen miktarda çoðaltýlýr. ';

--Aggeragete Fonksiyonlarý - (Toplam ,matematiksel Func.Gruplamalý Func.) 

select COUNT(*) 
from Employees --Bir tablodaki toplam kayýdý öðrenebilirsiniz.

select COUNT (EmployeeID)
from Employees

select COUNT (REGÝON )
from Employees
--Region sütunundaki kayýt sayýsý (region sütunu null geçilebileceði için bir tablodaki kayýt sayýsýný bu sutundan yola çýkarak öðrenmek yanlýþ sonuçlar çýkarabilir. 
--Çünkü aggaregte func null deðere içeren kayýtlarý dikkate almaz. 
--Bu neden ile kayýt sayýsýný öðrenebilmek için ya * karakterini yada null geçilemeyen stunlardan birinin adýný kullanmanýz gerekir. 

select count (city)
from Employees 
--9  adet var görürnür .Fakat bazý þehirler birden fazla kez tekrarlamýþtýr.

select COUNT (distinct  City)
from Employees
--Farklý olan þehirlerin sayýsýný verir. 

select SUM(EmployeeID)
from Employees
--EmployeeId Kolonundaki bütün deðerleri topladý 

--Çalýþanlarýn yaþlarýnýn toplamý.
--1.Yol
select Sum (Year(getdate())-Year(BirthDate))as yaslarýntoplamý
from employees

--2.yol
select sum(DATEDIFF(Year,Birthdate,getdate())) as [yaslarýn toplamý]
from Employees

--select sum(FirstName) as [yaslarýn toplamý]
--from Employees

--Sum fonksiyonu sayýsal stunlarda kullanýlýrlar. 

--AVG(SütünAdi): Bir sütündaki deðerin ortalamasýný sizlere döner. 

select AVG(EmployeeId)
from Employees

--Çalýþanlarýn yaþlarýnýn ortalamasý.
select avg (DateDiff(YEAR,BirthDate,GETDATE()))
from Employees

--Null olanlar iþleme katýlmayacaðý için ortalama hesaplanýrken bütün kiþilerin sayýsýna bölünmez ,null olmayan kiþilerin sayýsýna bölünür.

--Select avg (lastname)
--from 
--Employees
--Avg Fonk sayýsal sutunlar kullanýlýr .
select max (EmployeeID)
from Employees

select max(Firstname ) --Stunda sayýsal stun olmasan gerek yok .Alfabetik olrak en büyük deðeri verir. 
from employees

Select Min(employeeId) 
from Employees

select min(firstname)
from Employees

--Sayýsal deðer iþlemleri.
select 3+2 
select 3*3
select 4/2
select 9-2

--Pý :Pi sayýsýný verir. 
select PI() AS [PI]

--SÝN :Sinüs alýr.
SELECT Sin( PI())

--Power:Üstü Alýr.
select power(2,3)

--Abs:Mutalk deðer alýr.
select abs (-12)

select Rand()  --0 ile 1 arasýnda rasgele deðer üretiyor. 

select floor (RAND()*100)

--Case When -Then: 
select FirstName ad  ,soyad=LastName ,Title as görev ,Country as Ulke 
from Employees

select FirstName,LastName ,
			case (Country)
				when 'USA'
				THEN 'AMERÝKA BÝRLEÞÝK DEVLETLERÝ'
				WHEN 'UK'
				THEN 'iNGÝLTERE BÝRLEÞÝK KRALLLIÐI'

				ELSE 'üLKESÝ BELÝRTÝLMEDÝ.'

				END AS Country
from Employees

--Employyeiddeðeri beþden büyük ise ''ýd deðeri beþ'den buyuk  küçük ise id deðeri 5'kücük ýd 5'deðerine eþit.
select FirstName,LastName,
			case 
			when EmployeeId>5
			then 'Id deðeri beþten büyüktür.'
			when EmployeeID<5 
			then 'Id deðeri beþ''den küçüktür '
			else 'Id deðeri 5 deðerine eþittir. '
			end as Durum 
from Employees;

select  RegionId,
			case (RegionDescription)
				when 'Eastern'
				THEN 'Doðu'
				when 'Western'
				THEN 'Batý'
				when 'Northern'
				THEN 'Kuzey'
				when 'Southern'
				THEN 'Güney'

				ELSE 'Bölge Belirtilmedi.'

				END AS Country
from Region
 
 --GroupBy

--Çalýþanlarýn ülkelerine göre gruplandýrýlmasý.
 select Country as ülke, COUNT(*) as kisisayýsý 
 from Employees 
 where  Country is not null 
 group by Country

--Çalýþanlarýn yapmýþ olduðu sipariþ adeti.
select EmployeeID , COUNT(*) as [Siparis adeti]
from Orders
Group By EmployeeID
order by [Siparis adeti] desc ;

--Ürünlerin bedeli 35 Dolar 'dan az olan ürünlerin kategorilerine göre gruplandýrýlmasý.
select CategoryID,COUNT(*) as Adet
from Products
where UnitPrice<=35  
group by CategoryID 
order by Adet

--Baþ harfi A-K aralýðýnda olan ve stok miktarý 5 ile 50 arasýnda olan ürünlerin kategorilerinie göre gruplayýnýz.
select CategoryID ,COUNT(*) as adet
from Products
where 
 (ProductName like '[A-K]%')
 And 
 (UnitsInStock between 5 and 50)
 group by CategoryID
 order by adet desc
 
--Her bir sipariþteki toplam ürün sayýsýný bulunuz.
Select OrderID,Sum(Quantity) as 'Satýlan Ürünler'
from  [Order Details]
group by OrderID

select
OrderID,Sum(UnitPrice*Quantity*(1-Discount)) As toplamTutar
from [Order Details]
group by OrderID 
order by  toplamTutar desc

---Having Kullanýmý:
--Sorgu Sonucu gelen sonuç Kümesi üzerinde  Aggregate  gonksiyonlarýn baðlý olacak þekilde bir filitreleme iþlemi yapacaksak where yerine having anahtar kelimesini  kullanýrýz.
--Bu sayade aggregate function flitreleme iþlemine katýlýrlar.
---Eðer Aggregate function sorgunuzda yok ise  having kullanimi where ile ayný filitreleme iþlemini yapacaktýr.

--Toplam tutarý  2500-3500 arasýnda olan siparþlerin listelenmesi.
select OrderID  as SiparisKodu ,Sum(Quantity*UnitPrice*(1-Discount)) as ToplamTutar
from[Order Details]                                                                      

--where Sum(Quantity*UnitPrice*(1-Discount))  between 2500 and 3500 
group by OrderID 
having  Sum(Quantity*UnitPrice*(1-Discount))  between 2500 and 3500 
order by ToplamTutar desc

--Herbir Sipariþteki toplam ürün sayýsý 200'den az olanlarý.
select OrderID, SUM(Quantity) as adet 
from [Order Details]
group by  OrderID
having  Sum(Quantity)< 200
order by adet;

--Toplam sipariþ miktarý 1300 adetten fazla olan ürünkodlarýný listeleyiniz. 
 select ProductID ,Sum(quantity) as toplamadet
 
from  [Order Details]
group by ProductID 
having sum (quantity) >1300

--Toplam Sipariþ Miktarý 500'den küçük olanlarý getirin.
 select ProductID as urunid,Sum(Quantity) as [toplam siparis] 
 from [Order Details]
 group by ProductID 
 having  sum (Quantity)<500

--1000 adetten fazla satýlan ürünlerin ProductId göre gruplandýrýlmasý.
select ProductID ,Sum(quantity) as 'Satýþ ADETÝ'
from [Order Details]
group by ProductID
having SUM(Quantity)>1000

--Normal data silmek  için delete komutunu kullanýrýz .Fakat tablodaki identiy olan kolon deðerleri artmýþ ve gitmiþ oluyor.

Truncate Table test
--Identity Sýfýrlanmak istiyorsak  "TRUNCATE KULLANILMALI"

--Ýç içe sorgular (Subquery):

declare @MaxFiyat money = (select max (UnitPrice) from Products)

select * from Products where UnitPrice =@MaxFiyat

select * from Products where UnitPrice = (select max (UnitPrice) from Products)

--Fiyatý Ortalama fiyatýnýn üzerinde olan  ürünleri getirin.
select * 
from Products 
where UnitPrice
>(select  
Avg(UnitPrice)
from 
Products )

--Ürünler tablosundaki satýlan ürünlerin listesi.
select * from 
Products
where ProductID in (select 
ProductID
from 
[Order Details] )

--Ürünler tablosundaki satýlmayan ürünlerin listesi.
select * 
from Products
where ProductID  not in 
(select ProductID
from [Order Details] )

--Subquery'lere herzaman tek stün üzerinde çaðrýlabilir. 
select 
p.ProductName,p.UnitPrice,p.UnitsInStock,
(select CategoryName
from
Categories c where c.CategoryID=p.CategoryId) as KategoriName
from Products p

select FirstName,LastName
from
Employees where title in (select Title
from Employees where Title is not null)

--Kargo þirketlerinin taþýdýklarý sipariþ sayýlarýný gelsin.
select 
(select CompanyName from Shippers s
where s.ShipperID=o.ShipVia) as [Kargo],
ShipVia,COUNT(*)
from Orders o
group by ShipVia

--En pahalý ürünün adý nedir ? 
select ProductName
from 
Products
where UnitPrice=
(select MAX(UnitPrice)from Products)

--Exists Fonksiyonu

--Tablonun dolu yada boþ olduðunu döndürür.
if exists (select * from Employees)
	print 'Dolu'
else
print 'Bos'

--Sipariþ alan çalýþanlarým.
select * from Employees e1
where exists (select EmployeeID  from Orders e2
where e1.EmployeeID=e2.EmployeeID)

--Sipariþ almayan çalýþanlarým.
select * from Employees e1
where not exists (select EmployeeID  from Orders e2 --Not exist
where e1.EmployeeID=e2.EmployeeID)

--Ýç içe yazýlan subqquery'den dönen tüm kayýtlar içinde eþleþme yapýldýktan  sonra ana query çalýþmasýný tamamlar. 
--exists ise subquery yi eþleme yapýlan kayýtlara göre sonuçlandýrýr. 
--ve ilave olarak gelen kayýtlar içinde eþleþme yapmasýna gerek kalmaz.Exists zaten subquery'den ihtiyacý olan kayýtlarý getirmiþ olacaktýr.
--Exists condition (if-else) içerisinde de kullanýlabilir.

---Join Ýþlemi 
--1)Ýnner Join :Bþr tablodaki her bir kaydýn diðer tabloda bir karþýlýðý  olan kayýtlar listelenir.
--(inner join) =>> join  inner cümleciðini yazmasada  yine inner join demekdir. 


select ProductName,CategoryName 
from Products inner join Categories on Products.CategoryID=Categories.CategoryID

--Products tablosundan Product_ýd ProductName,CategoryÝd,
--categories tablosundan da cateName,Description

select Products.CategoryId,Products.ProductID,Products.ProductName,Categories.CategoryName,Categories.Description
from Products inner join Categories on Products.CategoryID=Categories.CategoryID
--:Not: Eðer seçtiðiðimiz stünlar her iki tabloda da bulunuyorsa , o türünü hangi tablodan seçtiðiniz açýkça belirtiniz. 

--Hangi sipariþ ,hangi çalýþan tarafýndan ,hangi müþteriye yapýlmýþtýr.
select OrderID as [Siparis no],OrderDate as [Siparis Tarihi],CompanyName as [Þirket adi],ContactName as [Yetkili kiþi],(FirstName+' '+LastName) as [calýsan], Title as görev 
from Customers as c inner join Orders as o on  c.CustomerID=o.CustomerID
					inner join Employees as e on e.EmployeeID=o.EmployeeID
--Sorguyu kýsatmak amacý ile tablo da takma isim verilebilir. Ancak dikkat edilmesi gereken  kýsým tabloya takma isim verdikten sonra  artýk heryerde o ismi kullanacaðýnýz.

--Suppliers tablosundan  companyName,ContactName. 
--Product Tablosundan  ProductName,UnitPrice.
--Categories Tablosundan  categoryName.
--CompanyName sütündan göre artan bir þekikde sýralayýn.

select CompanyName,ContactName,ProductName,UnitPrice,CategoryName
from  Categories as C inner join Products as p  on c.CategoryID=p.CategoryID
					  inner join Suppliers as S on s.SupplierID=p.SupplierID
order by CompanyName asc
--Not: From'dan sonra sorguda geçen herhangi bir tabloyu baliertebilirisin , diðerlerini de daha sonra join iþlemleri ile birleþtiriyoruz. 

--Kategorilere göre toplam stok miktarýný bulunuz.
Select CategoryName,SUM(UnitsInStock) as Stok
from Categories  as c inner join Products as p on c.CategoryID=p.CategoryID
group by CategoryName 
order by  Stok desc

--Her bir çalýþan toplamda ne kadar satýþ yapmýþtýr (UnitPrice*Qunatity*(1-Discount))
select (FirstName+' '+LastName) as Calýsan,
Cast(CAST( Sum(UnitPrice*Quantity*(1-Discount)) AS decimal (15,3))as nvarchar(15))+' TL' as Toplam

from Employees as E inner join Orders as o on e.EmployeeID=o.EmployeeID
					inner join [Order Details] as OD ON O.OrderID=OD.OrderID

Group by (FirstName+' '+LastName)
order by TOPLAM DESC

--Not:CAST( Sum(UnitPrice*Quantity*(1-Discount)) AS decimal(15,3) ) AS TOPLAM =>>
--Virgülden önce 15 ,Virgülden sonra 3 haneye kadar üstte elde edilen deðeri gösterir. 
--Üstte elde ettiðimiz ondalýklý deðeri stringe çevirdik.
--Sql 'de tip dönüþümleri için 2 tip dönüþtürme fonksiyonu var.Cast ve Convert

--Herbir Kategori için ortalama ürün fiyatýný bulunuz. Fakat ortalama fiyatý 10 'dan büyük olanlarý getiriniz. 

select Categories.CategoryName ,AVG(UnitPrice)
from Products inner join Categories on Categories.CategoryID=Products.CategoryID
group by Categories.CategoryName
having  AVG(UnitPrice)>10
 
--2)Outer Join
--2.1) Left outer join
--Sorguda katýlan tablolardan soldakiniin tüm kayýtlarýný getirirken ,saðdaki tabloda sadece iliþkisi olan kayýtlar getirilir. 

select ProductName,CategoryName 
from Products as p left outer join  Categories as c 
--Left outer join ifadesinin solunda kalan (Products) tablosundaki tüm kayýtlarý getirken ,saðdaki (categories tablosundaki  iliþkili kaydý getirecektir.)

 on p.CategoryID=c.CategoryID;

--Her bir çalýþanýn  rapor verdiði kiþsiyle birlikte  listeleyin.
select (e1.FirstName+' '+e1.LastName) as calýsanlar ,(e2.FirstName+' '+e2.LastName) as yönetici 
from Employees  as e1  inner Join Employees as e2 on  e1.ReportsTo=e2.EmployeeID 

--Tüm Çalýþanlar ve eðer varsa müdürleri ile birlikte listelenemsi.
select 
(e1.FirstName+''+e1.LastName) as Çalýþanlar , (e2.FirstName+' '+e2.LastName) as Yönetici
from 
Employees as e1  left join Employees as e2  ---Left Outer Join yerine kýsaca left join kullanabilrsin .
on e1.ReportsTo=e2.EmployeeID;

--2.2)Right Join :Sorguda katýlan tablolardan saðdakini tüm kayýtlarýný getirken ,soldaki tabloda sadece iliþkli olan kayýtlar gelecektir.
select ProductName, CategoryName
from  Categories right join Products on Categories.CategoryID=Products.CategoryID

--Her bir çalýþaný  müdürüyle birlikte listeleyin .
select 
e1.FirstName as Müdürad,e1.LastName as MüdürSoyad ,e2.FirstName as calýsanad ,e2.LastName as calýsansoyad
from Employees as e1 right join  Employees as e2 on 
	e2.ReportsTo=e1.EmployeeID

select ProductName,CategoryName
from  Products right join Categories on Products.CategoryID=Categories.CategoryID

---3)Full Join :Her iki tablodaki tüm kayýtlar getirlir. left ve right join 'nin birleþimidir.

select Products.ProductName,Categories.CategoryName
from Categories full join Products on Categories.CategoryID=Products.CategoryID;

---4.))Cross Join:Bir tablodaki bir kaydýn diðer tablodaki tüm kayýtlar ile eþlemesi gerekir. 
select  COUNT(*)
from
Categories --10

select COUNT (*)
from
Products --77

select CategoryName,ProductName
from  Categories cross Join Products

--View Yapýsý:
--Kullaným amacý==> 
---Genellikle karmaþýk sorularý tek bir sorgu üzerinden çalýþtýrýlabilmesidir..
--Bu amaç ile raporlama iþlemlerinde kullanýlýr. 
--Ayný zamanda güvenlik ihtiyacý olduðu durumlarda  herhangi bir sorgunun 2 .ve 3. þahýslara gizlenmesini saðlar.

--Genel özellikeler:
--Herhangi bir sorgunun sonucunda tablo olarak ele alýp ,ondan sorgu çekebilmesini saðlar..
--insert ,update ,delete ,fizziksel olarak tablolara etki yapar 
--Bu yapýlar fiziksel yapýlarýdýr. 
--view yapýlarý normöal sorulardan yavaþ çalýþýrlar.

use Northwind 
Create VIEW PrdCtgSup
as 
select 
p.ProductName,p.UnitsInStock,c.CategoryName,s.CompanyName
from Products p inner join Categories c on p.CategoryID=c.CategoryID
inner join Suppliers s on p.SupplierID =s.SupplierID

select * from PrdCtgSup

select   CategoryName,CompanyName
from PrdCtgSup

select * from PrdCtgSup 
where CategoryName ='Beverages'

select  ProductName,UnitsInStock
from PrdCtgSup where ProductName>'C'
order by 1 

--Satýs yapan çalýþanlarýn numaralarýyla birlikte ad ve soyad bilgilerini getiren bir view yazýnýz.
Create VIEW SipVerCal
As
select OrderID,Employees.FirstName+' '+Employees.LastName as [Ad Soyad]

from Orders 
inner Join 
Employees
on
Orders.EmployeeID=Employees.EmployeeID
Go
select * from SipVerCal

--With Encryption Komutu ile þifreleme yapýlýr ..

--Eðer yazdýðýnýz view 'in kaynak kodlarýný ,object exloper pencersinden "views "kategorisininde sað týklaraya desing modu açýp göürntelemek istemiyorsak. "With Enrtyption"komutunu kullanamk yeterli olacaktýr. 
--"With encryiption" iþleminden sonra view oluþturan kiþide dahil olmak üzre kimse komutlarý göremez .Geri döünüþü yoktur. .

--Ancak view oluþturan þahsýn komutlarýn yedeðini bulundurmasý gerekmektedir. 

--Dikkat etmemiz gereken bir baþka husus ise as dan önce bu keyword kullanýlýr.

Create View OrnekViewPersoneller 
with encryption 
as 
select FirstName,LastName,Title  from Employees

--Bu iþlemden sonra desing modu kapanmýþtýr.

--------------------SQL INTRO BITIS--------------------
