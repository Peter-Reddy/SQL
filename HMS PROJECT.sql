create database Hospital_management_system

use Hospital_management_system

create Table Patients 
(PatientID char(5),
FirstName varchar(25),
LastName varchar(20),
Contact varchar(15),
Age int);

insert into Patients 
values ('P0001','John','Doe','123-456-7890',35);
Insert into Patients 
values ('P0002','Jane','Smith','987-654-3210',25);


Insert into Patients 
values ('P0003','Michael','Johnson','555-555-5555',62);
Insert into Patients 
values ('P0004','David','Lee','111-222-3333',33);
Insert into Patients 
values ('P0005','Sarah','Brown','444-555-6666',21);
Insert into Patients 
values ('P0006','John','Doe','777-888-9999',28);
Insert into Patients 
values ('P0007','Jane','Smith','333-222-1111',30);
Insert into Patients 
values ('P0008','Michael','Johnson','666-777-8888',41);
Insert into Patients 
values ('P0009','David','Lee','999-888-7777',41);
Insert into Patients 
values ('P0010','Sarah','Brown','222-333-4444',60);

Select * from Patients
Select * from Doctor
Select * from Appointment
Select * from PatientsAttendAppointments
Select * from PatientFillHistory

Select * from medical_History
Select * from Medical_Cost


EXEC sp_rename Apppointment, 'Appointment';

--Find the names of patients who have attended appointments scheduled by Dr. John Doe.


SELECT p.PatientID, p.FirstName+ ' ' +p.LastName As 'PatientName'
From Patients p
JOIN PatientsAttendAppointments paa ON p.PatientID=paa.PatientID
JOIN Appointment a ON paa.AppointmentID = a.AppointmentID
JOIN Doctor d ON a.doctorID = d.doctorID
WHERE d.First_Name = 'Dr.John' AND d.Last_Name = 'Doe';
-----------------------------------------------------------------------------------

--Calculate the average age of all patients

SELECT Avg(Age) as 'Average_Age_Patients'
FROM Patients


--------------------------------------------------------------------------------------
--Create a stored procedure to get the total number of appointments for a given patient.

CREATE PROCEDURE TOTAl_NUMBER_OF_APPOINTMENTS
	
	@PatientID char(5)
AS
BEGIN

	SELECT count(*) as 'AppointmentCount'
	FROM Appointment
	WHERE PatientID = @PatientID
END;

EXECUTE TOTAl_NUMBER_OF_APPOINTMENTS 'P0010'



----------------------------------------------------------------------------------------
--Create a trigger to update the appointment status to 'Completed' when the appointment date has passed.

CREATE TRIGGER Appointment_Status
ON Appointment
AFTER UPDATE
AS 
BEGIN
	SET NOCOUNT ON;

	UPDATE Appointment
	SET Status = 'Completed'
	WHERE Date < Getdate() AND Status != 'Completed' AND Status != 'Cancelled'

END;

-- This dummy update will trigger the AFTER UPDATE trigger
UPDATE Appointment
SET Status = Status  -- No actual change
WHERE 1 = 1;         -- This updates all rows


SELECT * FROM Appointment
--------------------------------------------------------------------------------------------------------

--Find the names of patients along with their appointment details and the corresponding doctor's name.

SELECT p.FirstName+' '+p.LastName as 'PatientName', a.*,d.First_Name+' '+Last_Name AS 'DoctorName'
FROM Patients p
JOIN Appointment a ON p.PatientID=a.PatientID
JOIN Doctor d ON a.doctorID=d.doctorID;
 ------------------------------------------------------------------------------------------------------
 --Find the patients who have a medical history of diabetes and their next appointment is scheduled within the next 7 days.

SELECT p.FirstName + ' ' + p.LastName AS 'PatientName'
FROM Patients p
JOIN Medical_History mh ON p.PatientID = mh.PatientID
JOIN Appointment a ON p.PatientID = a.PatientID
WHERE mh.Condition = 'Diabetes'
AND a.Status = 'Scheduled'
AND a.Date BETWEEN GETDATE() AND DATEADD(day, 7, GETDATE());


Select * From Appointment

-----------------------------------------------------------------------------------------------------------------
--Find patients who have multiple appointments scheduled.

SELECT p.FirstName + ' ' + p.LastName AS 'PatientName', 
       COUNT(a.AppointmentID) AS 'ScheduledAppointments'
FROM Patients p
JOIN Appointment a ON p.PatientID = a.PatientID
WHERE a.Status = 'Completed'
GROUP BY p.PatientID, p.FirstName, p.LastName
HAVING COUNT(a.AppointmentID) > 1;


-----------------------------------------------------------------------------------------------------------------
--Calculate the average duration of appointments for each doctor.

SELECT d.First_Name+' '+d.Last_Name as 'Doctor_Name',
AVG (DATEDIFF( MINUTE, a.Date, a.EndTime))
FROM Doctor d
JOIN Appointment a ON d.DoctorID = a.DoctorID
GROUP BY d.First_Name, d.Last_Name
----------------------------------------------------------------------

-- Find Patients with Most Appointments

SELECT P.FirstName+' '+p.LastName as 'PatientName',
 COUNT(a.AppointmentID) as 'Total_Appointments'
FROM Patients p
JOIN Appointment a ON P.PatientID = a.PatientID
GROUP BY P.PatientID, p.FirstName, p.LastName
ORDER BY COUNT(a.AppointmentID) DESC;


-------------------------------------------------------------------------------------

-- Calculate the total cost of medication for each patient.

SELECT p.FirstName+' '+p.LastName as 'PatientName',sum(mc.Cost_in$) as 'TotalMedicationCost'
FROM Patients p
JOIN Medical_History mh ON p.PatientID = mh.PatientID
JOIN Medical_Cost mc ON mh.Medication = mc.Medication
GROUP BY p.PatientID, p.FirstName, p.LastName

------------------------------------------------------------------------------------------------

-- Create a stored procedure named CalculatePatientBill that calculates the total bill for a patient
 -- based on their medical history and medication costs. The procedure should take the PatientID as
 --   a parameter and calculate the total cost by summing up the medication costs and applying a charge
 --  of $50 for each surgery in the patient's medical history. If the patient has no medical history,
 --  the procedure should still return a basic charge of $50.

CREATE PROCEDURE CalculatePatientBill @PatientID  CHAR(5)
AS
BEGIN
	
	 DECLARE @TotalMedicationCost DECIMAL (10,2)
	 DECLARE @TotalSurgeryCharge DECIMAL(10,2)
	 DECLARE @TotalBill DECIMAL(10,2) = 50.00; --Base charge

 

	 SELECT @TotalMedicationCost = ISNULL(SUM(Cost_in$),0)
	 FROM Medical_Cost mc
	 JOIN Medical_History mh ON mc.Medication = mh.Medication
	 WHERE mh.PatientID = @PatientID;

	 SELECT @TotalSurgeryCharge = ISNULL(COUNT(mh.surgeries)* 50.00,0)
	 FROM Medical_History mh
	 WHERE mh.PatientID = @PatientID

	 SET @TotalBill = @TotalBill + @TotalMedicationCost + @TotalSurgeryCharge;

	 SELECT @TotalBill as Totalbill;
END;

exec CalculatePatientBill 'P0001'

-----------------------------------------------------------------------------------------
