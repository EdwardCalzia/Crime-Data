-- Load data from CSV file into a temporary table
CREATE TEMPORARY TABLE temp_crime_data (
    MajorText TEXT,
    MinorText TEXT,
    LookUp_BoroughName TEXT,
    "202103" INTEGER,
    "202104" INTEGER,
    "202105" INTEGER,
    "202106" INTEGER,
    "202107" INTEGER,
    "202108" INTEGER,
    "202109" INTEGER,
    "202110" INTEGER,
    "202111" INTEGER,
    "202112" INTEGER,
    "202201" INTEGER,
    "202202" INTEGER,
    "202203" INTEGER,
    "202204" INTEGER,
    "202205" INTEGER,
    "202206" INTEGER,
    "202207" INTEGER,
    "202208" INTEGER,
    "202209" INTEGER,
    "202210" INTEGER,
    "202211" INTEGER,
    "202212" INTEGER,
    "202301" INTEGER,
    "202302" INTEGER
);

COPY temp_crime_data FROM 'MPS Borough Level Crime (most recent 24 months).csv' DELIMITER ',' CSV HEADER;

-- Parse the data
SELECT MajorText, MinorText, LookUp_BoroughName, year_month, count
FROM (
    SELECT MajorText, MinorText, LookUp_BoroughName, 
        unnest(array['202103','202104','202105','202106','202107','202108','202109','202110','202111','202112','202201','202202','202203','202204','202205','202206','202207','202208','202209','202210','202211','202212','202301','202302']) AS year_month,
        unnest(array["202103","202104","202105","202106","202107","202108","202109","202110","202111","202112","202201","202202","202203","202204","202205","202206","202207","202208","202209","202210","202211","202212","202301","202302"]) AS count
    FROM temp_crime_data
) subquery
WHERE count > 0;
