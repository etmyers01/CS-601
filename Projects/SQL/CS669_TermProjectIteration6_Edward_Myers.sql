-- CS669 Term Iteration #6 SQL Code
-- Edward Myers

--DROPS
DROP TABLE AutomaticAppointment;
DROP TABLE ManualAppointment;
DROP TABLE Appointment;

DROP TABLE PartHistory;								-- added Iteration #6
DROP TABLE PartEntry;
DROP TABLE InspectionTestList;
DROP TABLE Inspection;
DROP TABLE VendorRepair;
DROP TABLE MaintenanceActivity;

DROP TABLE TestResult;
DROP TABLE Result;
DROP TABLE Test;

DROP TABLE VehiclePartList;
DROP TABLE Part;
DROP TABLE Mechanic;
DROP TABLE Vendor;
DROP TABLE Maintainer;

DROP TABLE Vehicle;
DROP TABLE VehicleModel;
--DROP TABLE VehicleYear;							removed Iteration #5
DROP TABLE VehicleType;
DROP TABLE VehicleMake;



DROP SEQUENCE maintenance_activity_seq;
DROP SEQUENCE maintainer_seq;
DROP SEQUENCE inspection_test_list_seq;
DROP SEQUENCE test_seq;
DROP SEQUENCE result_seq;
DROP SEQUENCE part_entry_seq;
DROP SEQUENCE part_seq;
DROP SEQUENCE appointment_seq;
DROP SEQUENCE vehicle_seq;
DROP SEQUENCE vehicle_model_seq;
DROP SEQUENCE vehicle_year_seq;
DROP SEQUENCE vehicle_type_seq;
DROP SEQUENCE vehicle_make_seq;
DROP SEQUENCE part_history_seq;						-- added Iteration #6


--TABLES

-- Inspection-related tables
CREATE TABLE Result (
result_id		DECIMAL(1) PRIMARY KEY,
result_desc		VARCHAR(12) NOT NULL	);

CREATE TABLE Test (
test_id			DECIMAL(3)	PRIMARY KEY,
test_desc		VARCHAR(64)	NOT NULL	);

CREATE TABLE TestResult (
result_id		DECIMAL(1) NOT NULL,
test_id			DECIMAL(3) NOT NULL,
CONSTRAINT test_result_PK PRIMARY KEY(result_id, test_id),
FOREIGN KEY (result_id) REFERENCES Result(result_id),
FOREIGN KEY (test_id)	REFERENCES Test(test_id)	);

-- Maintainer supertype and subtypes	
CREATE TABLE Maintainer (
maintainer_id	DECIMAL(3)	PRIMARY KEY,
maint_type		VARCHAR(8)	NOT NULL,
maint_phone_num	VARCHAR(14) NOT NULL,
maint_email		VARCHAR(30)	);

CREATE TABLE Mechanic (
maintainer_id	DECIMAL(3)	PRIMARY KEY,
mech_first_name	VARCHAR(25)	NOT NULL,
mech_last_name	VARCHAR(25)	NOT NULL,
hire_date		DATE,
insp_license	VARCHAR(12)
FOREIGN KEY (maintainer_id)	REFERENCES Maintainer(maintainer_id)	);

CREATE TABLE Vendor (
maintainer_id	DECIMAL(3)	PRIMARY KEY,
ven_name		VARCHAR(25)	NOT NULL,
ven_street_num	DECIMAL(6)	NOT NULL,
ven_street		VARCHAR(30)	NOT NULL,
ven_city		VARCHAR(20) NOT NULL,
ven_state		CHAR(2)		NOT NULL,
ven_zip			VARCHAR(10) NOT NULL,
ven_insurance_policy	VARCHAR(25),	
ven_agent		VARCHAR(64),
FOREIGN KEY (maintainer_id)	REFERENCES Maintainer(maintainer_id)	);

-- Vehicle-related tables
CREATE TABLE VehicleModel (
vehicle_model_id	DECIMAL(6)	PRIMARY KEY,
model_name			VARCHAR(25)	NOT NULL	);

CREATE TABLE VehicleMake (
vehicle_make_id		DECIMAL(4)	PRIMARY KEY,
make_name			VARCHAR(25) NOT NULL	);

CREATE TABLE VehicleType (
vehicle_type_id		DECIMAL(1)	PRIMARY KEY,
vehicle_type		VARCHAR(25)	NOT NULL	);

/*CREATE TABLE VehicleYear (
vehicle_year_id		DECIMAL(2)	PRIMARY KEY,		-- removed table Iteration #5
vehicle_year		DECIMAL(4)	NOT NULL	);	*/

CREATE TABLE Vehicle (
vehicle_id	DECIMAL(5)	PRIMARY KEY,
vehicle_model_id		DECIMAL(6)	NOT NULL,
vehicle_shop_code		DECIMAL(5)	NOT NULL,
vehicle_make_id			DECIMAL(4)	NOT NULL,
vehicle_year			DECIMAL(4)	NOT NULL,		-- VehicleYear folded into Vehicle
vehicle_license			VARCHAR(8)	NOT NULL,
vehicle_vin				VARCHAR(17)	NOT NULL,
vehicle_type_id			DECIMAL(1)	NOT NULL,
veh_last_mileage		DECIMAL(7)	NOT NULL,
veh_schd_insp_date		DATE,
FOREIGN KEY (vehicle_model_id)	REFERENCES VehicleModel(vehicle_model_id),
FOREIGN KEY (vehicle_make_id)	REFERENCES VehicleMake(vehicle_make_id),
--FOREIGN KEY (vehicle_year_id)	REFERENCES VehicleYear(vehicle_year_id),		-- removed Iteration #5
FOREIGN KEY	(vehicle_type_id)	REFERENCES VehicleType(vehicle_type_id)	);

-- Appointment tables
CREATE TABLE Appointment (
appointment_id	DECIMAL(12)	PRIMARY KEY,
vehicle_id		DECIMAL(5)	NOT NULL,
maintainer_id	DECIMAL(3)	NOT NULL,
appt_date		DATE,
appt_notes		VARCHAR(128),
FOREIGN KEY (vehicle_id) REFERENCES Vehicle(vehicle_id),
FOREIGN KEY (maintainer_id) REFERENCES Maintainer(maintainer_id)	);

CREATE TABLE AutomaticAppointment (
appointment_id	DECIMAL(12) PRIMARY KEY,
trigger_mileage	BIT	NOT NULL,
trigger_insp	BIT NOT NULL,
FOREIGN KEY (appointment_id) REFERENCES Appointment(appointment_id)	);

CREATE TABLE ManualAppointment (
appointment_id	DECIMAL(12) PRIMARY KEY,
appt_requester	VARCHAR(64) NOT NULL,
FOREIGN KEY (appointment_id) REFERENCES Appointment(appointment_id)	);

-- Maintenance activity tables
CREATE TABLE MaintenanceActivity (
maintenance_activity_id		DECIMAL(12)	PRIMARY KEY,
maintainer_id				DECIMAL(3) NOT NULL,
vehicle_id					DECIMAL(5) NOT NULL,
vehicle_mileage				DECIMAL(7),
maint_type					VARCHAR(25),
maint_date					DATE NOT NULL,
maint_total_cost			DECIMAL(7,2),
FOREIGN KEY (maintainer_id) REFERENCES Maintainer(maintainer_id),
FOREIGN KEY (vehicle_id)	REFERENCES Vehicle(vehicle_id)	);

CREATE TABLE VendorRepair (
maintenance_activity_id		DECIMAL(12) PRIMARY KEY,
repair_warranty_policy		VARCHAR(20),
repair_invoice_ticket		VARCHAR(12),
maintainer_id				DECIMAL(3) NOT NULL,
FOREIGN KEY (maintenance_activity_id)	REFERENCES	MaintenanceActivity(maintenance_activity_id),
FOREIGN KEY (maintainer_id)				REFERENCES	Maintainer(maintainer_id)	);

CREATE TABLE Inspection (
maintenance_activity_id		DECIMAL(12) PRIMARY KEY,
insp_comments				VARCHAR(1024),
FOREIGN KEY (maintenance_activity_id)	REFERENCES	MaintenanceActivity(maintenance_activity_id)	);

CREATE TABLE InspectionTestList (
inspection_test_list_id		DECIMAL(12) PRIMARY KEY,
test_id						DECIMAL(3) NOT NULL,
maintenance_activity_id		DECIMAL(12) NOT NULL,
FOREIGN KEY (maintenance_activity_id)	REFERENCES	MaintenanceActivity(maintenance_activity_id),
FOREIGN KEY (test_id)					REFERENCES	Test(test_id)	);

-- Parts-related tables
CREATE TABLE Part (
part_id			DECIMAL(12) PRIMARY KEY,
part_name		VARCHAR(25) NOT NULL,
maintainer_id	DECIMAL(3) NOT NULL,
part_quantity_on_hand	DECIMAL(4) NOT NULL,
part_quantity_units		VARCHAR(12) NOT NULL,
part_description		VARCHAR(64),
part_serial_number		VARCHAR(25),
FOREIGN KEY (maintainer_id)		REFERENCES Maintainer(maintainer_id)	);

CREATE TABLE VehiclePartList (
vehicle_id		DECIMAL(5) NOT NULL,
part_id			DECIMAL(12) NOT NULL,
CONSTRAINT vehicle_part_list_PK PRIMARY KEY(vehicle_id, part_id),
FOREIGN KEY (vehicle_id)	REFERENCES Vehicle(vehicle_id),
FOREIGN KEY	(part_id)		REFERENCES Part(part_id)	);

CREATE TABLE PartEntry (
part_entry_id		DECIMAL(12) PRIMARY KEY,
maintenance_activity_id		DECIMAL(12) NOT NULL,
part_id				DECIMAL(12) NOT NULL,
part_amount_used	DECIMAL(3),
part_amount_units	VARCHAR(12),
FOREIGN KEY (maintenance_activity_id)	REFERENCES MaintenanceActivity(maintenance_activity_id),
FOREIGN KEY (part_id)					REFERENCES Part(part_id)	);

-- New History table for Part
CREATE TABLE PartHistory (
part_history_id		DECIMAL(12) PRIMARY KEY,
part_id				DECIMAL(12) NOT NULL,
part_old_quant		DECIMAL(4) NOT NULL,
part_new_quant		DECIMAL(4) NOT NULL,
part_change_date	DATE NOT NULL,
FOREIGN KEY (part_id)		REFERENCES Part(part_id)	);


--SEQUENCES

CREATE SEQUENCE maintenance_activity_seq START WITH 1;
CREATE SEQUENCE maintainer_seq START WITH 1;
CREATE SEQUENCE inspection_test_list_seq START WITH 1;
CREATE SEQUENCE test_seq START WITH 1;
CREATE SEQUENCE result_seq START WITH 1;
CREATE SEQUENCE part_entry_seq START WITH 1;
CREATE SEQUENCE part_seq START WITH 1;
CREATE SEQUENCE appointment_seq START WITH 1;
CREATE SEQUENCE vehicle_seq START WITH 1;
CREATE SEQUENCE vehicle_model_seq START WITH 1;
CREATE SEQUENCE vehicle_year_seq START WITH 1;
CREATE SEQUENCE vehicle_type_seq START WITH 1;
CREATE SEQUENCE vehicle_make_seq START WITH 1;
CREATE SEQUENCE part_history_seq START WITH 1;				-- added Iteration #6

--INDEXES

-- From foreign keys
CREATE INDEX AppointmentVehicleIdx							-- Appointment.vehicle_id
ON Appointment(vehicle_id);
CREATE INDEX AppointmentMaintainerIdx						-- Appointment.maintaner_id
ON Appointment(maintainer_id);
CREATE INDEX PartMaintainerIdx								-- Part.maintainer_id
ON Part(maintainer_id);
CREATE INDEX MaintenanceActivityMaintainerIdx				-- MaintenanceActivity.maintainer_id
ON MaintenanceActivity(maintainer_id);
CREATE INDEX MaintenanceActivityVehicleIdx					-- MaintenanceActivity.vehicle_id
ON MaintenanceActivity(vehicle_id);
CREATE INDEX InspectionTestListTestIdx						-- InspectionTestList.test_id
ON InspectionTestList(test_id);
CREATE INDEX InspectionTestListMaintenanceActivityIdx		-- InspectionTestList.maintenance_activity_id	
ON InspectionTestList(maintenance_activity_id);
CREATE INDEX PartEntryMaintenanceActivityIdx				-- PartEntry.maintenance_activity_id
ON PartEntry(maintenance_activity_id);
CREATE INDEX PartEntryPartIdx								-- PartEntry.part_id
ON PartEntry(part_id);
CREATE INDEX VehicleVehicleModelIdx							-- Vehicle.vehicle_model_id
ON Vehicle(vehicle_model_id);
CREATE INDEX VehicleVehicleMakeIdx							-- Vehicle.vehicle_make_id
ON Vehicle(vehicle_make_id);
CREATE INDEX VehicleVehicleTypeIdx							-- Vehicle.vehicle_type_id
ON Vehicle(vehicle_type_id);
CREATE INDEX PartHistoryPartIdx								-- PartHistory.part_id (added Iteration #6)
ON PartHistory(part_id);
-- From queries
CREATE INDEX VehicleVehLastMileageIdx						-- Vehicle.veh_last_mileage
ON Vehicle(veh_last_mileage);
CREATE INDEX VehicleVehicleYearIdx							-- Vehicle.vehicle_year
ON Vehicle(vehicle_year);
CREATE INDEX PartPartQuantityOnHandIdx						-- Part.part_quantity_on_hand
ON Part(part_quantity_on_hand);

--STORED PROCEDURES

-- Create AddVehicle process
CREATE OR ALTER PROCEDURE AddVehicle @v_model VARCHAR(25), @v_shop_code DECIMAL(5), @v_make VARCHAR(25), @v_year DECIMAL(4), @v_license VARCHAR(8), @v_vin VARCHAR(17),
	@v_type VARCHAR(25), @v_mileage DECIMAL(7), @v_next_insp DATE
AS
BEGIN

		IF (@v_model IS NULL) OR (@v_make IS NULL) OR (@v_license IS NULL) OR (@v_vin IS NULL) OR (@v_type IS NULL)
		BEGIN
			RAISERROR('Vehicle information omitted, vehicle addition aborted!', -1, -1)			-- if the character variables are null
			RETURN;
		END;
		ELSE IF (@v_shop_code IS NULL) OR (@v_shop_code < 0)									-- if shop code is null or less than 0
		BEGIN
			RAISERROR('Vehicle shop code is invalid, vehicle addition aborted', -1, -1);
			RETURN;
		END;
		ELSE IF (@v_year IS NULL) OR (@v_year < 1900) OR (@v_year > YEAR(GETDATE())+1)			-- if year is null, less than 1900 or greater than current year +1
		BEGIN
			RAISERROR('Vehicle year is invalid, vehicle addition aborted', -1, -1);
			RETURN;
		END;
		ELSE IF (@v_mileage IS NULL) OR (@v_mileage < 0)										-- if mileage is null or less than 0
		BEGIN
			RAISERROR('Vehicle mileage is invalid, vehicle addition aborted', -1, -1);
			RETURN;
		END;
		ELSE IF (@v_next_insp IS NULL) OR (YEAR(@v_next_insp) > YEAR(GETDATE()+1))				-- if scheduled inspection is null or year value is more than 1 year 
		BEGIN																					-- ahead of current year
			RAISERROR('Vehicle next inspection date is invalid, vehicle addition aborted', -1, -1);
			RETURN;
		END;

		ELSE IF EXISTS(SELECT vehicle_vin FROM Vehicle WHERE vehicle_vin = @v_vin)				-- if an equal VIN is already found
		BEGIN
			RAISERROR('Vehicle VIN already exists in the database, vehicle addition aborted!', -1, -1);
			RETURN;
		END;
		ELSE IF EXISTS(SELECT vehicle_shop_code FROM Vehicle WHERE vehicle_shop_code = @v_shop_code)	-- if an equal shop code is already found
		BEGIN
			RAISERROR('Vehicle shop code already exists in the database, vehicle addition aborted!', -1, -1)
			RETURN;
		END;

	IF NOT EXISTS(SELECT make_name FROM VehicleMake WHERE @v_make = make_name)		-- if a make doesn't already exist
		INSERT INTO VehicleMake (vehicle_make_id, make_name)		-- create a new entry in VehicleMake and store the new make
		VALUES	(NEXT VALUE FOR vehicle_make_seq, @v_make);

	IF NOT EXISTS(SELECT model_name FROM VehicleModel WHERE @v_model = model_name)	-- if a model doesn't already exist
		INSERT INTO VehicleModel (vehicle_model_id, model_name)		-- create a new entry in VehicleModel and store the new model
		VALUES	(NEXT VALUE FOR vehicle_model_seq, @v_model);

	IF NOT EXISTS(SELECT vehicle_type FROM VehicleType WHERE @v_type = vehicle_type)	-- if a type doesn't already exist
		INSERT INTO VehicleType (vehicle_type_id, vehicle_type)		-- create a new entry in VehicleType and store the new type
		VALUES	(NEXT VALUE FOR vehicle_type_seq, @v_type);

	-- Vehicle doesn't know whether the IDs for the foreign key parameters are new or existing in the associated tables.  Therefore it
	-- needs to perform subquery lookups of all tables to pull the right id.

	INSERT INTO Vehicle (vehicle_id, vehicle_model_id, vehicle_shop_code, vehicle_make_id, vehicle_year, vehicle_license, vehicle_vin, 
		vehicle_type_id, veh_last_mileage, veh_schd_insp_date)
	VALUES	(NEXT VALUE FOR vehicle_seq,															-- next synthetic ID for vehicle
				(SELECT vehicle_model_id FROM VehicleModel VMD WHERE VMD.model_name = @v_model),	-- subquery to find matching model id within VehicleModel
				@v_shop_code,																		-- passed through shop code
				(SELECT vehicle_make_id FROM VehicleMake VML WHERE VML.make_name = @v_make),		-- subquery to find matching make id within VehicleMake
				@v_year,																			-- passed through vehicle year
				@v_license,																			-- passed through vehicle license
				@v_vin,																				-- passed through vehicle VIN
				(SELECT vehicle_type_id FROM VehicleType VT WHERE VT.vehicle_type = @v_type),		-- subquery to find matching type id within VehicleType
				@v_mileage,																			-- passed through vehicle mileage
				@v_next_insp);																		-- passed through vehicle next inspection date
																						
END;
GO

-- Create AddVendor process
CREATE OR ALTER PROCEDURE AddVendor @ven_name VARCHAR(25), @ven_street_num DECIMAL(6), @ven_street VARCHAR(30), @ven_city VARCHAR(20), @ven_state CHAR(2), @ven_zip VARCHAR(10),
	@ven_phone_num VARCHAR(14), @ven_ins VARCHAR(25), @ven_agent VARCHAR(64), @ven_email VARCHAR(30)
AS
BEGIN

		-- @ven_ins (insurance info), @ven_agent (agent name) and ven_email (vendor email) are optional arguments, therefore not tested for null.

		IF (@ven_name IS NULL) OR (@ven_street IS NULL) OR (@ven_city IS NULL) OR (@ven_state IS NULL) OR (@ven_zip IS NULL) OR (@ven_phone_num IS NULL)
		BEGIN
			RAISERROR('Vendor information omitted, vendor addition aborted!', -1, -1)			-- if any of the character variables are null
			RETURN;
		END;
		ELSE IF (@ven_street_num IS NULL) OR (@ven_street_num < 0)								-- if street number is null or less than 0
		BEGIN
			RAISERROR('Vendor street number is invalid, vendor addition aborted', -1, -1);
			RETURN;
		END;
		ELSE IF EXISTS(SELECT ven_name FROM Vendor WHERE Vendor.ven_name = @ven_name)			-- if an equal vendor name is already found
		BEGIN
			RAISERROR('Vendor name already exists in the database, vendor addition aborted!', -1, -1);
			RETURN;
		END;

	DECLARE @curr_maintainer_seq INT = NEXT VALUE FOR maintainer_seq;

	-- inserting values into Maintainer supertype entity first due to foreign key constraint
	INSERT INTO Maintainer (maintainer_id, maint_type, maint_phone_num, maint_email)			
	VALUES	(@curr_maintainer_seq, 'Vendor', @ven_phone_num, @ven_email);

	-- inserting values into Vendor subtype entity
	INSERT INTO Vendor (maintainer_id, ven_name, ven_street_num, ven_street, ven_city, ven_state, ven_zip, ven_insurance_policy, ven_agent)
	VALUES	(@curr_maintainer_seq, @ven_name, @ven_street_num, @ven_street, @ven_city, @ven_state, @ven_zip, @ven_ins, @ven_agent);

END;
GO

-- Create AddPart process
CREATE OR ALTER PROCEDURE AddPart @p_name VARCHAR(25), @p_supplier_name VARCHAR(25), @p_quant_rcvd DECIMAL(4), @p_quant_units VARCHAR(12), @p_desc VARCHAR(64), @p_serial VARCHAR(25)
AS
BEGIN
		-- part description and serial number are optional, therefore null is not checked on those fields
		IF (@p_supplier_name IS NULL) OR (@p_quant_units IS NULL)
		BEGIN
			RAISERROR('Part information omitted, part addition aborted!', -1, -1)				-- if the character variables are null
			RETURN;
		END;
		ELSE IF (@p_quant_rcvd IS NULL) OR (@p_quant_rcvd < 0)									-- if quantity is null or less than 0
		BEGIN
			RAISERROR('Part quantity is invalid, part addition aborted', -1, -1);
			RETURN;
		END;

		ELSE IF EXISTS(SELECT part_name FROM Part WHERE part_name = @p_name)					-- if an equal part name is already found
		BEGIN
			RAISERROR('Part already exists in the database, part addition aborted!', -1, -1);
			RETURN;
		END;
		ELSE IF NOT EXISTS(SELECT ven_name FROM Vendor WHERE ven_name = @p_supplier_name)		-- if the supplier doesn't yet exist
		BEGIN
			RAISERROR('Part supplier not found in the database, please add vendor first!', -1, -1)
			RETURN;
		END;

	-- Vehicle doesn't know whether the IDs for the foreign key parameters are new or existing in the associated tables.  Therefore it
	-- needs to perform subquery lookups of all tables to pull the right id.

	INSERT INTO Part (part_id, part_name, maintainer_id, part_quantity_on_hand, part_quantity_units, part_description, part_serial_number)
	VALUES	(NEXT VALUE FOR part_seq,																-- next synthetic ID for part
				@p_name,																			-- passed through part name
				(SELECT maintainer_id FROM Vendor v WHERE v.ven_name = @p_supplier_name),			-- subquery to find matching vendor id within Vendor
				@p_quant_rcvd,																		-- passed through quantity received
				@p_quant_units,																		-- passed through quantity units
				@p_desc,																			-- passed through part description
				@p_serial);																			-- passed through part serial
																														
END;
GO
--INSERTS

-- Add Vehicle
BEGIN TRANSACTION AddVehicle;
EXECUTE	AddVehicle	'Mustang', 1266, 'Ford', 1901, 'FGN2098', '4Y1HL65848Z411492', 'Standard Vehicle', 3, '07-MAR-2022';
COMMIT TRANSACTION AddVehicle;

--Multiple inserts to fill out Vehicle table
BEGIN TRANSACTION AddVehicle;
EXECUTE	AddVehicle	'Fusion', 1272, 'Ford', 2022, 'HGG2739', '581HL65848GH11481', 'Standard Vehicle', 673, '12-MAR-2022';
COMMIT TRANSACTION AddVehicle;
BEGIN TRANSACTION AddVehicle;
EXECUTE	AddVehicle	'F350', 2098, 'Ford', 2002, 'FGN2059', '6Z1HL65848Z411492', 'CDL Vehicle', 64556, '10-MAY-2022';
COMMIT TRANSACTION AddVehicle;
BEGIN TRANSACTION AddVehicle;
EXECUTE	AddVehicle	'Silverado', 2021, 'Chevrolet', 1997, 'GHU2848', '781HL65848Z414598', 'Standard Vehicle', 35234, '23-APR-2022';
COMMIT TRANSACTION AddVehicle;
BEGIN TRANSACTION AddVehicle;
EXECUTE	AddVehicle	'Ram 1500', 1006, 'Dodge', 2005, 'JRT2093', '3XYHL65848Z436741', 'Standard Vehicle', 13542, '12-NOV-2022';
COMMIT TRANSACTION AddVehicle;
BEGIN TRANSACTION AddVehicle;
EXECUTE	AddVehicle	'Mustang', 3002, 'Ford', 2018, 'PQN3483', '21AHL65848Z452287', 'Standard Vehicle', 52344, '01-DEC-2022';
COMMIT TRANSACTION AddVehicle;
BEGIN TRANSACTION AddVehicle;
EXECUTE	AddVehicle	'Fusion', 1200, 'Ford', 2005, 'HGG2739', '3RGTY65848GH11481', 'Standard Vehicle', 45645, '21-MAR-2022';
COMMIT TRANSACTION AddVehicle;
BEGIN TRANSACTION AddVehicle;
EXECUTE	AddVehicle	'F550', 2679, 'Ford', 2021, 'FGN2059', '9YHGR25848Z411492', 'CDL Vehicle', 84556, '05-MAY-2022';
COMMIT TRANSACTION AddVehicle;
BEGIN TRANSACTION AddVehicle;
EXECUTE	AddVehicle	'Silverado', 0026, 'Chevrolet', 2016, 'GHU2848', '6YGWQ65848Z414598', 'Standard Vehicle', 23344, '28-APR-2022';
COMMIT TRANSACTION AddVehicle;
BEGIN TRANSACTION AddVehicle;
EXECUTE	AddVehicle	'Ram 2500', 1016, 'Dodge', 2007, 'JRT2093', '7UJGH65848Z436741', 'Standard Vehicle', 542545, '01-NOV-2022';
COMMIT TRANSACTION AddVehicle;
BEGIN TRANSACTION AddVehicle;
EXECUTE	AddVehicle	'Mustang', 3015, 'Ford', 2012, 'PQN3483', '5IONTW5848Z452287', 'Standard Vehicle', 8523, '25-DEC-2022';
COMMIT TRANSACTION AddVehicle;

SELECT * FROM Vehicle
SELECT * FROM VehicleMake
SELECT * FROM VehicleModel
SELECT * FROM VehicleType

--Add Vendor
BEGIN TRANSACTION AddVendor;
EXECUTE	AddVendor	'Diamond Auto Glass', 8, 'Dairy Street', 'Marysville', 'PA', '17312', '717-841-2303', NULL, 'James Bond', NULL 
COMMIT TRANSACTION AddVehicle;

-- Multiple inserts to fill out Vendor table
BEGIN TRANSACTION AddVendor;
EXECUTE	AddVendor	'Jerrys Garage', 487, 'Laramie Street', 'Poolesville', 'PA', '14897', '496-589-1258', '2348923', 'George Brown', NULL 
COMMIT TRANSACTION AddVehicle;
BEGIN TRANSACTION AddVendor;
EXECUTE	AddVendor	'Pauls Garage', 657, 'Sun Lane', 'Amity', 'MD', '15645', '446-244-5578', NULL, 'Tom Gregory', 'pgarage@aol.com' 
COMMIT TRANSACTION AddVehicle;
BEGIN TRANSACTION AddVendor;
EXECUTE	AddVendor	'NAPA Auto Parts', 67, 'Line Street', 'Sweetville', 'PA', '18534', '563-345-2303', 'GSD89789', 'Fred James', NULL 
COMMIT TRANSACTION AddVehicle;
BEGIN TRANSACTION AddVendor;
EXECUTE	AddVendor	'Advance Auto Parts', 675, 'Queen Avenue', 'Stoney', 'PA', '19543', '159-572-7528', NULL, 'Sammy Todd', 'advance@ap.net' 
COMMIT TRANSACTION AddVehicle;
BEGIN TRANSACTION AddVendor;
EXECUTE	AddVendor	'Ace Hardware', 2342, 'Tommy Lane', 'Autumnvale', 'NY', '12346', '952-454-4597', NULL, 'Julie Gill', 'aceistheplace@yahoo.com'
COMMIT TRANSACTION AddVehicle;

SELECT * FROM Maintainer
SELECT * FROM Vendor

-- Multiple inserts to fill out Part table
BEGIN TRANSACTION AddPart;
EXECUTE AddPart		'Lug Nut', 'Advance Auto Parts', 32, 'nut', NULL, NULL
COMMIT TRANSACTION AddPart;
BEGIN TRANSACTION AddPart;
EXECUTE AddPart		'Windshield Wiper', 'Advance Auto Parts', 10, 'wiper blade', NULL, 'WS321-5'
COMMIT TRANSACTION AddPart
BEGIN TRANSACTION AddPart;
EXECUTE AddPart		'Oil, 30W', 'NAPA Auto Parts', 20, 'quart', 'for fall/winter oil changes', 'CS-0W30'
COMMIT TRANSACTION AddPart
BEGIN TRANSACTION AddPart;
EXECUTE AddPart		'WD-40	', 'Ace Hardware', 6, 'can', NULL, NULL
COMMIT TRANSACTION AddPart
BEGIN TRANSACTION AddPart;
EXECUTE AddPart		'S32 Hydraulic Oil Filter', 'Advance Auto Parts', 1, 'filter', 'for Ford CDL Vehicles only', 'S3202'
COMMIT TRANSACTION AddPart

SELECT * FROM Part

--TRIGGERS
-- PartHistory trigger

CREATE OR ALTER TRIGGER PartHistoryTrigger
ON Part
AFTER UPDATE
AS
BEGIN
	DECLARE @old_quantity DECIMAL(4) = (SELECT part_quantity_on_hand FROM DELETED)
	DECLARE @new_quantity DECIMAL(4) = (SELECT part_quantity_on_hand FROM INSERTED)

	IF (@old_quantity != @new_quantity)
		INSERT INTO PartHistory(part_history_id, part_id, part_old_quant, part_new_quant, part_change_date)
		VALUES(NEXT VALUE FOR part_history_seq,
			(SELECT part_id FROM INSERTED),
			@old_quantity, 
			@new_quantity,
			GETDATE()	);
END;
GO
-- Proofing Queries & Updates for PartHistoryTrigger

SELECT * FROM Part
SELECT * FROM PartHistory

UPDATE Part 
SET		part_quantity_on_hand = 30
WHERE	part_name = 'Lug Nut';
UPDATE Part 
SET		part_quantity_on_hand = 25
WHERE	part_name = 'Lug Nut';
UPDATE Part 
SET		part_quantity_on_hand = 3
WHERE	part_name = 'Oil, 30W';
UPDATE Part 
SET		part_quantity_on_hand = 28
WHERE	part_name = 'Windshield Wiper';
UPDATE Part 
SET		part_quantity_on_hand = 10
WHERE	part_name = 'S32 Hydraulic Oil Filter';

SELECT * FROM Part
SELECT * FROM PartHistory


--QUERIES

/*	Query #1  
How many vehicles qualify for trade in through the municipal lease program?  Select all vehicles with 5,000 miles or greater and are
more than 3 years old.  Show how many distinct types of vehicles apply, giving the make, model and type in the result.  Order the 
results descending by mileage and give a count of how many vehicles are within each output row and percentage of the overall fleet.
*/

SELECT vmk.make_name AS 'Vehicle Name', vmd.model_name AS 'Vehicle Model', vt.vehicle_type AS 'Vehicle Type',
		format(AVG(v.veh_last_mileage), 'N0') AS 'Average Mileage', COUNT(v.vehicle_year) AS 'Number',
		format(CAST(COUNT(v.vehicle_id) AS FLOAT)  / (SELECT COUNT(vehicle_id) FROM Vehicle), 'P') AS '% of Fleet'
FROM	Vehicle v
	JOIN	VehicleType vt	ON	vt.vehicle_type_id = v.vehicle_type_id
	JOIN	VehicleMake vmk	ON	vmk.vehicle_make_id = v.vehicle_make_id
	JOIN	VehicleModel vmd ON	 vmd.vehicle_model_id = v.vehicle_model_id
WHERE (v.veh_last_mileage >= 5000) AND (v.vehicle_year < YEAR(GETDATE())-3)
GROUP BY vmk.make_name, vmd.model_name, vt.vehicle_type
ORDER BY AVG(v.veh_last_mileage) DESC

-- Proofing query to Query #1, an output of all vehicles for manual calculation
SELECT v.vehicle_year AS 'Vehicle Year', vmk.make_name AS 'Vehicle Name', vmd.model_name AS 'Vehicle Model', 
		vt.vehicle_type AS 'Vehicle Type', format(v.veh_last_mileage, 'N0') AS ' Mileage'
FROM	Vehicle v
	JOIN	VehicleType vt	ON	vt.vehicle_type_id = v.vehicle_type_id
	JOIN	VehicleMake vmk	ON	vmk.vehicle_make_id = v.vehicle_make_id
	JOIN	VehicleModel vmd ON	 vmd.vehicle_model_id = v.vehicle_model_id

/*  Query #2
Generate a list of parts that have a quantity 10 'units' or under.  List them in a results table alongside the vendor which sells the
part, their phone number, email if known and agent if known.  Due to intra-state shipping surcharges, administration doesn't want 
anyone purchasing parts from out-of-state (PA in my case).  Disqualify any parts from the list which have vendors outside of PA.
*/

SELECT p.part_name AS 'Part Name', p.part_quantity_on_hand AS 'Quantity', v.ven_name AS 'Vendor', m.maint_phone_num AS 'Phone #', 
		m.maint_email AS 'Email', v.ven_agent AS 'Agent'
FROM	Part p
	JOIN Vendor v		ON p.maintainer_id = v.maintainer_id
	JOIN Maintainer m	ON m.maintainer_id = v.maintainer_id
WHERE (v.ven_state = 'PA') AND (p.part_quantity_on_hand <= 10)

-- Proofing query to Query #2, an output of all parts for manual calculation
SELECT p.part_name AS 'Part Name', p.part_quantity_on_hand AS 'Quantity', v.ven_name AS 'Vendor', m.maint_phone_num AS 'Phone #', 
		m.maint_email AS 'Email', v.ven_agent AS 'Agent', v.ven_state AS 'State'
FROM	Part p
	JOIN Vendor v		ON p.maintainer_id = v.maintainer_id
	JOIN Maintainer m	ON m.maintainer_id = v.maintainer_id

/*  Query #3
Generate a list of how many vehicle inspections are due in which months.  There should be 12 results, one for each month with the
number of inspections given in each month, even if there are none.  The list should be chronologically correct in order of month.  
CDL Vehicle inspections run on a 6-month interval, where Standard Vehicle inspections run on a 12-month interval.
*/

CREATE OR ALTER VIEW YearlyInspectionList AS
SELECT  M.month_name AS Month_of_Year, count(insp_month) AS Number_of_Inspections, M.month_id AS Month_Num
	
FROM (SELECT month_id, month_name 
		FROM ( 
		VALUES	(1, 'January'), (2, 'February'), (3, 'March'), (4, 'April'),
			(5, 'May'), (6, 'June'), (7, 'July'), (8, 'August'), (9, 'September'),
			(10, 'October'), (11, 'November'), (12, 'December')  
		)
		AS	 Months(month_id, month_name)
	) M
	LEFT JOIN (
		 (SELECT (MONTH(V.veh_schd_insp_date) + 6) % 12 AS insp_month
			FROM Vehicle V
				JOIN VehicleType VT ON VT.vehicle_type_id = V.vehicle_type_id
			WHERE VT.vehicle_type = 'CDL Vehicle') UNION All 
		 (SELECT MONTH(V.veh_schd_insp_date) AS insp_month 
			FROM Vehicle V) ) IM ON IM.insp_month = M.month_id 

GROUP BY M.month_name, M.month_id;	
GO

-- Using View of Query #3
SELECT Month_of_Year AS 'Month', Number_of_Inspections AS '# of Inspections' 
FROM YearlyInspectionList
ORDER BY Month_Num

-- Proofing query to Query #3, an output of all vehicles for manual calculation
SELECT v.vehicle_year AS 'Vehicle Year', vmk.make_name AS 'Vehicle Name', vmd.model_name AS 'Vehicle Model', 
		vt.vehicle_type AS 'Vehicle Type', v.veh_schd_insp_date AS 'Inspection Date', MONTH(v.veh_schd_insp_date) AS 'Month Number'
FROM	Vehicle v
	JOIN	VehicleType vt	ON	vt.vehicle_type_id = v.vehicle_type_id
	JOIN	VehicleMake vmk	ON	vmk.vehicle_make_id = v.vehicle_make_id
	JOIN	VehicleModel vmd ON	 vmd.vehicle_model_id = v.vehicle_model_id;


-- Data visualization query #1

/* Create a query that groups the vehicles into age ‘buckets’.  The categories will be ‘newer’ (less than 3 years old), ‘average’ 
(between 3 and 8 years old, inclusive), and ‘older’ (over 8 years old).  The query will return the count of how many vehicles fit 
each bucket.  The results should be fed into a graphical display for analysis.   Note:  management knows that the mechanics keep 
a vintage toy ‘1901 Ford Sweepstakes Racer’ in the shop that they put in the program as a Mustang.  Please omit this result…
*/

SELECT V.Category, V.Vehicles FROM 
	(SELECT  
			CASE	
				WHEN YEAR(GETDATE()) - v.vehicle_year < 3	THEN 'newer (0-2 years)'
				WHEN (YEAR(GETDATE()) - v.vehicle_year) >= 3 AND (YEAR(GETDATE()) - v.vehicle_year) <= 8 THEN 'average (3-8 years)'
				ELSE 'older (9+ years)'
			END AS Category, COUNT (v.vehicle_year) AS Vehicles, 
			CASE	
				WHEN YEAR(GETDATE()) - v.vehicle_year < 3	THEN 1
				WHEN (YEAR(GETDATE()) - v.vehicle_year) >= 3 AND (YEAR(GETDATE()) - v.vehicle_year) <= 8 THEN 2
				ELSE 3
			END AS rowCounter 
				
	FROM	Vehicle v
	WHERE v.vehicle_year > 1990
	GROUP BY 
			CASE	
				WHEN YEAR(GETDATE()) - v.vehicle_year < 3	THEN 'newer (0-2 years)'
				WHEN (YEAR(GETDATE()) - v.vehicle_year) >= 3 AND (YEAR(GETDATE()) - v.vehicle_year) <= 8 THEN 'average (3-8 years)'
				ELSE 'older (9+ years)'
			END,
			CASE	
				WHEN YEAR(GETDATE()) - v.vehicle_year < 3	THEN 1
				WHEN (YEAR(GETDATE()) - v.vehicle_year) >= 3 AND (YEAR(GETDATE()) - v.vehicle_year) <= 8 THEN 2
				ELSE 3
			END 
	
) V	
ORDER BY V.rowCounter ASC


	
	

	