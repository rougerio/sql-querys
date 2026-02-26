
select * from shipment;
select * from orders;
select * from ilm_appointments;
SELECT * FROM STATE_PROV;
select * from tran_log_message;
select * from tran_log;

ALTER SESSION SET CURRENT_SCHEMA = MTY_WMS;

SELECT * FROM STATE_PROV
WHERE COUNTRY_CODE = 'MX'
AND LENGTH(STATE_PROV) > 2
ORDER BY STATE_PROV_NAME;

--AND STATE_PROV_NAME LIKE 'Nuevo%';