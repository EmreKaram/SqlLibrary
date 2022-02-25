
--Not:Sorgularýmýzý yazarken küçük büyük harfe dikkat etmenize gerek yoktur.
--Eðer baþlangýçta server ayarlarýnda belirtilmiþ ise.

--DML =>> Data Manipulation Language
use Northwind --Northwind veritabaný üzerinde çalýþýcaðýmýzý ve bu veritabaný üzerinde sorgular atacaðýmýzý ifade eder .
--Nortwind veritabaný üzerinde  sorgulamalar yapmak için bu þekilde veritabaný seçilebilir. 
--Ýsteyen yukardaki combobox'ý da kullanabilir. 

--Tablo Sorgulama
--select <Sutun_adlarý> (Sütüm adlarý arasýnda virgül olduðunu unutmayýnýz.)
--from  <Tabloadi>

--Employess tablosundaki tüm kayýtlarý getrin ....
select * 
from
Employees

--Employes tablosu üzerinde  , çalýþanlara ait ,ad,soyad,görev,doðum_tarihi bilgisini getirelim. 
select FirstName,LastName,Title,BirthDate
from Employees

select FirstName,LastName,Title,TitleOfCourtesy 
from 
Employees
--Stün isimleri intelisense üzerinden gelmektedir .Bu alandan yardým alabilrisiniz.  
--Employees tablosu üzerinde stütunlarý sürükle býrak ile  ekleyebirisin.
--Select (bu alanda intelinsedan destek alabilrisiniz.)  from <tablo adý> 
--intelisence kýsa yok (ctrl +space) 

select [EmployeeID], [LastName], [FirstName], [Title], [TitleOfCourtesy], [BirthDate], [HireDate], [Address], [City], [Region], [Country], [HomePhone], [Extension], [Photo], [Notes], [ReportsTo], [PhotoPath] 
from
Employees

select  
FirstName as Ad,LastName as soyad,Title as Görev
from 
Employees 

--Sorgu sonucunda oluþacak olan sonuç kümesindeki (result set) sütun isimleri deðiþtirilecektir,
---tablodaki orjinal sütün isimlerin deðiþtirilmesi söz konusu deðildir. 

--Birden fazla kelimeden oluþan bir sütun ismi olduðunda bunu köþeli parantez veya  tek týrnak içerisinde  belirtmemiz gerekmektedir. 
--Sql'de metinsel ifadeler tek týrna içerisinde belirtilirler. 

--2.Yol
select Ad=FirstName ,soyad=LastName,görev=Title,[Doðum Tarihi]=BirthDate
from
Employees
--Tekil kayýt listeleme 
select ad=FirstName ,soyad=LastName,görev=Title,'Doðrum tarihi'=BirthDate
from Employees

select city
from 
Employees  --Ayný þehirler listelenir. 

select DISTINCT City
from
Employees

select 
City ,FirstName
from
Employees

select distinct
City ,FirstName
from
Employees

--Üsteki ile ayný sonucu getirir. Sebebi ise ayný ad ve þehir deðerine sahip kayýtlarýn olmamasýdýr.
--Eðer FirstName "Steven" ,city =London olan bir baþka kayýt daha  girilirse tabloya, bu kayýttan sadece biri listelenir. 

---Metin Birleþtirmme 

select (TitleOfCourtesy+''+FirstName+''+LastName) as isim
from 
Employees
--(+) Operetörü ile metinler, birleþtirebiliririz. ...' 'ile araya boþluk karakteri ekleyebirisin.  Eðer as ile isimlendirmeseydim .Tablo adý NoColomnName olarak görünecektir. 

---Deðiþkenler--
---1.DEÐER ATAMA YÖNTEMÝ ...

--declare @Ad nvarchar(70) ,@yas int
--set @Ad='BilgeAdam'
--set @yas =20

--select @Ad ad ,@yas yas

--2.Deðer atama yöntemi 
declare @AdSoyad nvarchar(50) ,@yas int 
select @AdSoyad ='BilgeAdam',@yas =50
select @AdSoyad adsoyad,@yas yas

--print @AdSoyad
--Print Message kýsmýndan  verir .Select ise tablo döndürür. 
--aralarýndaki fark set ile deðer atamada ayný anda birden fazla deðiþkene deðer atamazken select ile deðer atamasýný ayný anda yapan mümkündür. 

--go 
--Sýçrama yapmak için kullanýlýr .
go 
--Hata verir 
declare @Urunad nvarchar(50)
set  @Urunad = (select ProductName  from Products )
select @Urunad

--Hata vermez 
declare @urunAdi1 nvarchar (50)
set @urunAdi1 =(select ProductName from Products where ProductID =1)
select @urunAdi1

---Hata vermez. Where kullanmazsanýz anlamsýz deðerler almýþ olursunuz .   
declare @urunadi2 nvarchar (50)
select @urunadi2=ProductName  from Products
select @urunadi2

declare @urunadi3 nvarchar (50)
select @urunadi3 = ProductName  from Products where UnitsInStock>50
select  @urunadi3

--Sorgularý filitreleme where
--Yazdýðýmýz sorgularý belirli koþullara göre filitreliyebilmek için where cümleciðinden faydalanýrýz .

--Ünvani Mr. olanlarýn listelenmesi 
select FirstName,LastName,TitleOfCourtesy 
from 
Employees
where TitleOfCourtesy ='Mr.'-- Metinsel ifadeler tek týrnak içerisnde yazýlýrlar.

--EmpoyeeId deðeri 5'den büyük olanlarý getirin . 

Select EmployeeID ,FirstName,LastName
from
Employees
where EmployeeID>5
-- 1960 yýlýnda doðanlarý listeleyin .
select FirstName,LastName,BirthDate
from
Employees
where YEAR(BirthDate)=1960

--Year (datetime parametre) fonksiyonu bizden datetime tipinde deðer alýr ve geriye int tipinde yýl bilgisini döndürür.

--1950 ile 1961 yýllarý arasýnda doðanlarý kimler?
select FirstName ,LastName ,BirthDate
from
Employees
where 
 YEAR(BirthDate)>=1950
 and
 YEAR(BirthDate)<=1961

--Ýngiltere 'de oturan bayanlarýn adi,soyadi mesleði,ünvaný, ülkesi  ve doðum tarhini listeleyiniz. (emp)
select (TitleOfCourtesy+' '+FirstName+''+LastName) as isim ,Title as görev, [Doðum tarihi]=BirthDate, Country as ülke 
 from 
 Employees
 where Country = 'UK'
 and 
 (TitleOfCourtesy='Mrs.'
 or
 TitleOfCourtesy='Ms.'
 )

 --Ünvani Mr. olanlar veya yaþý 60'dan büyük olanlarý getiriniz. 
 select(TitleOfCourtesy+' '+FirstName+' '+LastName) as isim  ,YEAR( GETDATE())-YEAR(Birthdate) as yas
 from
 Employees
 where 
 TitleOfCourtesy='Mr.'
or
 YEAR(GETDATE())-YEAR(BirthDate)  >60
--Getdate () fonksiyonu güncel tarih bilgisini verir. Year fonksiyonu ile birlikte o tarihe ait olan yýl bilgisini alýyoruz.
--Where ifadesi ile birlikte as ile kendi isimlendirdiðimiz kolon isimleri asla kullanýlmazlar.
--Örneði yukarýda yaþ olarak isimlendirdðimiz sütün isimini where ile birlikte kullanamayýz.

select Region
from
Employees
--Bölgesi belirtilmeyen çalýþanlarý listelenmesi 
select 
TitleOfCourtesy,FirstName,LastName,Region
from Employees 

where  Region IS NULL -- NULL OLAN SÜTÜNLARI BU ÞEKÝLDE SORGULAYABÝLRÝSÝNÝZ.
--BÖLGESÝ BELÝRTÝLEN ÇALIÞANLARIN LÝSTELENMESÝ 
select TitleOfCourtesy,FirstName,LastName,Region
from 
Employees 
where Region is  not  null
--Null deðer içermeyen sütünlarýn listelenmesi 
--Not:Null degerler sorgulanýrken  = veya <> operatörler kullanýlmaz bunu yerine is null veya is not null ifadeleri kullanýlýr. 

--Sýralama iþlemlerine  
select  *
from 
Employees
where 
EmployeeID>2 
and
EmployeeID<=8
order by FirstName asc -- Ascending (artan sýralama) 

select  FirstName,LastName,BirthDate
from
Employees
order by BirthDate --Eðer asc  iafedeisni belirtmezsinizde default olarak artan sýralama yapacaktýr.Bu sorguda Birthdate kolonuna göre artan sýralama yaptýk .

select FirstName,LastName,BirthDate,HireDate
from 
Employees
order by LastName desc --Descending (azalan sýralama)
--Asc ifadesi sayýsal sütünlarda küçükten büyüðe ,metinsel ifadelerde a-z  ye doðru  iþlem yaparken desc 'de ise tam tersi olacak þekilde iþlem yapacaktýr.
select 
FirstName,LastName
from 
Employees
order by FirstName ,LastName
--Elde ettiðimiz sonuç kümesi ada göre artan sýrada sýralnadý . 
--Eðer ayný ada sahip  birden fazla kiþi varsa sýralamayý vermiþ olduðunuz ikinci kolona göre yapar.

select  FirstName,LastName,BirthDate,HireDate,Title,TitleOfCourtesy
from 
Employees 
order by 6,4 desc ;
--Soruguda yazdýðýmýz sütünlarýn sýrasýna göre sýralama iþlemi yapabilrisiniz. 
--Burada ilk önce 6.sýradaki sütüna (titleofCour) artan sirada sýralama iþlemi ,daha sonrada ünvan deðerine sahip kayýtlar için 4.sýradaki (hiredate) sütununa göre azalan sýrada sýralama yapýyoruz. 
--Sql'de indekleme  1'den baþlar  titleofCourTESY SÜTÜNÜ 5.DEÐÝL 6.SIRADADIR. 

--Çalýþanlarý unvanlarýna(titleofcourtesy) göre ve ünvanlarý ayný ise yaþlarýna göre büyükten küçüðe doðru sýralayýnýz.
select  FirstName,LastName,TitleOfCourtesy,(YEAR(getdate())-YEAR(BirthDate)) AS YAS 
from Employees 
where TitleOfCourtesy is not null   
Order by TitleOfCourtesy,YAS desc
--Order By ifadesi ile stünlara vermiþ olduðunuz takma isimleri kullanbilrisiniz. 
--Örneðin burdaki yaþ sütündaki gibi.

--Between-And Kullanýmý:
--Aralýk bildrimek için kullanýcaðýmýz bir yapý sunar.
---1952-ile 1960 arasýnda doðanlarý listeleyiniz. 
--1.yol
select FirstName,LastName,year(BirthDate) as [Doðum yýlý ]
from
Employees
where YEAR (BirthDate)>=1952
and 
YEAR(BirthDate)<=1960
order by [Doðum yýlý ] desc

---2.yol
select FirstName,LastName,YEAR(BirthDate) as [Doðum yýl ]
from 
Employees
where YEAR(BirthDate) between 1952 and 1960
order by [Doðum yýl ] desc

--Alfabetik olarak janet ile robert arasýnda olanlarý listeleyiniz. 

---1.yol 
select FirstName,LastName
from 
Employees
where 
FirstName between 'Janet' and 'Robert'
order by FirstName  
--2.yol 
select FirstName,LastName
from  Employees
where FirstName>='Janet'
and 
FirstName<='Robert'
order by FirstName

--IN Operatörü Kullanýmý.
--Ünvaný Mr. veya Dr. olanlarýn listelenmesi
-----1.yol
Select  TitleOfCourtesy+' '+FirstName +' '+LastName as isim
from Employees
where TitleOfCourtesy ='Mr.'
or
TitleOfCourtesy ='Dr.'

select TitleOfCourtesy+ ' '+ FirstName+' '+ LastName as isim
from Employees
where TitleOfCourtesy IN('Dr.','Mr.')

--1950,1955 ve 1960 yýllarýnda doðanlarý  listeleyiniz. 
select  FirstName,LastName, year(BirthDate) as DoðumYili 
from Employees
where  YEAR(BirthDate) in (1950,1955,1960)

--Top Kullanýmý

Select * from Employees
--ilk üç kayýt gelsin

select top 3 * from 
Employees

select top 5 FirstName,LastName,TitleOfCourtesy
 from 
 Employees 
 order by TitleOfCourtesy desc

 --Top kýsmý bir sorguda en son çalýþan kýsýmdýr. 
 --Yani öncelikle sorgumuz çalýþtýralabilir ve oluþacak olan sonuc kümesinin (result set) ilk 5 kaydý alýnýr. 
 --Ürünler tablosunu tersten sýrala ilk 10 gelsin.
 --Çalýþanlarýn yaþlarýna göre azalan sirada sýralama yaptýkdan sonra ,oluþacak olan sonuc kümesinin %25 ' lik kýsmýný listeleyelim. 

select top 25 percent  FirstName ,LastName ,Title ,(YEAR(Getdate())-YEAR(BirthDate))as Age
from
Employees 
order by Age desc
--Eðer  belittiðiniz oran sonucu 3.3 gibi bir sayý çýkarsa ,bu durumda bize ilk dört kaydý getirecektir. Yani Yukarý yönlü yuvarlama yapacaktýr. 


--Like kullanýmý:
--1.yol
select FirstName,LastName,Title 
from Employees
where 
FirstName ='Michael'

--2.yol
select FirstName,LastName,Title
from 
Employees
where
 FirstName like 'Michael'

--Adýnýn ilk harfi A ile baþlayanlarý getirin.
select FirstName,LastName,Title
from  Employees
where FirstName like 'A%'

--Adý  Son harfi N olanlar. 
select FirstName,LastName,Title
from 
Employees
where  FirstName like '%N'

--Adýnýn içerisinde e harfi geçenleri listeleyiniz.
select FirstName,LastName,Title
from 
Employees
where FirstName  like '%E%'
order by 1 desc

--Adýnýn ilk harfi a veya l olanlar.
select FirstName ,LastName,Title
from Employees 
where 
FirstName like 'A%'
OR
FirstName like 'L%'

--2.yol
SELECT FirstName,LastName,Title
FROM 
Employees
WHERE 
FirstName like '[AL]%'

--Adýnýn içerisinde r veya t bulunanlar.

select FirstName,LastName,Title
from 
Employees
where 
FirstName like '%[RT]%'

--Adýnýn ilk harfi j  ile r aralýðýnda olanlar. 

select FirstName ,LastName,Title
from 
Employees 
where  FirstName like '[J-R]%'
ORDER BY FirstName 

--Adý þu þekilde olanlar: tamer ,yasemin taner (A ile E arasýnda tek karakter olanlar)
select FirstName,LastName,Title
from 
Employees 
where 
FirstName like '%A_E%'

--(A ile E arasýnda iki  karakter olanlar)
select FirstName,LastName,Title
from Employees 
where 
FirstName like '%A__E%' --Alt tire sayýsý artar.

--Adýnýn ilk harfi M olmayanlar...
--1.yol
select FirstName,LastName,Title
from
Employees
where 
FirstName not like 'M%'
--2.yol
select FirstName,LastName,Title
from 
Employees 
where  FirstName like '[^M]%'
ORDER BY 1

--Adý T ile bitmeyeneler. 

select FirstName,LastName,Title
from 
Employees
where FirstName like '%[^T]'

--Adýnýn ilk harfinde A ile I aralaðýný bulunmayanlar.
--1.Yol
select FirstName,LastName,Title
from 
Employees 
where 
FirstName not like '[A-I]%'

--2.Yol 
select FirstName,LastName,Title
from 
Employees
where 
FirstName like '[^A-I]%'
ORDER BY 1;

use Northwind

--Adýnýn 2.harfi a veya t olmayanalar.
select FirstName,LastName,Title
from 
Employees
where FirstName like '_[^AT]%'
order by 2

--Adýnýn ilk iki harfi LA,LN,AA VEYA AN olanlar.

SELECT FirstName,LastName,Title

FROM 
Employees

where  FirstName like '[LA][AN]%'

--Ýlk karakter için  l veya a'dan birisini , 2.karakter için  a veya n'den birini seçeceðiz.la,ln,aa ve an olur.

--iÇERÝSÝNDE _GEÇEN ÝSÝMLERÝN LÝSTELENEMESÝ : 
--NORMALDE _ KARAKTERÝN ÖZEL BÝR ANLAMI VARDIR.  VE  TEK BÝR KARAKTER YERÝNE GEÇER , ANCAK [] ÝÇÝNDE BELÝRTMEYE KALKARSAM SIRADAN BÝR KARATERDEN FARKI YOKTUR .

SELECT FirstName,LastName,Title
FROM 
Employees
where FirstName like '%[_]%'

select FirstName ,LastName,Title
from 
Employees
where FirstName like '%\_%' escape '\'

--Customers tablosundaki customerýd'sinin 2 harfi A ,4.harfi t olanlarýn % 10 'luk kýsmýný getiren sorguyu yazýnýz.
select TOP 10  PERCENT CustomerID,CompanyName,ContactName
from 
Customers 
where CustomerID like '_A_T%'

--VeriTabaný iþlemleri 
--1)Ýnsert : Bir veritabanýndaki tablolardan birine kayýt eklemek için kullanýlan komut. 
/*
Ýnsert into <tablo adi> (<Sütun_Ýsimleri>) 
values <Sütün_Deðerleri >
*/
Use Northwind 

go 

insert into Categories (CategoryName,Description)
values('Baklagiller' ,'Kýymetlidir bunlardaki vitamin.')


select * from Categories
--Aþaðýdaki insert iþlemi baþarýsýz olacak. 
--Çünkü categories tablosundaki null geçilemeyen categoryName sütnü  için bir deðer atamasýnda bulunmadýk. 
--Bir tablonun null deðer içermeyen stunlarýnda insert iþlemi sýrasýnda mutlaka deðer atamasýnda bulunmmalýyýz.
--(Eðer identiy özelliði aktif ise  . buraya karýþmadan devam edebiliririz.)
--Otomatik artan özelliði bizim yerimize ilgli kolona deðerini gönderecektir. 

insert into Categories (Description)
values ('kategori adý girilmeli ')

--Eðer bir balo stünlarýrýn hepsine veri gireceksek tablo adýndan sonra stün adlarýný açýktan belirtmenize gerek yoktur. Direkt values ile stunlarýn içine deðerleri atayabilirsiniz. 
--Ancak dikkat etmeniz gereken stunlarýn verilerini girerken yapýlarýna dikkat etmeni gerekmektedir. 
--(DATA TYPE) TABLONUN YAPISINA UYGUNLUÐA DÝKKAT ETMEK LAZIM .
--(Yani CompanyName sütünu  phone sütüundan önce olduðu için values kýsmýnda ilk belirticeðimiz deðer companyname  sütununa ait  olmalý aksi halde sutunlarý veri tiplerinin uyuölu olduðu bir durum denk gelirse iþste busefer yanlýþ datalar girersiniz. 
insert into Shippers values
('MNG KARGO' ,'(212) 556 32 89')

select * from Shippers

--Eðer stun isimlerini belitirsek verileri belirttiðimiz sýrada girmeliyiz. 
 insert into Shippers (Phone,CompanyName)
 
 values ('(216) 459 12 41','Aras Kargo')

--Customer Tablosuna 'Bilge Adam þirketini ekleyiniz'.

 insert into Customers (CustomerID,CompanyName)

 values ('BLGDM','Bilge Adam') 
--Update 
--2) Update : Bir tablodaki kayýtlarýn güncellemek için kullanýlýr. 
--Dikkat edilmesi gerekn hangi kaydu güncelliyeceðimizi açýktan ifade etmeniz gerekiyor.
--Aksi Halde tüm kayýtlarý güncellerisin.

 select *
 into Calýsanlar
 from 
 Employees

select * from Calýsanlar
 /*
 Update <TabloAdi> 
 set <sütun_adi> = <yenideðer> ,<sütun_adi> = <yenideðer> ,<sütun_adi> = <yenideðer> ,<sütun_adi> = <yenideðer>
 */

--Customers tablosundaki customerId sütünun tipi nchar(5)' tir.
--Yani ,bu stün  identity olarak belirtilemez ,Dolayýsý ile bu tabloya bir kayýt girerken customerId sütutuna da kendimzi veri girmeliyiz. 
select * from Customers

Update Calýsanlar
set  LastName ='Oðuz';
--ÇALIÞANLAR TABLOSUNDAKÝ BÜTÜN KAYITLARIN SOYADI BÝLGÝSÝ DEÐÝÞTÝRÝLECEKDÝR.ÇÜNKÜ GÜNCELLEME ÝÞLEMÝNÝ YAPARKEN HANGÝ KAYIT GÜNCELLENECEK AÇIKTAN BELÝRTMEDÝK (Ýstenmeyen durumdur.)

SELECT * FROM Calýsanlar

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
into 
urunler
from Products
--Products tablosundaki veriler,Urunler tablosuna kopyalandý. 
Update urunler
set UnitPrice = UnitPrice+ (UnitPrice*0.05)
select * from  urunler

--3)Delete :Bir tabloddan kayýt silmek için kullanacaðýmýz komuttur. 
--Ayný update iþlemi gibi dikkat etmeniz gerekir.
--Çünkü birden fazla kayýt yanlýþlýkla silinebilir. 

/*
Delete from <Tablo_Adi>
*/
Select * from Calýsanlar

delete from Employees where EmployeeID =11 --TEK KAYIT SÝLÝNECEKTÝR. 

drop table Calýsanlar

select * into calýsanlar from Employees

delete from calýsanlar 
where FirstName ='Michael'

---Ünvaný Mr. ve Dr. olanlarý siliniz
--(yok ise çalýþanlar tablosunu oluiþtur.)

delete  from calýsanlar
where TitleOfCourtesy in('Dr.','Mr.')
-------------------------Dml Bitis-----------------------------------

--Aggregate Functions 

--1)Tarih Fonksiyonlarý 
--DatePart () Kullanýmý: Bir tarih bilgisinden istediðimiz kýsmý elde etmemiz saðlýyor .
Select  FirstName,LastName,DATEPART(YY,BirthDate) as [yýl]
from 
Employees 
order by yýl desc --Yýl bilgisini alýr.

select FirstName,LastName ,DATEPART(DY,BirthDate) as [Day of Year] 
from 
Employees
order by [Day of Year] desc --Yýlýn Kaçýncý günü 

---Yýlýn Kaçýncý ayý .
select  FirstName,LastName,DATEPART(M,BirthDate) as [Mouth]
from 
Employees
order by Mouth desc

select  FirstName,LastName ,DATEPART(WK,BirthDate)as [week of year]
from  Employees
order by [week of year] desc ; --Yýlýn Kaçýncý haftasý 

select  FirstName ,LastName,DATEPART(DW,BirthDate) as [day of week]
from 
Employees --Haftanýn kaçýncý günü.
ORDER BY [day of week] DESC

select FirstName,LastName,DATEPART(HH,GETDATE()) AS SAAT  
from
Employees 
ORDER BY SAAT DESC --Saat getirir. 

SELECT  FirstName,LastName,DATEPART(MI,GETDATE()) as dakika
FROM 
Employees 
ORDER BY [dakika] desc--Dakika getirir. 

select  FirstName,LastName, DATEPART(SS,GETDATE())AS SANÝYE
from 
Employees
ORDER BY SANÝYE DESC--SANÝYE GETÝRÝR.

select FirstName,LastName ,datepart (MS,getdate())SALÝSE
from 
Employees
ORDER BY SALÝSE DESC
--DateDiff() kullanýmý: iki tarih arasýndaki farký verir. 
select (FirstName+' '+LastName) as  isim ,DATEDIFF(YEAR ,BirthDate,GETDATE())as yas,
DATEDIFF(DAY , HireDate ,GETDATE()) as [ödenen prim gün]
from 
Employees

select 
FirstName,LastName,DATEDIFF(hour,BirthDate ,GETDATE()) as  [kaç saat geçti]
from 
Employees

--String Function 
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

select RIGHT('Bilge Adam',6) as [saðdan karakter sayýsý ]

select LEN('Bilge Adam') as [Karakter adeti ]

select LOWER('BÝLGE ADAM') AS [HEPSÝKUCUK]

SELECT UPPER('Bilge adam') as [Hepsi büyük]

SELECT LTRIM ('                             Bilge Adam')as [Soldaki boþluklarý silecek]
select RTRIM('Bilge Adam                            ') as [Saðdaki Boþluklarý siler];

select LEN ( LTRIM(RTRIM('                   Bilge Adam                            '))) as [Tüm boþluklarý siler]

--Trim ile alabilirsin.

select  replace ('birbirlerinine','bir','uc') as [metinlerin yerine yenisini atar]

select SUBSTRING('Bilge adam yazýlým kursuna hoþgeldiniz.',4,6) as 'Alt string''leri oluþturulur.'
--Yanyana iki tane  tek týrnak yazdýðýmýzda ,bu ifade tek týrnak yerine geçer.
--(Tek týrnak özel bir anlam ifade ettiðinden dolayý.)

select REVERSE('Bilge Adam Akamdemi') as 'Tersine Çevir'; --Reverse Ters Çevirir.
select 'Bilge Adam'+SPACE(30)+'Akademi' as [Belirtilen miktarda boþuk koyar. ...]

select  REPLICATE('Bilge',5) AS 'Belirtilen metin ,belirtilen miktarda çoðaltýlýr. ';

--Aggeragete Fonksiyonlarý - (Toplam ,matematiksel Func.GRUPLAMALI fUNC;) 

SELECT COUNT(*) 
FROM 
Employees --BÝR TABLODAKÝ TOPLAM KAYDI ÖÐRENEBÝLRÝSÝNÝZ. 

SELECT COUNT (EmployeeID)
FROM 
Employees

SELECT COUNT (REGÝON )
FROM
Employees
--Region sütunundaki kayýt sayýsý (region sütunu null geçilebileceði için bir tablodaki kayýt sayýsýný bu sutundan yola çýkarak öðrenmek yanlýþ sonuçlar çýkarabilir. 
--Çünkü aggaregte func null deðere içeren kayýtlarý dikkate almaz. 
--Bu neden ile kayýt sayýsýný öðrenebilmek için ya * karakterini yada null geçilemeyen stunlardan birinin adýný kullanmanýz gerekir. 

select count (city)
from
Employees 
--9  adet var görürnür .Fakat bazý þehirler birden fazla kez tekrarlamýþtýr. 

select COUNT (distinct  City)
from 
Employees
--Farklý olan þehirlerin sayýsýný verir. 

select SUM(EmployeeID)
from 
Employees
--EmployeeId Kolonundaki bütün deðerleri topladý 

--Çalýþanlarýn yaþlarýnýn toplamý.

--1.Yol
select Sum (Year(getdate())-Year(BirthDate))as yaslaruntoplamý
FROM
employees

--2.yol
select sum(DATEDIFF(Year,Birthdate,getdate())) as [yaslarýn toplamý]
from Employees

--select sum(FirstName) as [yaslarýn toplamý]
--from Employees

--Sum fonksiyonu sayýsal stunlarda kullanýlýrlar. 

--AVG(SütünAdi): Bir sütündaki deðerin ortalamasýný sizlere döner. 

select AVG(EmployeeId)
from
Employees

--Çalýþanlarýn yaþlarýnýn ortalamasý.

select avg (DateDiff(YEAR,BirthDate,GETDATE()))
from 
Employees

--Null olanlar iþleme katýlmayacaðý için ortalama hesaplanýrken bütün kiþilerin sayýsýna bölünmez ,null olmayan kiþilerin sayýsýna bölünür.

--Select avg (lastname )
--from 
--Employees
--Avg Fonk sayýsal sutunlar kullanýlýr .
select max (EmployeeID)
from
Employees

select max(Firstname ) --Stunda sayýsal stun olmasan gerek yok .Alfabetik olrak en büyük deðeri verir. 
from 
employees ;

Select Min(employeeId) 
from
Employees

select min(firstname)
from
Employees

--Sayýsal deðer iþlemleri.
select 3+2 
select 3*3
select 4/2
select 9-2

--Pý :Pi sayýsýný verir. 

select PI() AS [PI]

--SÝN :Sinüs alýr.
SELECT Sin( PI())

--power : Üstü Alýr.
select power(2,3)

--Abs : Mutalk deðer alýr.
select abs (-12)

select Rand()  -- 0 ile 1 arasýnda rasgele deðer üretiyor. 

select floor (RAND()*100)

--Case When -Then : 
select FirstName ad  ,soyad=LastName ,Title as görev ,Country as Ulke 
from 
Employees

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
 select Country as ülke, COUNT(*) as kisisayýsý from
 Employees 
 where  Country is not null 
 group by Country

--Çalýþanlarýn yapmýþ olduðu sipariþ adeti.

 select EmployeeID , COUNT(*) as [Siparis adeti]

 from 
 Orders
 Group By EmployeeID
 order by [Siparis adeti] desc ;

--Ürünlerin bedeli 35 Dolar 'dan az olan ürünlerin kategorilerine göre gruplandýrýlmasý.
select 

 CategoryID,COUNT(*) as Adet
 from 
 Products
 where UnitPrice<=35  
 group by CategoryID 
 order by Adet

--Baþ harfi A-K aralýðýnda olan ve stok miktarý 5 ile 50 arasýnda olan ürünlerin kategorilerinie göre gruplayýnýz.
 select CategoryID ,COUNT(*) as adet
 from
 Products
 where 
 (ProductName like '[A-K]%')
 And 
 (UnitsInStock between 5 and 50)
 group by CategoryID
 order by adet desc 
--Her bir sipariþteki toplam ürün sayýsýný bulunuz.S
 Select OrderID,Sum(Quantity) as 'Satýlan Ürünler'
 from  [Order Details]
 group by OrderID

select
 OrderID,Sum(UnitPrice*Quantity*(1-Discount)) As toplamTutar
 from 
 [Order Details]
 group by OrderID 
 order by  toplamTutar desc;
---Having Kullanýmý 
--Sorgu Sonucu gelen sonuç Kümesi üzerinde  Aggregate  gonksiyonlarýn baðlý olacak þekilde bir filitreleme iþlemi yapacaksak where yerine having anahtar kelimesini  kullanýrýz.
--Bu sayade aggregate function flitreleme iþlemine katýlýrlar.
---Eðer Aggregate function sorgunuzda yok ise  having kullanimi where ile ayný filitreleme iþlemini yapacaktýr.
--Toplam tutarý  2500-3500 arasýnda olan siparþlerin listelenmesi.
 select OrderID  as SiparisKodu ,Sum(Quantity*UnitPrice*(1-Discount)) as ToplamTutar
 from
 [Order Details]
 --where Sum(Quantity*UnitPrice*(1-Discount))  between 2500 and 3500 
 group by OrderID 
 having  Sum(Quantity*UnitPrice*(1-Discount))  between 2500 and 3500 
 order by ToplamTutar desc

--Herbir Sipariþteki toplam ürün sayýsý200'den az olanlarý 

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

--1000 adetten fazla satýlan ürünlerin product ýd göre gruplandýrýlmasý.
select ProductID ,Sum(quantity) as 'Satýþ ADETÝ'
from [Order Details]
 group by ProductID
 having SUM(Quantity)>1000

--Normal data silmek  için delete komutunu kullanýrýz .Fakat tablodaki identiy olan kolon deðerleri artmýþ ve gitmiþ oluyor.

Truncate Table test
--ÝDENTÝTY Sýfýrlanmak istiyorsak  "TRUNCATE KULLANILMALI"

--Ýç içe sorgular (Subquery)

declare @MaxFiyat money = (select max (UnitPrice) from Products)

select * from Products where UnitPrice =@MaxFiyat

select * from Products where UnitPrice = (select max (UnitPrice) from Products)

--Fiyatý Ortalama fiyatýnýn üzerinde olan  ürünleri getirin.
select * from Products 
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

select * from 
Products
where ProductID  not in (select 
ProductID
from 
[Order Details] )
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

--Not exists
select * from Employees e1
where not exists (select EmployeeID  from Orders e2
where e1.EmployeeID=e2.EmployeeID)

---Ýç içe yazýlan subqquery'den dönen tüm kayýtlar içinde eþleþme yapýldýktan  sonra ana query çalýþmasýný tamamlar. 
--exists ise subquery yi eþleme yapýlan kayýtlara göre sonuçlandýrýr. 
--ve ilave olarak gelen kayýtlar içinde eþleþme yapmasýna gerek kalmaz.Exists zaten subquery'den ihtiyacý olan kayýtlarý getirmiþ olacaktýr.
--Exists condition (if-else) içerisinde de kullanýlabilir.

---Join Ýþlemi 
--1)Ýnner Join :Bþr tablodaki her bir kaydýn diðer tabloda bir karþýlýðý  olan kayýtlar listelenir.
--(inner join) =>> join  inner cümleciðini yazmasada  yine inner join demekdir. 


select ProductName,CategoryName, 
from Products inner join Categories on Products.CategoryID=Categories.CategoryID

--Products tablosundan Product_ýd ProductName,CategoryÝd,
--categories tablosundan da cateName,Description

select Products.CategoryId,Products.ProductID,Products.ProductName,Categories.CategoryName,Categories.Description

from 
Products inner join Categories on Products.CategoryID=Categories.CategoryID
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

--Not: CAST( Sum(UnitPrice*Quantity*(1-Discount)) AS decimal(15,3) ) AS TOPLAM =>>
--Virgülden önce 15 ,Virgülden sonra 3 haneye kadar üstte elde edilen deðeri gösterir. 
--Üstte elde ettiðimiz ondalýklý deðeri stringe çevirdik.
--Sql 'de tip dönüþümleri için 2 tip dönüþtürme fonksiyonu var.Cast ve Convert

--Herbir Kategori için ortalama ürün fiyatýný bulunuz. Fakat ortalama fiyatý 10 'dan büyük olanlarý getiriniz. 

select Categories.CategoryName ,AVG(UnitPrice)
from 
 Products inner join Categories on Categories.CategoryID=Products.CategoryID
 group by Categories.CategoryName
 having  AVG(UnitPrice)>10
 
--2)Outer Join
--2.1) Left outer join
--Sorguda katýlan tablolardan soldakiniin tüm kayýtlarýný getirirken ,saðdaki tabloda sadece iliþkisi olan kayýtlar getirilir. 

 select ProductName,CategoryName 

 from 
 Products as p left outer join  Categories as c 
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
from 
Employees as e1 right join  Employees as e2 on 
e2.ReportsTo=e1.EmployeeID

select ProductName,CategoryName

from  Products right join Categories on Products.CategoryID=Categories.CategoryID

---3)Full Join :Her iki tablodaki tüm kayýtlar getirlir. left ve right join 'nin birleþimidir.

select Products.ProductName,Categories.CategoryName

from Categories full join Products on Categories.CategoryID=Products.CategoryID;


---4.))Cross Join : Bir tablodaki bir kaydýn diðer tablodaki tüm kayýtlar ile eþlemesi gerekir. 
select  COUNT(*)
from
Categories --10

select COUNT (*)
from
Products --77

select CategoryName,ProductName
from  Categories cross Join Products

--View Yapýsý
--==Kullaným amacý ==> 
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
