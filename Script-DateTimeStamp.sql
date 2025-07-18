SELECT SYSTIMESTAMP, TO_UTC_TIMESTAMP_TZ('1998-01-01') FROM DUAL;


SELECT order_id, line_item_id,
   CAST(NULL AS TIMESTAMP WITH LOCAL TIME ZONE) order_date
   FROM order_items
UNION
SELECT order_id, to_number(null), order_date
   FROM orders;

   SELECT FROM_TZ(CAST(createdate AS TIMESTAMP), ' SESSIONTIMEZONE ') AT TIME ZONE 'UTC' AS UTC_DATE
FROM your_table;
/*
DECLARE
   l_today_date        DATE := SYSDATE;
   l_today_timestamp   TIMESTAMP := SYSTIMESTAMP;
   l_today_timetzone   TIMESTAMP WITH TIME ZONE := SYSTIMESTAMP;
   l_interval1         INTERVAL YEAR (4) TO MONTH := '2011-11';
   l_interval2         INTERVAL DAY (2) TO SECOND := '15 00:30:44';
BEGIN
   null;
END;
*/

ALTER SESSION SET NLS_DATE_FORMAT='YYYY/MM/DD HH24:MI:SS';

SELECT SYSTIMESTAMP, TO_CHAR(SYSDATE), TO_CHAR(SYSTIMESTAMP)
FROM dual;

SELECT SYSDATE, FROM_TZ(CAST('2025-04-23 14:39:56' AS TIMESTAMP), '-08:00') TZ FROM DUAL;


SELECT 1
FROM (
    SELECT str_to_timestamp, tz_to_timestamp_tz, tz_to_timestamp_tz AT TIME ZONE 'UTC' UTC, SYS48hrs, SYS5Days
    FROM (
        SELECT CAST(TO_DATE('2025-04-26 08:50:00', 'YYYY-MM-DD HH24:MI:SS') AS TIMESTAMP) str_to_timestamp,
        FROM_TZ(CAST(TO_DATE('2025-04-26 08:50:00', 'YYYY-MM-DD HH24:MI:SS') AS TIMESTAMP), '-06:00') tz_to_timestamp_tz,
        CAST(sysdate +48/24 AS TIMESTAMP) SYS48hrs, 
        CAST(sysdate +5 AS TIMESTAMP) SYS5Days
        ---, TO_UTC_TIMESTAMP_TZ(FROM_TZ(CAST(TO_DATE('2025-04-23 08:50:00', 'YYYY-MM-DD HH24:MI:SS') AS TIMESTAMP), '-06:00')) utc
    FROM DUAL
    )
)
WHERE UTC >= SYS48hrs
AND UTC <= SYS5Days
;





SELECT CAST(sysdate as timestamp), 
CAST(sysdate AS TIMESTAMP) AT TIME ZONE 'UTC', 
CAST(sysdate AS timestamp with time zone) AT TIME ZONE 'America/Mexico_City' AS local_time 
FROM DUAL;

SELECT FROM_TZ(CAST(SYSDATE AS TIMESTAMP), 'UTC') AT TIME ZONE 'America/Mexico_City' AS sydney_time
FROM dual;