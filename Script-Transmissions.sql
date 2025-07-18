--------------------Query Tranmisiones--------------------

 SELECT /*INSERT_DATE,
		STATUS,
		ELEMENT_NAME,
		DATA_QUERY_TYPE_GID, */
        *
		--EXTRACTVALUE(XMLTYPE(REPLACE(REPLACE(XML_BLOB, 'otm:', ''), ' xmlns:otm="http://xmlns.oracle.com/apps/otm/transmission/v6.4"','')),
		--'Invoice/Payment/PaymentHeader/ServiceProviderGid/Gid/Xid') ServiceProvider
   FROM I_TRANSACTION@OTMRO.NIAGARAWATER.COM
  WHERE /*DOMAIN_NAME = 'NBL'
  AND*/ ELEMENT_NAME = 'Invoice'
  AND TO_CHAR(INSERT_DATE,'DD/MM/YYYY') = '16/08/2023'
  AND STATUS = 'ERROR';
  AND OBJECT_ID LIKE '%MX%';
  --  AND EXTRACTVALUE(XMLTYPE(REPLACE(REPLACE(XML_BLOB, 'otm:', ''), ' xmlns:otm="http://xmlns.oracle.com/apps/otm/transmission/v6.4"','')),'Invoice/Payment/PaymentHeader/ServiceProviderGid/Gid/Xid') = 'CAR-3892507';--'CAR-2242743';

---------------------Query XML--------------------------------

 SELECT INSERT_DATE,
		STATUS,
		ELEMENT_NAME,
		DATA_QUERY_TYPE_GID,
		EXTRACTVALUE(XMLTYPE(REPLACE(REPLACE(XML_BLOB, 'otm:', ''), ' xmlns:otm="http://xmlns.oracle.com/apps/otm/transmission/v6.4"','')),
		'/ShipmentStatus/ShipmentRefnum/ShipmentRefnumValue') Embarque,
		EXTRACTVALUE(XMLTYPE(REPLACE(REPLACE(XML_BLOB, 'otm:', ''), ' xmlns:otm="http://xmlns.oracle.com/apps/otm/transmission/v6.4"','')),
		'/ShipmentStatus/StatusCodeGid/Gid/Xid') Evento,
		EXTRACTVALUE(XMLTYPE(REPLACE(REPLACE(XML_BLOB, 'otm:', ''), ' xmlns:otm="http://xmlns.oracle.com/apps/otm/transmission/v6.4"','')),
		'/ShipmentStatus/EventDt/GLogDate') Fecha
   FROM GLOGOWNER.I_TRANSACTION
  WHERE /*DOMAIN_NAME = 'NBL'
  AND*/ ELEMENT_NAME = 'Invoice';
   -- AND ELEMENT_NAME = 'ShipmentStatus'
  --  AND EXTRACTVALUE(XMLTYPE(REPLACE(REPLACE(XML_BLOB, 'otm:', ''), ' xmlns:otm="http://xmlns.oracle.com/apps/otm/transmission/v6.4"','')),
   --     '/ShipmentStatus/ResponsiblePartyGid/Gid/Xid') = 'PROVEEDOR_POD'
    --AND TO_DATE(INSERT_DATE) > SYSDATE - 2;
    
    
SELECT TRAC.*
FROM I_TRANSMISSION TRAN INNER JOIN
I_TRANSACTION TRAC ON TRAN.I_TRANSMISSION_NO = TRAC.I_TRANSMISSION_NO
WHERE ELEMENT_NAME = 'Invoice'
AND OBJECT_GID LIKE '%NBL%';

SELECT TRAC.OBJECT_GID
FROM I_TRANSMISSION TRAN INNER JOIN
I_TRANSACTION TRAC ON TRAN.I_TRANSMISSION_NO = TRAC.I_TRANSMISSION_NO
WHERE TRAC.ELEMENT_NAME = 'PlannedShipment'
AND TO_CHAR(TRAN.INSERT_DATE,'DD/MM/YYYY') = '09/09/2024'
AND TRAN.EXTERNAL_SYSTEM_GID = 'NBL/MX.RC_PLANNED_SHIPMENT_STATUS'
GROUP BY OBJECT_GID
ORDER BY OBJECT_GID
;


--Actual Shipment

SELECT INSERT_DATE,
		STATUS,
		ELEMENT_NAME,
		DATA_QUERY_TYPE_GID,
		EXTRACTVALUE(XMLTYPE(REPLACE(REPLACE(XML_BLOB, 'otm:', ''), ' xmlns:otm="http://xmlns.oracle.com/apps/otm/transmission/v6.4"','')),
		'/ActualShipment/Shipment/ShipmentHeader/Remark[1]/RemarkText[1]') SHIP_DATE
FROM I_TRANSACTION
WHERE ELEMENT_NAME = 'ActualShipment'
AND TO_DATE(INSERT_DATE) > SYSDATE - 2;

SELECT OBJECT_GID,
		ELEMENT_NAME,
		STATUS,
		TO_CHAR(INSERT_DATE, 'DD-MON-YYYY HH12:MI:SS PM') INSERT_DATE,
		EXTRACTVALUE(XMLTYPE(REPLACE(REPLACE(XML_BLOB, 'otm:', ''), ' xmlns:otm="http://xmlns.oracle.com/apps/otm/transmission/v6.4"','')),
		'/ActualShipment/Shipment/ShipmentHeader/Remark[1]/RemarkText[1]') SHIP_DATE
FROM I_TRANSACTION
WHERE ELEMENT_NAME = 'ActualShipment'
AND OBJECT_GID LIKE '%NBL/MX%'
AND STATUS = 'ERROR'
ORDER BY INSERT_DATE DESC;
AND TO_CHAR(INSERT_DATE,'DD/MM/YYYY') >= '27/11/2024'
;


--/ActualShipment/Shipment[1]/ShipmentHeader[1]/Remark[1]/RemarkText[1]


SELECT INSERT_DATE,
		STATUS,
		ELEMENT_NAME,
		DATA_QUERY_TYPE_GID,
		OBJECT_GID
FROM I_TRANSMISSION TRAN INNER JOIN
I_TRANSACTION TRAC ON TRAN.I_TRANSMISSION_NO = TRAC.I_TRANSMISSION_NO
WHERE ELEMENT_NAME = 'PlannedShipment'
AND TO_CHAR(INSERT_DATE,'DD/MM/YYYY') >= '28/01/2025';



SELECT TRAC.INSERT_DATE,
		TRAC.STATUS,
		TRAC.ELEMENT_NAME,
		TRAC.DATA_QUERY_TYPE_GID,
		TRAC.OBJECT_GID
FROM I_TRANSMISSION TRAN INNER JOIN
I_TRANSACTION TRAC ON TRAN.I_TRANSMISSION_NO = TRAC.I_TRANSMISSION_NO
WHERE TO_CHAR(TRAC.INSERT_DATE,'DD/MM/YYYY') >= '28/01/2025'
AND TRAN.EXTERNAL_SYSTEM_GID = 'NBL/MX.RC_PLANNED_SHIPMENT_STATUS';