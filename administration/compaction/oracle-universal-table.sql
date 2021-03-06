-- Drop all data before test
DROP TABLE TradeHistory CASCADE CONSTRAINTS PURGE;
DROP TABLE TradeHistory_Compressed CASCADE CONSTRAINTS PURGE;
DROP TABLE UniversalHistory CASCADE CONSTRAINTS PURGE;
DROP TABLE UniversalHistory_Compressed CASCADE CONSTRAINTS PURGE;
DROP TABLE Instruments CASCADE CONSTRAINTS PURGE;
DROP TABLE Metrics CASCADE CONSTRAINTS PURGE;
DROP TABLE temporary_csv_data_table CASCADE CONSTRAINTS PURGE;
DROP DIRECTORY data_dir;

-- Create Instruments table with auto-increment index
CREATE TABLE Instruments(
   Id NUMBER(7) GENERATED ALWAYS as IDENTITY NOT NULL,
   Name VARCHAR(20),
   CONSTRAINT Instruments_pk PRIMARY KEY (Id)
);

INSERT INTO Instruments (Name) VALUES ('IBM');

-- Create Metrics table with auto-increment index
CREATE TABLE Metrics(
   Id NUMBER(7) GENERATED ALWAYS as IDENTITY NOT NULL,
   Name VARCHAR(20),
   CONSTRAINT Metrics_pk PRIMARY KEY (Id)
);

INSERT INTO Metrics (Name) VALUES ('Open');
INSERT INTO Metrics (Name) VALUES ('High');
INSERT INTO Metrics (Name) VALUES ('Low');
INSERT INTO Metrics (Name) VALUES ('Close');
INSERT INTO Metrics (Name) VALUES ('Volume');

-- Create a directory from which IBM_adjusted.txt will be loaded.
CREATE directory data_dir as '/data';

-- Create external table to load IBM_adjusted.txt CSV file.
CREATE TABLE temporary_csv_data_table (
   date_str VARCHAR2(20),
   time_str VARCHAR2(20),
   open NUMBER(7,4),
   high NUMBER(7,4),
   low  NUMBER(7,4),
   close NUMBER(7,4),
   volume NUMBER(8))
Organization external
(type oracle_loader
default directory data_dir
access parameters (records delimited by '\r\n'
fields terminated by ',')
location ('IBM_adjusted.txt'))
REJECT LIMIT 0;

-- Create UniversalHistory table
CREATE TABLE UniversalHistory(
   Instrument NUMBER(7) NOT NULL REFERENCES Instruments(Id), 
   Metric NUMBER(7) NOT NULL REFERENCES Metrics(Id), 
   Time TIMESTAMP(0) NOT NULL,
   Value NUMBER(12,4),
   CONSTRAINT UniversalHistory_pk PRIMARY KEY (Instrument, Metric, Time)
);

-- Load data from external table
-- Each OHLCV column is loaded with a separate INSERT INTO query

-- open
INSERT INTO UniversalHistory (Instrument, Metric, Time, Value)
   SELECT  1, 1,
	TO_TIMESTAMP(date_str || ' ' || time_str, 'MM/dd/YYYY HH24:MI:SS'),
	open
   FROM temporary_csv_data_table;

-- high
INSERT INTO UniversalHistory (Instrument, Metric, Time, Value)
   SELECT 1, 2,
	TO_TIMESTAMP(date_str || ' ' || time_str, 'MM/dd/YYYY HH24:MI:SS'),
	high
   FROM temporary_csv_data_table;

-- low
INSERT INTO UniversalHistory (Instrument, Metric, Time, Value)
   SELECT 1, 3,
	TO_TIMESTAMP(date_str || ' ' || time_str, 'MM/dd/YYYY HH24:MI:SS'),
	low
   FROM temporary_csv_data_table;

-- close
INSERT INTO UniversalHistory (Instrument, Metric, Time, Value)
   SELECT 1, 4,
	TO_TIMESTAMP(date_str || ' ' || time_str, 'MM/dd/YYYY HH24:MI:SS'),
	close
   FROM temporary_csv_data_table;

-- volume
INSERT INTO UniversalHistory (Instrument, Metric, Time, Value)
   SELECT 1, 5,
	TO_TIMESTAMP(date_str || ' ' || time_str, 'MM/dd/YYYY HH24:MI:SS'),
	volume
   FROM temporary_csv_data_table;

-- Delete external csv table
DROP TABLE temporary_csv_data_table;

-- Enable tabular presentation of query results.
SET COLSEP '|'
COLUMN SEGMENT_NAME FORMAT A30

-- Retrieve table size in bytes
SELECT segment_name, bytes
 FROM dba_segments
 WHERE segment_type='TABLE' and segment_name='UNIVERSALHISTORY';

-- Retrieve index size in bytes
SELECT segment_name, bytes
 FROM dba_segments
 WHERE segment_type='INDEX' and segment_name='UNIVERSALHISTORY_PK';

-- Retrieve row count in the UniversalHistory table
SELECT 
  'UNIVERSALHISTORY' AS "TABLE_NAME",
  COUNT(*) ROWS_COUNT
FROM UniversalHistory;

-- Create compressed table containing all records from UniversalHistory table
CREATE TABLE UniversalHistory_Compressed COMPRESS AS SELECT * FROM UniversalHistory;

-- Enable keys and index in the compressed table
ALTER TABLE UniversalHistory_Compressed ADD CONSTRAINT UniversalHistory_Compressed_Instrument_fk FOREIGN KEY (Instrument) REFERENCES Instruments(Id);
ALTER TABLE UniversalHistory_Compressed ADD CONSTRAINT UniversalHistory_Compressed_Metric_fk FOREIGN KEY (Metric) REFERENCES Metrics(Id);
ALTER TABLE UniversalHistory_Compressed ADD CONSTRAINT UniversalHistory_Compressed_pk PRIMARY KEY (Instrument, Metric, Time);
ALTER INDEX UniversalHistory_Compressed_pk REBUILD COMPRESS;

-- Retrieve table size in bytes
SELECT segment_name, bytes
 FROM dba_segments
 WHERE segment_type='TABLE' and segment_name='UNIVERSALHISTORY_COMPRESSED';

-- Retrieve index size in bytes
SELECT segment_name, bytes
 FROM dba_segments
 WHERE segment_type='INDEX' and segment_name='UNIVERSALHISTORY_COMPRESSED_PK';

-- Retrieve row count in the compressed UniversalHistory_Compressed table
SELECT 
  'UNIVERSALHISTORY_COMPRESSED' AS "TABLE_NAME",
  COUNT(*) ROWS_COUNT
FROM UniversalHistory_Compressed;
