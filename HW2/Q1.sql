-- DB application used = SQLite | GUI used = DB Browser for SQLite
-- The queries (Section A) create the tables (employee, meeting , employee_meeting_bridge , symptom , scan , test , patient , health_status , notification)
-- Note 1: I have created employee_meeting_bridge to handle many to many relationship between employee and meeting table
-- Note 2: I have used name "patient" instead of "case" (mentioned in homework ER digram given for reference) for the table 
-- The queries (Section B) insert data in the tables.

-- ================================ Section A ================================

CREATE TABLE "Employee" (
	"Employee_id"	INTEGER NOT NULL,
	"Employee_name"	varchar(255) NOT NULL,
	"Employee_dob"	DATE NOT NULL,
	"Employee_office_no"	int NOT NULL,
	"Employee_floor_no"	int NOT NULL CHECK("Employee_floor_no" BETWEEN 1 AND 10),
	"Employee_phone_no"	bigint NOT NULL CHECK("Employee_phone_no" BETWEEN 1000000000 AND 9999999999) UNIQUE,
	"Employee_email"	varchar(50) UNIQUE,
	PRIMARY KEY("Employee_id" AUTOINCREMENT)
);

CREATE TABLE "Meeting" (
	"Meeting_id"	INTEGER NOT NULL,
	"Meeting_room_no"	int NOT NULL,
	"Meeting_floor_no"	int NOT NULL CHECK("Meeting_floor_no" BETWEEN 1 AND 10),
	"Meeting_start_time"	int NOT NULL CHECK("Meeting_start_time" BETWEEN 8 AND 18),
	PRIMARY KEY("Meeting_id" AUTOINCREMENT)
);

CREATE TABLE "Employee_Meeting_Bridge" (
	"Employee_id"	int,
	"Meeting_id"	int,
	PRIMARY KEY("Employee_id","Meeting_id"),
	FOREIGN KEY("Employee_id") REFERENCES "Employee"("Employee_id"),
	FOREIGN KEY("Meeting_id") REFERENCES "Meeting"("Meeting_id")
);

CREATE TABLE "Symptom" (
	"Row_id"	INTEGER NOT NULL,
	"Employee_id"	int,
	"Date_reported"	date NOT NULL,
	"Symptom_id"	int NOT NULL CHECK("Symptom_id" BETWEEN 1 AND 5),
	PRIMARY KEY("Row_id" AUTOINCREMENT),
	FOREIGN KEY("Employee_id") REFERENCES "Employee"("Employee_id")
);

CREATE TABLE "Scan" (
	"Scan_id"	INTEGER NOT NULL,
	"Scan_date"	date NOT NULL,
	"Scan_time"	int NOT NULL CHECK("Scan_time" BETWEEN 8 AND 18),
	"Employee_id"	int,
	"Temperature"	float NOT NULL,
	PRIMARY KEY("Scan_id" AUTOINCREMENT),
	FOREIGN KEY("Employee_id") REFERENCES "Employee"("Employee_id")
);

CREATE TABLE "Test" (
	"Test_id"	INTEGER NOT NULL,
	"Scan_id"	int,
	"Test_location"	varchar(50) NOT NULL,
	"Test_date"	date NOT NULL,
	"Test_time"	int NOT NULL CHECK("Test_time" BETWEEN 0 AND 23),
	"Employee_id"	int,
	"Test_result"	varchar(25) NOT NULL CHECK("Test_result" IN ('Positive', 'Negative')),
	PRIMARY KEY("Test_id" AUTOINCREMENT),
	FOREIGN KEY("Scan_id") REFERENCES "Scan"("Scan_id"),
	FOREIGN KEY("Employee_id") REFERENCES "Employee"("Employee_id")
);

CREATE TABLE "Patient" (
	"Patient_id"	INTEGER NOT NULL,
	"Test_id"	int,
	"Employee_id"	int,
	"Case_date"	DATE NOT NULL,
	"Case_resolution"	varchar(30) NOT NULL CHECK("Case_resolution" IN ('back to work', 'left the company', 'deceased')),
	PRIMARY KEY("Patient_id" AUTOINCREMENT),
	FOREIGN KEY("Test_id") REFERENCES "Test"("Test_id"),
	FOREIGN KEY("Employee_id") REFERENCES "Employee"("Employee_id")
);

CREATE TABLE "Health_Status" (
	"Health_status_row_id"	INTEGER NOT NULL,
	"Patient_id"	int,
	"Employee_id"	int,
	"Health_status_date"	DATE NOT NULL,
	"Current_status"	varchar(20) NOT NULL CHECK("Current_status" IN ('sick', 'hospitalized', 'well')),
	PRIMARY KEY("Health_status_row_id" AUTOINCREMENT),
	FOREIGN KEY("Employee_id") REFERENCES "Employee"("Employee_id"),
	FOREIGN KEY("Patient_id") REFERENCES "Patient"("Patient_id")
);

CREATE TABLE "Notification" (
	"Notification_id"	INTEGER NOT NULL,
	"Employee_id"	int,
	"Notification_date"	DATE NOT NULL,
	"Notification_type"	varchar(25) NOT NULL CHECK("Notification_type" IN ('Optional', 'Mandatory')),
	PRIMARY KEY("Notification_id" AUTOINCREMENT),
	FOREIGN KEY("Employee_id") REFERENCES "Employee"("Employee_id")
);

-- ================================ Section B ================================

INSERT INTO Employee (Employee_name, Employee_dob, Employee_office_no, Employee_floor_no, Employee_phone_no, Employee_email) VALUES ("Vinit Motwani",'1999-12-21',1,1,9504426698,"vmotwani@gmail.com"); 
INSERT INTO Employee (Employee_name, Employee_dob, Employee_office_no, Employee_floor_no, Employee_phone_no, Employee_email) VALUES ("Anish Vaidya",'1998-06-24',2,1,6504426899,"av1999@gmail.com"); 
INSERT INTO Employee (Employee_name, Employee_dob, Employee_office_no, Employee_floor_no, Employee_phone_no, Employee_email) VALUES ("Chetas Shinde",'1998-08-26',1,2,8045547122,"cnshinde@gmail.com"); 
INSERT INTO Employee (Employee_name, Employee_dob, Employee_office_no, Employee_floor_no, Employee_phone_no, Employee_email) VALUES ("Sahil Talreja",'1997-01-11',1,3,9820100543,"sahilt@yahoo.in"); 
INSERT INTO Employee (Employee_name, Employee_dob, Employee_office_no, Employee_floor_no, Employee_phone_no, Employee_email) VALUES ("Nikhil",'1995-02-14',2,2,1234757891,"nik99@gmail.com");
INSERT INTO Employee (Employee_name, Employee_dob, Employee_office_no, Employee_floor_no, Employee_phone_no, Employee_email) VALUES("Anirudh B",'2001-05-17',2,3,8234567261,"andy2023@gmail.com");
INSERT INTO Employee (Employee_name, Employee_dob, Employee_office_no, Employee_floor_no, Employee_phone_no, Employee_email) VALUES("Pratik Rane",'1998-11-19',3,3,7234587891,"rane2021@usc.edu");
INSERT INTO Employee (Employee_name, Employee_dob, Employee_office_no, Employee_floor_no, Employee_phone_no, Employee_email) VALUES("Saurabh P",'1999-09-30',4,4,6234512891,"spawha@gmail.com");
INSERT INTO Employee (Employee_name, Employee_dob, Employee_office_no, Employee_floor_no, Employee_phone_no, Employee_email) VALUES("Archana Bhatia",'1999-10-25',1,5,8834567981,"ab1999@gmail.com");
INSERT INTO Employee (Employee_name, Employee_dob, Employee_office_no, Employee_floor_no, Employee_phone_no, Employee_email)VALUES("Alia", '1991-12-26',2,3,1234562491,"alia@gmail.com");
INSERT INTO Employee (Employee_name, Employee_dob, Employee_office_no, Employee_floor_no, Employee_phone_no, Employee_email)VALUES("Janice", '1987-05-21',1,6,7276567876,"ja.nice@gmail.com");
INSERT INTO Employee (Employee_name, Employee_dob, Employee_office_no, Employee_floor_no, Employee_phone_no, Employee_email)VALUES("Parth", '1999-03-02',2,6,8776567891,"parth.j1@gmail.com");
INSERT INTO Employee (Employee_name, Employee_dob, Employee_office_no, Employee_floor_no, Employee_phone_no, Employee_email)VALUES("Ayush K",'1990-04-04',1,7,6872567891,"ayush.k90@gmail.com");
INSERT INTO Employee (Employee_name, Employee_dob, Employee_office_no, Employee_floor_no, Employee_phone_no, Employee_email) VALUES("Mohit Thorat",'1999-02-14',2,7,9176567891,"mthorat@gmail.com");
INSERT INTO Employee (Employee_name, Employee_dob, Employee_office_no, Employee_floor_no, Employee_phone_no, Employee_email) VALUES("Priyanka",'1995-10-23',3,7,7046567891,"priyanka.m@gmail.com");
INSERT INTO Employee (Employee_name, Employee_dob, Employee_office_no, Employee_floor_no, Employee_phone_no, Employee_email) VALUES("Gaurav Jaisinghani",'1999-11-26',1,1,4576567891,"gaujai@gmail.com");
INSERT INTO Employee (Employee_name, Employee_dob, Employee_office_no, Employee_floor_no, Employee_phone_no, Employee_email)VALUES("Manas",'1992-05-29',1,8,6575670891,"manas87@gmail.com");
INSERT INTO Employee (Employee_name, Employee_dob, Employee_office_no, Employee_floor_no, Employee_phone_no, Employee_email) VALUES("Pranav G",'1978-07-27',2,8,8976567891,"pgr@gmail.com");
INSERT INTO Employee (Employee_name, Employee_dob, Employee_office_no, Employee_floor_no, Employee_phone_no, Employee_email) VALUES("Mihir S",'1981-09-09',1,9,6666567891,"smihir@gmail.com");
INSERT INTO Employee (Employee_name, Employee_dob, Employee_office_no, Employee_floor_no, Employee_phone_no, Employee_email) VALUES("Aadit",'1984-12-07',2,9,7776567891,"aadi12@gmail.com");
INSERT INTO Employee (Employee_name, Employee_dob, Employee_office_no, Employee_floor_no, Employee_phone_no, Employee_email) VALUES("K Smith",'1979-08-13',1,10,6896567891,"k.sm@gmail.com");
INSERT INTO Employee (Employee_name, Employee_dob, Employee_office_no, Employee_floor_no, Employee_phone_no, Employee_email) VALUES("Vedant P",'1989-07-10',2,10,9116567891,"pvedu@gmail.com");
INSERT INTO Employee (Employee_name, Employee_dob, Employee_office_no, Employee_floor_no, Employee_phone_no, Employee_email) VALUES("Ankit K",'1986-09-11',3,10,8767567891,"ankit.k@gmail.com");
INSERT INTO Employee (Employee_name, Employee_dob, Employee_office_no, Employee_floor_no, Employee_phone_no, Employee_email) VALUES("Pranav K",'1982-07-14',4,10,5576567891,"pk43@gmail.com");
INSERT INTO Employee (Employee_name, Employee_dob, Employee_office_no, Employee_floor_no, Employee_phone_no, Employee_email) VALUES("Jai Rohara",'1980-08-09',5,10,6076567811,"jr11@gmail.com");
INSERT INTO Employee (Employee_name, Employee_dob, Employee_office_no, Employee_floor_no, Employee_phone_no, Employee_email) VALUES("Aditya K",'1989-10-20',3,9,7876567891,"kaditya@gmail.com");
INSERT INTO Employee (Employee_name, Employee_dob, Employee_office_no, Employee_floor_no, Employee_phone_no, Employee_email) VALUES("Disha P",'1994-06-13',4,9,1270567891,"pdish@gmail.com");
INSERT INTO Employee (Employee_name, Employee_dob, Employee_office_no, Employee_floor_no, Employee_phone_no, Employee_email) VALUES("Santesh M",'2000-01-12',4,8,1276567601,"msantesh@gmail.com");




INSERT INTO Meeting(Meeting_room_no, Meeting_floor_no, Meeting_start_time) VALUES(1, 1,9);
INSERT INTO Meeting(Meeting_room_no, Meeting_floor_no, Meeting_start_time) VALUES(2, 2,11);
INSERT INTO Meeting(Meeting_room_no, Meeting_floor_no, Meeting_start_time) VALUES(1, 3,10);
INSERT INTO Meeting(Meeting_room_no, Meeting_floor_no, Meeting_start_time) VALUES(1, 4,12);
INSERT INTO Meeting(Meeting_room_no, Meeting_floor_no, Meeting_start_time) VALUES(1, 5,8);
INSERT INTO Meeting(Meeting_room_no, Meeting_floor_no, Meeting_start_time) VALUES(3, 6,12);
INSERT INTO Meeting(Meeting_room_no, Meeting_floor_no, Meeting_start_time) VALUES(2, 1,15);
INSERT INTO Meeting(Meeting_room_no, Meeting_floor_no, Meeting_start_time) VALUES(1, 2,8);
INSERT INTO Meeting(Meeting_room_no, Meeting_floor_no, Meeting_start_time) VALUES(3, 1,12);
INSERT INTO Meeting(Meeting_room_no, Meeting_floor_no, Meeting_start_time) VALUES(2, 2,13);
INSERT INTO Meeting(Meeting_room_no, Meeting_floor_no, Meeting_start_time) VALUES(4, 3,11);
INSERT INTO Meeting(Meeting_room_no, Meeting_floor_no, Meeting_start_time) VALUES(1, 4,10);
INSERT INTO Meeting(Meeting_room_no, Meeting_floor_no, Meeting_start_time) VALUES(1, 8,15);
INSERT INTO Meeting(Meeting_room_no, Meeting_floor_no, Meeting_start_time) VALUES(5, 9,16);
INSERT INTO Meeting(Meeting_room_no, Meeting_floor_no, Meeting_start_time) VALUES(1, 6,17);
INSERT INTO Meeting(Meeting_room_no, Meeting_floor_no, Meeting_start_time) VALUES(3, 4,16);
INSERT INTO Meeting(Meeting_room_no, Meeting_floor_no, Meeting_start_time) VALUES(2, 1,12);
INSERT INTO Meeting(Meeting_room_no, Meeting_floor_no, Meeting_start_time) VALUES(4, 1,11);
INSERT INTO Meeting(Meeting_room_no, Meeting_floor_no, Meeting_start_time) VALUES(1, 10,8);




INSERT INTO Employee_Meeting_Bridge VALUES (1,1);
INSERT INTO Employee_Meeting_Bridge VALUES (2,1);
INSERT INTO Employee_Meeting_Bridge VALUES (3,1);
INSERT INTO Employee_Meeting_Bridge VALUES (5,2);
INSERT INTO Employee_Meeting_Bridge VALUES (6,2);
INSERT INTO Employee_Meeting_Bridge VALUES (1,3);
INSERT INTO Employee_Meeting_Bridge VALUES (2,3);
INSERT INTO Employee_Meeting_Bridge VALUES (5,4);
INSERT INTO Employee_Meeting_Bridge VALUES (3,4);
INSERT INTO Employee_Meeting_Bridge VALUES (4,4);
INSERT INTO Employee_Meeting_Bridge VALUES (6,4);
INSERT INTO Employee_Meeting_Bridge VALUES (1,5);
INSERT INTO Employee_Meeting_Bridge VALUES (6,5);
INSERT INTO Employee_Meeting_Bridge VALUES (3,6);
INSERT INTO Employee_Meeting_Bridge VALUES (4,6);
INSERT INTO Employee_Meeting_Bridge VALUES (5,7);
INSERT INTO Employee_Meeting_Bridge VALUES (1,7);
INSERT INTO Employee_Meeting_Bridge VALUES (2,8);
INSERT INTO Employee_Meeting_Bridge VALUES (9,8);
INSERT INTO Employee_Meeting_Bridge VALUES (2,9);
INSERT INTO Employee_Meeting_Bridge VALUES (8,9);
INSERT INTO Employee_Meeting_Bridge VALUES (2,10);
INSERT INTO Employee_Meeting_Bridge VALUES (6,10);
INSERT INTO Employee_Meeting_Bridge VALUES (5,11);
INSERT INTO Employee_Meeting_Bridge VALUES (4,11);
INSERT INTO Employee_Meeting_Bridge VALUES (1,12);
INSERT INTO Employee_Meeting_Bridge VALUES (3,12);
INSERT INTO Employee_Meeting_Bridge VALUES (2,13);
INSERT INTO Employee_Meeting_Bridge VALUES (4,13);
INSERT INTO Employee_Meeting_Bridge VALUES (1,14);
INSERT INTO Employee_Meeting_Bridge VALUES (5,14);
INSERT INTO Employee_Meeting_Bridge VALUES (9,15);
INSERT INTO Employee_Meeting_Bridge VALUES (16,15);
INSERT INTO Employee_Meeting_Bridge VALUES (10,16);
INSERT INTO Employee_Meeting_Bridge VALUES (12,16);
INSERT INTO Employee_Meeting_Bridge VALUES (11,17);
INSERT INTO Employee_Meeting_Bridge VALUES (1,17);
INSERT INTO Employee_Meeting_Bridge VALUES (8,18);
INSERT INTO Employee_Meeting_Bridge VALUES (9,18);
INSERT INTO Employee_Meeting_Bridge VALUES (2,19);
INSERT INTO Employee_Meeting_Bridge VALUES (1,19);




INSERT INTO Symptom(Employee_id, Date_reported, Symptom_id) VALUES(5, '2023-08-08',5);
INSERT INTO Symptom(Employee_id, Date_reported, Symptom_id) VALUES(2, '2023-08-09',2);
INSERT INTO Symptom(Employee_id, Date_reported, Symptom_id) VALUES(1, '2023-08-09',2);
INSERT INTO Symptom(Employee_id, Date_reported, Symptom_id) VALUES(3, '2023-08-09',1);
INSERT INTO Symptom(Employee_id, Date_reported, Symptom_id) VALUES(4, '2023-08-10',2);
INSERT INTO Symptom(Employee_id, Date_reported, Symptom_id) VALUES(6, '2023-08-14',1);
INSERT INTO Symptom(Employee_id, Date_reported, Symptom_id) VALUES(7, '2023-08-15',2);
INSERT INTO Symptom(Employee_id, Date_reported, Symptom_id) VALUES(9, '2023-08-15',5);
INSERT INTO Symptom(Employee_id, Date_reported, Symptom_id) VALUES(8, '2023-08-16',5);
INSERT INTO Symptom(Employee_id, Date_reported, Symptom_id) VALUES(10, '2023-08-18',5);
INSERT INTO Symptom(Employee_id, Date_reported, Symptom_id) VALUES(11, '2023-08-18',5);
INSERT INTO Symptom(Employee_id, Date_reported, Symptom_id) VALUES(12, '2023-08-22',1);
INSERT INTO Symptom(Employee_id, Date_reported, Symptom_id) VALUES(15, '2023-08-23',3);
INSERT INTO Symptom(Employee_id, Date_reported, Symptom_id) VALUES(16, '2023-08-28',1);
INSERT INTO Symptom(Employee_id, Date_reported, Symptom_id) VALUES(17, '2023-08-28',2);
INSERT INTO Symptom(Employee_id, Date_reported, Symptom_id) VALUES(18, '2023-09-01',5);
INSERT INTO Symptom(Employee_id, Date_reported, Symptom_id) VALUES(13, '2023-09-02',2);
INSERT INTO Symptom(Employee_id, Date_reported, Symptom_id) VALUES(14, '2023-09-08',4);
INSERT INTO Symptom(Employee_id, Date_reported, Symptom_id) VALUES(20, '2023-09-08',3);
INSERT INTO Symptom(Employee_id, Date_reported, Symptom_id) VALUES(22, '2023-09-08',4);
INSERT INTO Symptom(Employee_id, Date_reported, Symptom_id) VALUES(21, '2023-09-08',5);
INSERT INTO Symptom(Employee_id, Date_reported, Symptom_id) VALUES(28, '2023-09-08',5);
INSERT INTO Symptom(Employee_id, Date_reported, Symptom_id) VALUES(25, '2023-09-09',2);
INSERT INTO Symptom(Employee_id, Date_reported, Symptom_id) VALUES(27, '2023-09-09',2);
INSERT INTO Symptom(Employee_id, Date_reported, Symptom_id) VALUES(5, '2023-08-19',3);
INSERT INTO Symptom(Employee_id, Date_reported, Symptom_id) VALUES(1, '2023-09-10',4);
INSERT INTO Symptom(Employee_id, Date_reported, Symptom_id) VALUES(1, '2023-09-20',1);
INSERT INTO Symptom(Employee_id, Date_reported, Symptom_id) VALUES(1, '2023-09-30',3);
INSERT INTO Symptom(Employee_id, Date_reported, Symptom_id) VALUES(1, '2023-10-15',5);



INSERT INTO Scan(Scan_date,Scan_time,Employee_id,Temperature) VALUES('2023-08-08',10,1,97.5);
INSERT INTO Scan(Scan_date,Scan_time,Employee_id,Temperature) VALUES('2023-08-09',10,2,92.5);
INSERT INTO Scan(Scan_date,Scan_time,Employee_id,Temperature) VALUES('2023-08-10',11,3,99.5);
INSERT INTO Scan(Scan_date,Scan_time,Employee_id,Temperature) VALUES('2023-08-11',12,5,101);
INSERT INTO Scan(Scan_date,Scan_time,Employee_id,Temperature) VALUES('2023-08-12',10,6,100);
INSERT INTO Scan(Scan_date,Scan_time,Employee_id,Temperature) VALUES('2023-08-13',9,7,99.2);
INSERT INTO Scan(Scan_date,Scan_time,Employee_id,Temperature) VALUES('2023-08-14',8,4,98.8);
INSERT INTO Scan(Scan_date,Scan_time,Employee_id,Temperature) VALUES('2023-08-15',10,8,96.5);
INSERT INTO Scan(Scan_date,Scan_time,Employee_id,Temperature) VALUES('2023-08-16',11,9,102);
INSERT INTO Scan(Scan_date,Scan_time,Employee_id,Temperature) VALUES('2023-08-17',10,10,101);
INSERT INTO Scan(Scan_date,Scan_time,Employee_id,Temperature) VALUES('2023-08-19',8,1,102);
INSERT INTO Scan(Scan_date,Scan_time,Employee_id,Temperature) VALUES('2023-08-19',10,12,100.5);
INSERT INTO Scan(Scan_date,Scan_time,Employee_id,Temperature) VALUES('2023-08-19',8,17,97.5);
INSERT INTO Scan(Scan_date,Scan_time,Employee_id,Temperature) VALUES('2023-08-20',10,14,99);
INSERT INTO Scan(Scan_date,Scan_time,Employee_id,Temperature) VALUES('2023-08-20',9,20,101.5);
INSERT INTO Scan(Scan_date,Scan_time,Employee_id,Temperature) VALUES('2023-08-21',8,23,102);
INSERT INTO Scan(Scan_date,Scan_time,Employee_id,Temperature) VALUES('2023-08-21',9,25,100);
INSERT INTO Scan(Scan_date,Scan_time,Employee_id,Temperature) VALUES('2023-08-22',10,21,100.5);
INSERT INTO Scan(Scan_date,Scan_time,Employee_id,Temperature) VALUES('2023-08-22',9,26,101);
INSERT INTO Scan(Scan_date,Scan_time,Employee_id,Temperature) VALUES('2023-08-23',8,4,102);
INSERT INTO Scan(Scan_date,Scan_time,Employee_id,Temperature) VALUES('2023-08-24',8,11,101);
INSERT INTO Scan(Scan_date,Scan_time,Employee_id,Temperature) VALUES('2023-08-24',9,13,100);




INSERT INTO Test(Scan_id,Test_location,Test_date,Test_time,Employee_id,Test_result) VALUES(4,'Company','2023-08-11',13,5,'Negative');
INSERT INTO Test(Scan_id,Test_location,Test_date,Test_time,Employee_id,Test_result) VALUES(5,'Company','2023-08-12',11,6,'Positive');
INSERT INTO Test(Scan_id,Test_location,Test_date,Test_time,Employee_id,Test_result) VALUES(9,'Company','2023-08-16',12,9,'Positive');
INSERT INTO Test(Scan_id,Test_location,Test_date,Test_time,Employee_id,Test_result) VALUES(10,'Company','2023-08-17',11,10,'Positive');
INSERT INTO Test(Scan_id,Test_location,Test_date,Test_time,Employee_id,Test_result) VALUES(11,'Company','2023-08-19',9,1,'Positive');
INSERT INTO Test(Scan_id,Test_location,Test_date,Test_time,Employee_id,Test_result) VALUES(12,'Company','2023-08-19',11,12,'Positive');
INSERT INTO Test(Scan_id,Test_location,Test_date,Test_time,Employee_id,Test_result) VALUES(15,'Company','2023-08-20',10,20,'Negative');
INSERT INTO Test(Scan_id,Test_location,Test_date,Test_time,Employee_id,Test_result) VALUES(16,'Company','2023-08-21',9,23,'Negative');
INSERT INTO Test(Scan_id,Test_location,Test_date,Test_time,Employee_id,Test_result) VALUES(17,'Company','2023-08-21',10,25,'Negative');
INSERT INTO Test(Scan_id,Test_location,Test_date,Test_time,Employee_id,Test_result) VALUES(18,'Company','2023-08-22',11,21,'Negative');
INSERT INTO Test(Scan_id,Test_location,Test_date,Test_time,Employee_id,Test_result) VALUES(19,'Company','2023-08-22',10,26,'Positive');
INSERT INTO Test(Scan_id,Test_location,Test_date,Test_time,Employee_id,Test_result) VALUES(20,'Company','2023-08-23',9,4,'Positive');
INSERT INTO Test(Scan_id,Test_location,Test_date,Test_time,Employee_id,Test_result) VALUES(21,'Company','2023-08-24',9,11,'Positive');
INSERT INTO Test(Scan_id,Test_location,Test_date,Test_time,Employee_id,Test_result) VALUES(22,'Company','2023-08-24',10,13,'Positive');



INSERT INTO Patient(Test_id,Employee_id,Case_date,Case_resolution) VALUES(2,6,'2023-08-13','left the company');
INSERT INTO Patient(Test_id,Employee_id,Case_date,Case_resolution) VALUES(4,10,'2023-08-18','back to work');
INSERT INTO Patient(Test_id,Employee_id,Case_date,Case_resolution) VALUES(5,1,'2023-08-20','back to work');
INSERT INTO Patient(Test_id,Employee_id,Case_date,Case_resolution) VALUES(10,26,'2023-08-23','deceased');
INSERT INTO Patient(Test_id,Employee_id,Case_date,Case_resolution) VALUES(11,4,'2023-08-24','deceased');
INSERT INTO Patient(Test_id,Employee_id,Case_date,Case_resolution) VALUES(3,9,'2023-08-17','left the company');
INSERT INTO Patient(Test_id,Employee_id,Case_date,Case_resolution) VALUES(12,12,'2023-08-20','back to work');
INSERT INTO Patient(Test_id,Employee_id,Case_date,Case_resolution) VALUES(13,11,'2023-08-25','deceased');
INSERT INTO Patient(Test_id,Employee_id,Case_date,Case_resolution) VALUES(14,13,'2023-08-25','back to work');




INSERT INTO Health_Status (Patient_id,Employee_id,Health_status_date,Current_status) VALUES (1,6,'2023-08-14','sick');
INSERT INTO Health_Status (Patient_id,Employee_id,Health_status_date,Current_status) VALUES (1,6,'2023-08-15','sick');
INSERT INTO Health_Status (Patient_id,Employee_id,Health_status_date,Current_status) VALUES (1,6,'2023-08-16','sick');
INSERT INTO Health_Status (Patient_id,Employee_id,Health_status_date,Current_status) VALUES (1,6,'2023-08-17','sick');
INSERT INTO Health_Status (Patient_id,Employee_id,Health_status_date,Current_status) VALUES (1,6,'2023-08-18','sick');
INSERT INTO Health_Status (Patient_id,Employee_id,Health_status_date,Current_status) VALUES (1,6,'2023-08-19','well');
INSERT INTO Health_Status (Patient_id,Employee_id,Health_status_date,Current_status) VALUES (3,1,'2023-08-21','sick');
INSERT INTO Health_Status (Patient_id,Employee_id,Health_status_date,Current_status) VALUES (3,1,'2023-08-22','sick');
INSERT INTO Health_Status (Patient_id,Employee_id,Health_status_date,Current_status) VALUES (3,1,'2023-08-23','sick');
INSERT INTO Health_Status (Patient_id,Employee_id,Health_status_date,Current_status) VALUES (3,1,'2023-08-24','well');
INSERT INTO Health_Status (Patient_id,Employee_id,Health_status_date,Current_status) VALUES (4,26,'2023-08-24','sick');
INSERT INTO Health_Status (Patient_id,Employee_id,Health_status_date,Current_status) VALUES (4,26,'2023-08-25','sick');
INSERT INTO Health_Status (Patient_id,Employee_id,Health_status_date,Current_status) VALUES (4,26,'2023-08-26','well');
INSERT INTO Health_Status (Patient_id,Employee_id,Health_status_date,Current_status) VALUES (5,4,'2023-08-25','sick');
INSERT INTO Health_Status (Patient_id,Employee_id,Health_status_date,Current_status) VALUES (5,4,'2023-08-26','sick');
INSERT INTO Health_Status (Patient_id,Employee_id,Health_status_date,Current_status) VALUES (5,4,'2023-08-27','sick');
INSERT INTO Health_Status (Patient_id,Employee_id,Health_status_date,Current_status) VALUES (5,4,'2023-08-28','well');
INSERT INTO Health_Status (Patient_id,Employee_id,Health_status_date,Current_status) VALUES (6,9,'2023-08-18','sick');
INSERT INTO Health_Status (Patient_id,Employee_id,Health_status_date,Current_status) VALUES (6,9,'2023-08-19','sick');
INSERT INTO Health_Status (Patient_id,Employee_id,Health_status_date,Current_status) VALUES (6,9,'2023-08-20','well');
INSERT INTO Health_Status (Patient_id,Employee_id,Health_status_date,Current_status) VALUES (2,10,'2023-08-19','sick');
INSERT INTO Health_Status (Patient_id,Employee_id,Health_status_date,Current_status) VALUES (2,10,'2023-08-20','sick');
INSERT INTO Health_Status (Patient_id,Employee_id,Health_status_date,Current_status) VALUES (2,10,'2023-08-21','sick');
INSERT INTO Health_Status (Patient_id,Employee_id,Health_status_date,Current_status) VALUES (2,10,'2023-08-22','well');
INSERT INTO Health_Status (Patient_id,Employee_id,Health_status_date,Current_status) VALUES (8,11,'2023-08-26','sick');
INSERT INTO Health_Status (Patient_id,Employee_id,Health_status_date,Current_status) VALUES (8,11,'2023-08-27','well');
INSERT INTO Health_Status (Patient_id,Employee_id,Health_status_date,Current_status) VALUES (7,12,'2023-08-21','hospitalized');
INSERT INTO Health_Status (Patient_id,Employee_id,Health_status_date,Current_status) VALUES (7,12,'2023-08-22','hospitalized');
INSERT INTO Health_Status (Patient_id,Employee_id,Health_status_date,Current_status) VALUES (7,12,'2023-08-23','hospitalized');
INSERT INTO Health_Status (Patient_id,Employee_id,Health_status_date,Current_status) VALUES (7,12,'2023-08-24','well');
INSERT INTO Health_Status (Patient_id,Employee_id,Health_status_date,Current_status) VALUES (9,13,'2023-08-26','sick');
INSERT INTO Health_Status (Patient_id,Employee_id,Health_status_date,Current_status) VALUES (9,13,'2023-08-27','sick');
INSERT INTO Health_Status (Patient_id,Employee_id,Health_status_date,Current_status) VALUES (9,13,'2023-08-28','hospitalized');
INSERT INTO Health_Status (Patient_id,Employee_id,Health_status_date,Current_status) VALUES (9,13,'2023-08-29','well');





INSERT INTO Notification(Employee_id,Notification_date,Notification_type) VALUES (7, '2023-08-11', 'Optional');
INSERT INTO Notification(Employee_id,Notification_date,Notification_type) VALUES (1, '2023-08-15', 'Mandatory');
INSERT INTO Notification(Employee_id,Notification_date,Notification_type) VALUES (2, '2023-08-16', 'Optional');
INSERT INTO Notification(Employee_id,Notification_date,Notification_type) VALUES (3, '2023-08-20', 'Mandatory');
INSERT INTO Notification(Employee_id,Notification_date,Notification_type) VALUES (4, '2023-08-25', 'Optional');
INSERT INTO Notification(Employee_id,Notification_date,Notification_type) VALUES (5, '2023-08-30', 'Mandatory');
INSERT INTO Notification(Employee_id,Notification_date,Notification_type) VALUES (20, '2023-08-30', 'Optional');
INSERT INTO Notification(Employee_id,Notification_date,Notification_type) VALUES (6, '2023-08-30', 'Mandatory');
INSERT INTO Notification(Employee_id,Notification_date,Notification_type) VALUES (8, '2023-09-05', 'Optional');
INSERT INTO Notification(Employee_id,Notification_date,Notification_type) VALUES (9, '2023-09-07', 'Mandatory');
INSERT INTO Notification(Employee_id,Notification_date,Notification_type) VALUES (10, '2023-09-21', 'Optional');
INSERT INTO Notification(Employee_id,Notification_date,Notification_type) VALUES (11, '2023-09-24', 'Mandatory');
INSERT INTO Notification(Employee_id,Notification_date,Notification_type) VALUES (12, '2023-09-28', 'Optional');
INSERT INTO Notification(Employee_id,Notification_date,Notification_type) VALUES (13, '2023-09-29', 'Mandatory');
