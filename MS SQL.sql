/*1. Készítsünk nézetet VSZOBA néven, amely megjeleníti a szobák adatai mellett a megfelelő szálláshely nevét, helyét és a csillagok számát is!

Az oszlopoknak nem szükséges külön nevet adni!
Teszteljük is a nézetet, pl: SELECT * FROM VSZOBA*/

create OR ALTER view VSZOBA AS 
select sz.*, 
	   szh.szallas_nev,
       szh.HELY,
       szh.CSILLAGOK_SZAMA
from Szallashely szh join szoba sz on szh.SZALLAS_ID=sz.SZALLAS_FK

select * from VSZOBA

/*2 Készítsen tárolt eljárást SPUgyfelFoglalasok, amely a paraméterként megkapott ügyfél azonosítóhoz tartozó foglalások adatait listázza!
Teszteljük a tárolt eljárás működését, pl: EXEC SPUgyfelFoglalasok 'laszlo2'
*/

CReate or alter PROCEDURE SPUgyfelFoglalasok
--paraméterek
@ugyfelazon nvarchar(40)
AS
BEGIN
--sql kóddem
select * 
from foglalas 
where ugyfel_fk=@ugyfelazon
END
exec SPUgyfelFoglalasok 'laszlo2'

/*
3. Készítsen skalár értékű függvényt UDFFerohely néven, amely visszaadja, hogy a paraméterként megkapott foglalás azonosítóhoz hány férőhelyes szoba tartozik!
a. Teszteljük a függvény működését!
*/
--skalár értékű: barmilyen tipust ad vissza de csak egyet, nem összetett

create or alter FUNCTION UDFFerohely
(
--paraméterek
@fazon int 
)
RETURNS int  --visszaadott érték típusa
AS
BEGIN
DECLARE @ferohely int 

 SELECT @ferohely = sz.FEROHELY
 from Foglalas f join szoba sz on f.SZOBA_FK=sz.SZOBA_ID
 where f.FOGLALAS_PK=@fazon

RETURN @ferohely --visszaadott érték

END

select dbo.UDFFerohely(650)  --séma név 

/*
4. Készítsünk tárolt eljárást SPRangsor néven, amely rangsorolja a szálláshelyeket a foglalások száma alapján (a legtöbb foglalás legyen a rangsorban az első). A listában a szállás azonosítója, neve és a rangsor szerinti helyezés jelenjen meg - holtverseny esetén ugrással (ne sűrűn)! 
a. Teszteljük a tárolt eljárást, pl: EXEC SPRangsor
*/

/*
5. Készítsünk nézetet VFoglalasreszletek néven, amely a következő adatokat jeleníti meg: foglalás azonosítója, az ügyfél neve, a szálláshely neve és helye, a foglalás kezdete és vége, és a szoba száma. 

a. Az oszlopokat nevezzük el értelemszerűen! 
b. Teszteljük a nézet működését, pl: SELECT * FROM VFoglalasreszletek
*/

/*
6.
Készítsen tábla értékű függvényt NEPTUNKÓD_UDFFoglalasnelkuliek néven, amely azon ügyfelek adatait listázza, akik még nem foglaltak egyszer sem az adott évben adott hónapjában! A függvény paraméterként kapja meg a foglalás évét és hónapját! (Itt is a METTOL dátummal dolgozzunk) 
a. Teszteljük is a függvény működését, pl: SELECT * FROM dbo.UJAENB_UDFFoglalasnelkuliek(2016, 10)
*/


