--táblák létrehozás

CREATE TABLE ZipCodes (
    ZipCode VARCHAR(10) PRIMARY KEY,
    City VARCHAR(100) NOT NULL,
    Region VARCHAR(100) NOT NULL
);

CREATE TABLE Customer (
    CustomerID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    PhoneNumber VARCHAR(20),
    Street VARCHAR(255),
    ZipCode VARCHAR(10),
    Gender CHAR(1),
    FOREIGN KEY (ZipCode) REFERENCES ZipCodes(ZipCode)
);

CREATE TABLE Employee (
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Street VARCHAR(255),
    ZipCode VARCHAR(10),
    PayRate DECIMAL(10,2),
    FOREIGN KEY (ZipCode) REFERENCES ZipCodes(ZipCode)
);

CREATE TABLE SalonService (
    ServiceID INT IDENTITY(1,1) PRIMARY KEY,
    ServiceName VARCHAR(100) NOT NULL,
    ServiceDuration INT, 
    ServicePrice DECIMAL(10,2),
    ServiceMaterials TEXT
);

CREATE TABLE Appointment (
    AppointmentID INT IDENTITY(1,1) PRIMARY KEY,
    AppointmentDateTime DATETIME NOT NULL,
    CustomerID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

CREATE TABLE ServiceRendered (
    AppointmentID INT,
    LineItemNumber INT,
    ServiceID INT,
    ServiceExtendedPrice DECIMAL(10,2),
    EmployeeID INT,
    PRIMARY KEY (AppointmentID, LineItemNumber),
    FOREIGN KEY (AppointmentID) REFERENCES Appointment(AppointmentID),
    FOREIGN KEY (ServiceID) REFERENCES SalonService(ServiceID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);


--tesztadatok betöltése

INSERT INTO ZipCodes (ZipCode, City, Region) VALUES
  ('1111', 'Budapest', 'Pest'),
  ('2222', 'Győr', 'Győr-Moson'),
  ('3333', 'Debrecen', 'Hajdú-Bihar'),
  ('4444', 'Szeged', 'Csongrád');

INSERT INTO Customer (Name, PhoneNumber, Street, ZipCode, Gender) VALUES
('Varga Sára', '06-49/946 9767', 'Petőfi utca', '1111', 'N'),
('Farkas Attila', '68/677 3039', 'József attila utca', '3333', 'F'),
('Sipos Dóra', '+36 39 531-5378', 'Mellékváradi út', '2222', 'N'),
('Horváth Benjámin', '98/474-3890', 'Mártonházai utca', '1111', 'F'),
('Lukács János', '(06)83/522-2943', 'Váci utca', '4444', 'F'),
('Gál Nikolett', '(06)23/997-9572', 'Kisszéki utca', '1111', 'N'),
('Pataki Barbara', '06-91/726 5768', 'Ózdi utca', '2222', 'N'),
('Fülöp Ádám', '06-18/692 2728', 'Ady endre utca', '1111', 'F'),
('Székely Ernő', '(06)64/046-8066', 'Béke utca', '4444', 'F'),
('Rácz Sándor', '21/489 7023', 'Pusztagyörgyi utca', '4444', 'F'),
('Takács Zsolt', '(06)93/377-3994', 'Székesfehérvári utca', '1111', 'F'),
('Lengyel Krisztina', '53/855 4711', 'Belsőgyörgyi utca', '4444', 'N'),
('Varga Ernő', '(21)/593-0513', 'Székesfehérvári utca', '3333', 'F'),
('Tóth Tímea', '(06)36/457-9769', 'Apátii út', '2222', 'N'),
('Biró József', '06-2/573 8712', 'Egeri utca', '1111', 'F'),
('Tóth Mariann', '(06)94/332-6945', 'Fürdőkőrösi utca', '4444', 'N'),
('Papp Attila', '06-73/330 6401', 'Miskolci utca', '3333', 'F'),
('Nagy Edit', '+36 75 780-4344', 'Bajai út', '3333', 'N'),
('Takács Péter', '(06)31/070-3654', 'Keresztapátii tér', '4444', 'F'),
('Nagy József', '(11)/732-2518', 'Salgótarjáni utca', '4444', 'F');

INSERT INTO Employee (Name, Street, ZipCode, PayRate) VALUES
('Kovács János', 'Székesfehérvári tér', '3333', 3795.29),
('Bognár Alex', 'Újhetveni utca', '3333', 3492.82),
('Török Dávid', 'Fürdőfalui utca', '1111', 2854.99),
('Horváth József', 'Tótkőrösi utca', '2222', 3727.68),
('Lukács Annamária', 'Keresztvárai utca', '1111', 3826.38);

INSERT INTO SalonService (ServiceName, ServiceDuration, ServicePrice, ServiceMaterials) VALUES
  ('Hajvágás', 30, 4000, 'Olló, fésű'),
  ('Hajfestés', 90, 10000, 'Festék, ecset'),
  ('Dauer', 60, 8000, 'Dauerfolyadék'),
  ('Hajmosás', 15, 2000, 'Sampon'),
  ('Férfi hajvágás', 25, 3500, 'Olló');

INSERT INTO Appointment (AppointmentDateTime, CustomerID) VALUES
  ('2025-05-20 00:08', 4),
  ('2025-05-28 01:08', 15),
  ('2025-05-19 01:08', 6),
  ('2025-05-15 21:08', 7),
  ('2025-05-27 22:08', 20),
  ('2025-05-14 22:08', 18),
  ('2025-05-20 00:08', 15),
  ('2025-05-15 01:08', 18),
  ('2025-05-14 20:08', 2),
  ('2025-05-20 00:08', 11),
  ('2025-05-14 05:08', 3),
  ('2025-05-14 03:08', 11),
  ('2025-05-28 03:08', 13),
  ('2025-05-15 22:08', 5),
  ('2025-05-25 04:08', 8),
  ('2025-05-26 02:08', 9),
  ('2025-05-20 01:08', 19),
  ('2025-05-12 04:08', 8),
  ('2025-05-09 20:08', 16),
  ('2025-05-11 22:08', 4);

INSERT INTO ServiceRendered (AppointmentID, LineItemNumber, ServiceID, ServiceExtendedPrice, EmployeeID) VALUES
  (1, 1, 5, 3500, 4),
  (1, 2, 1, 4000, 4),
  (2, 1, 5, 3500, 5),
  (2, 2, 3, 8000, 1),
  (3, 1, 5, 3500, 3),
  (4, 1, 1, 4000, 4),
  (4, 2, 3, 8000, 2),
  (5, 1, 1, 4000, 5),
  (5, 2, 3, 8000, 2),
  (6, 1, 3, 8000, 5),
  (7, 1, 2, 10000, 3),
  (8, 1, 5, 3500, 5),
  (9, 1, 5, 3500, 3),
  (10, 1, 1, 4000, 3),
  (10, 2, 5, 3500, 3),
  (11, 1, 1, 4000, 2),
  (12, 1, 1, 4000, 4),
  (13, 1, 5, 3500, 2),
  (14, 1, 4, 2000, 5),
  (15, 1, 3, 8000, 5),
  (16, 1, 2, 10000, 3),
  (16, 2, 5, 3500, 4),
  (17, 1, 4, 2000, 1),
  (17, 2, 5, 3500, 2),
  (18, 1, 1, 4000, 3),
  (19, 1, 5, 3500, 5),
  (20, 1, 5, 3500, 2);

--lekérdezések

--alkalmazottankénti összbevétel
SELECT Name AS EmployeeName,
       SUM(R.ServiceExtendedPrice) AS TotalRevenue
FROM ServiceRendered R
JOIN Employee E ON R.EmployeeID = E.EmployeeID
GROUP BY E.Name
ORDER BY TotalRevenue DESC;

--összesítő táblázat
SELECT 
  A.AppointmentDateTime,
  C.Name AS Customer,
  E.Name AS Employee,
  SS.ServiceName,
  SR.ServiceExtendedPrice
FROM ServiceRendered SR
JOIN Appointment A ON SR.AppointmentID = A.AppointmentID
JOIN Customer C ON A.CustomerID = C.CustomerID
JOIN Employee E ON SR.EmployeeID = E.EmployeeID
JOIN SalonService SS ON SR.ServiceID = SS.ServiceID
ORDER BY A.AppointmentDateTime;

--Hónap dolgozója
SELECT TOP 1
    E.Name AS EmployeeName,
    COUNT(*) AS ServiceCount
FROM ServiceRendered SR
JOIN Employee E ON SR.EmployeeID = E.EmployeeID
JOIN Appointment A ON SR.AppointmentID = A.AppointmentID
WHERE MONTH(A.AppointmentDateTime) = MONTH(GETDATE())
GROUP BY E.Name
ORDER BY ServiceCount DESC;

-- ügyfelenként összesített látogatások időrendben
SELECT C.NAME, COUNT(*) OVER(PARTITION BY C.CustomerID 
ORDER BY A.AppointmentDateTime RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS 'VISIT SO FAR'
FROM CUSTOMER C JOIN Appointment A ON A.CustomerID = C.CustomerID

-- TOP 5 LEGNÉPSZERŰBB SZOLGÁLTATÁS RÉGIONKÉNT
SELECT *
FROM(
    SELECT 
        Z.Region,
        SS.ServiceName,
        COUNT(*) as servicecount,
        RANK() OVER(PARTITION BY Z.Region ORDER BY COUNT(*) DESC) AS RANK
    FROM ZipCodes Z
    JOIN EMPLOYEE E ON E.ZipCode = Z.ZipCode
    JOIN ServiceRendered SR ON SR.EmployeeID = E.EmployeeID
    JOIN SalonService SS ON SS.ServiceID = SR.ServiceID
    GROUP BY Z.Region, SS.ServiceName
) AS RANKING
WHERE RANK <= 5
ORDER BY Region, RANK

---Kik vették már igénybe a hajfestés szolgáltatást a szalonban?
SELECT C.Name
FROM Customer C
WHERE EXISTS (
    SELECT *
    FROM ServiceRendered SR
    JOIN SalonService SS ON SR.ServiceID = SS.ServiceID
    JOIN Appointment A ON A.AppointmentID=SR.AppointmentID
    JOIN CUSTOMER C2 ON A.CustomerID=C2.CustomerID
    WHERE C2.CustomerID = C.CUSTOMERID AND SS.ServiceName = 'Hajfestés'
);

--profit napi bontásban
select cast(AppointmentDateTime as date), 
		sum(ServiceExtendedPrice) as 'Bevétel Ft-ban',
        sum((ss.ServiceDuration / 60.0) * e.PayRate) as 'Dolgozók kifizetése Ft-ban',
        Round(SUM(sr.ServiceExtendedPrice - ((ss.ServiceDuration / 60.0) * e.PayRate)),0) as 'Profit Ft-ban'
from ServiceRendered sr
	JOIN Appointment a ON sr.AppointmentID = a.AppointmentID
	JOIN SalonService ss ON sr.ServiceID = ss.ServiceID
	JOIN Employee e ON sr.EmployeeID = e.EmployeeID
where ServiceExtendedPrice is not null
group by cast(AppointmentDateTime as date)