CREATE TABLE CUSTOMER(
    LOGIN NVARCHAR(100) PRIMARY KEY,
    EMAIL NVARCHAR(100),
    NEV NVARCHAR(100),
    SZULEV INT,
    NEM NVARCHAR(1),
    CIM NVARCHAR(100)
);

INSERT INTO CUSTOMER(LOGIN,EMAIL,NEV, SZULEV, NEM, CIM) VALUES 
('adam1','adam3@gmail.com','Barkóci Ádám',1970,'F','3910 Tokaj, Dózsa György utca 37.'),
('adam3','adam3@gmail.com','Barkóci Ádám',1970,'F','3910 Tokaj, Dózsa György utca 37.'),
('adam4','ádám.bieniek@mail.hu','Bieniek Ádám',1976,'F','8630 Balatonboglár, Juhászföldi út 1.'),
('agnes','agnes@gmail.com','Lengyel Ágnes',1979,'N','5200 Törökszentmiklós, Deák Ferenc út 5.'),
('agnes3','agnes3@gmail.com','Hartyánszky Ágnes',1967,'N','6430 Bácsalmás, Posta köz 2.'),
('AGNESH','AGNESH@gmail.com','Horváth Ágnes',1981,'N','8200 Veszprém, Rákóczi utca 21.'),
('AGNESK','AGNESK@gmail.com','Kovács Ágnes',1988,'N','1084 Budapest, Endrődi Sándor utca 47.'),
('akos','ákos.bíró@mail.hu','Bíró Ákos',1982,'F','9023 Győr, Kossuth Lajos utca 47/b.'),
('aladar','aladár.dunai@mail.hu','Dunai Aladár',1980,'F','5931 Nagyszénás, Árpád utca 23.')

CREATE TABLE CUSTOMER_MASKED(
  LOGIN NVARCHAR(100) PRIMARY KEY,
  EMAIL NVARCHAR(100) MASKED WITH (Function = 'email()'),
  NEV NVARCHAR(100)  MASKED WITH (Function = 'partial(1,"XXX",1)'),
  SZULEV INT MASKED WITH (Function= 'random(1960,2010)'),
  NEM NVARCHAR(1),
  CIM NVARCHAR(100) MASKED WITH (FUNCTION = 'default()')
);

INSERT INTO CUSTOMER_MASKED (LOGIN, EMAIL, NEV, SZULEV, NEM, CIM)
SELECT LOGIN, EMAIL, NEV, SZULEV, NEM, CIM
FROM CUSTOMER;

CREATE USER m_user WITHOUT LOGIN;
GRANT SELECT ON CUSTOMER_MASKED TO m_user;

EXECUTE AS USER = 'm_user';
SELECT * FROM CUSTOMER_MASKED;
REVERT;