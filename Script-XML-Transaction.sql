SELECT I_TRANSMISSION_NO, I_TRANSACTION_NO, StopSequence, XML_BLOB
FROM (
        SELECT ITRAC.*, EXTRACTVALUE(XMLTYPE(REPLACE(REPLACE(ITRAC.XML_BLOB, 'otm:', ''), 
        ' xmlns:otm="http://xmlns.oracle.com/apps/otm"','')), 'Transmission/TransmissionBody/GLogXMLElement/TenderOffer/Shipment/ShipmentStop/StopSequence') StopSequence
        FROM I_TRANSMISSION ITMS INNER JOIN
        I_TRANSACTION ITRAC ON ITMS.I_TRANSMISSION_NO = ITRAC.I_TRANSMISSION_NO
        WHERE ELEMENT_NAME = 'TenderOffer'
        --AND TO_CHAR(ITMS.INSERT_DATE, 'DD/MM/YYYY') >= '20/05/2025'
        --AND ITMS.DOMAIN_NAME = 'NBL/MX'
        AND I_TRANSMISSION_NO = 62220099
    ) T




SELECT ITRAC.*, EXTRACTVALUE(XMLTYPE(REPLACE(REPLACE(ITRAC.XML_BLOB, 'otm:', ''), ' xmlns:otm="http://xmlns.oracle.com/apps/otm"','')), 'TenderOffer/Shipment/ShipmentStop/StopSequence') StopSequence
FROM I_TRANSMISSION ITMS INNER JOIN
I_TRANSACTION ITRAC ON ITMS.I_TRANSMISSION_NO = ITRAC.I_TRANSMISSION_NO
WHERE ITMS.I_TRANSMISSION_NO = 62220099


Transmission/TransmissionBody/GLogXMLElement/TenderOffer/Shipment/ShipmentStop/StopSequence

LocationRef
LocationGid
Gid
Xid


SELECT ITRAC.OBJECT_GID
, EXTRACTVALUE(XMLTYPE(REPLACE(REPLACE(ITRAC.XML_BLOB, 'otm:', ''), ' xmlns:otm="http://xmlns.oracle.com/apps/otm"','')),
'TenderOffer/Shipment/ShipmentStop[1]/StopSequence') StopSequence
, EXTRACTVALUE(XMLTYPE(REPLACE(REPLACE(ITRAC.XML_BLOB, 'otm:', ''), ' xmlns:otm="http://xmlns.oracle.com/apps/otm"','')),
'TenderOffer/Shipment/ShipmentStop[1]/LocationRef/LocationGid/Gid/Xid') LocationGid
, EXTRACTVALUE(XMLTYPE(REPLACE(REPLACE(ITRAC.XML_BLOB, 'otm:', ''), ' xmlns:otm="http://xmlns.oracle.com/apps/otm"','')),
'TenderOffer/Shipment/ShipmentStop[2]/StopSequence') StopSequence
, EXTRACTVALUE(XMLTYPE(REPLACE(REPLACE(ITRAC.XML_BLOB, 'otm:', ''), ' xmlns:otm="http://xmlns.oracle.com/apps/otm"','')),
'TenderOffer/Shipment/ShipmentStop[2]/LocationRef/LocationGid/Gid/Xid') LocationGid
, EXTRACTVALUE(XMLTYPE(REPLACE(REPLACE(ITRAC.XML_BLOB, 'otm:', ''), ' xmlns:otm="http://xmlns.oracle.com/apps/otm"','')),
'TenderOffer/Shipment/ShipmentStop[3]/StopSequence') StopSequence
, EXTRACTVALUE(XMLTYPE(REPLACE(REPLACE(ITRAC.XML_BLOB, 'otm:', ''), ' xmlns:otm="http://xmlns.oracle.com/apps/otm"','')),
'TenderOffer/Shipment/ShipmentStop[3]/LocationRef/LocationGid/Gid/Xid') LocationGid
, EXTRACTVALUE(XMLTYPE(REPLACE(REPLACE(ITRAC.XML_BLOB, 'otm:', ''), ' xmlns:otm="http://xmlns.oracle.com/apps/otm"','')),
'TenderOffer/Shipment/ShipmentStop[4]/StopSequence') StopSequence
, EXTRACTVALUE(XMLTYPE(REPLACE(REPLACE(ITRAC.XML_BLOB, 'otm:', ''), ' xmlns:otm="http://xmlns.oracle.com/apps/otm"','')),
'TenderOffer/Shipment/ShipmentStop[4]/LocationRef/LocationGid/Gid/Xid') LocationGid
, EXTRACTVALUE(XMLTYPE(REPLACE(REPLACE(ITRAC.XML_BLOB, 'otm:', ''), ' xmlns:otm="http://xmlns.oracle.com/apps/otm"','')),
'TenderOffer/Shipment/ShipmentStop[5]/StopSequence') StopSequence
, EXTRACTVALUE(XMLTYPE(REPLACE(REPLACE(ITRAC.XML_BLOB, 'otm:', ''), ' xmlns:otm="http://xmlns.oracle.com/apps/otm"','')),
'TenderOffer/Shipment/ShipmentStop[5]/LocationRef/LocationGid/Gid/Xid') LocationGid
, EXTRACTVALUE(XMLTYPE(REPLACE(REPLACE(ITRAC.XML_BLOB, 'otm:', ''), ' xmlns:otm="http://xmlns.oracle.com/apps/otm"','')),
'TenderOffer/Shipment/ShipmentStop[6]/StopSequence') StopSequence
, EXTRACTVALUE(XMLTYPE(REPLACE(REPLACE(ITRAC.XML_BLOB, 'otm:', ''), ' xmlns:otm="http://xmlns.oracle.com/apps/otm"','')),
'TenderOffer/Shipment/ShipmentStop[7]/LocationRef/LocationGid/Gid/Xid') LocationGid
, EXTRACTVALUE(XMLTYPE(REPLACE(REPLACE(ITRAC.XML_BLOB, 'otm:', ''), ' xmlns:otm="http://xmlns.oracle.com/apps/otm"','')),
'TenderOffer/Shipment/ShipmentStop[7]/StopSequence') StopSequence
, EXTRACTVALUE(XMLTYPE(REPLACE(REPLACE(ITRAC.XML_BLOB, 'otm:', ''), ' xmlns:otm="http://xmlns.oracle.com/apps/otm"','')),
'TenderOffer/Shipment/ShipmentStop[7]/LocationRef/LocationGid/Gid/Xid') LocationGid
, EXTRACTVALUE(XMLTYPE(REPLACE(REPLACE(ITRAC.XML_BLOB, 'otm:', ''), ' xmlns:otm="http://xmlns.oracle.com/apps/otm"','')),
'TenderOffer/Shipment/ShipmentStop[8]/StopSequence') StopSequence
, EXTRACTVALUE(XMLTYPE(REPLACE(REPLACE(ITRAC.XML_BLOB, 'otm:', ''), ' xmlns:otm="http://xmlns.oracle.com/apps/otm"','')),
'TenderOffer/Shipment/ShipmentStop[8]/LocationRef/LocationGid/Gid/Xid') LocationGid
, EXTRACTVALUE(XMLTYPE(REPLACE(REPLACE(ITRAC.XML_BLOB, 'otm:', ''), ' xmlns:otm="http://xmlns.oracle.com/apps/otm"','')),
'TenderOffer/Shipment/ShipmentStop[9]/StopSequence') StopSequence
, EXTRACTVALUE(XMLTYPE(REPLACE(REPLACE(ITRAC.XML_BLOB, 'otm:', ''), ' xmlns:otm="http://xmlns.oracle.com/apps/otm"','')),
'TenderOffer/Shipment/ShipmentStop[9]/LocationRef/LocationGid/Gid/Xid') LocationGid
FROM I_TRANSMISSION ITMS INNER JOIN
I_TRANSACTION ITRAC ON ITMS.I_TRANSMISSION_NO = ITRAC.I_TRANSMISSION_NO
WHERE ITMS.I_TRANSMISSION_NO = 62220099
        WHERE ELEMENT_NAME = 'AllocationBase'
        AND TO_CHAR(ITMS.INSERT_DATE, 'DD/MM/YYYY') >= '20/05/2025'

SELECT 
ITRAC.OBJECT_GID
, EXTRACTVALUE(XMLTYPE(REPLACE(REPLACE(ITRAC.XML_BLOB, 'otm:', ''), ' xmlns:otm="http://xmlns.oracle.com/apps/otm"','')),
'TenderOffer/Shipment/ShipmentStop') StopSequence
FROM I_TRANSMISSION ITMS INNER JOIN
I_TRANSACTION ITRAC ON ITMS.I_TRANSMISSION_NO = ITRAC.I_TRANSMISSION_NO
WHERE ITMS.I_TRANSMISSION_NO = 62220099

SELECT
    po_data.stopNum
FROM
    XMLTABLE('/TenderOffer/Shipment/ShipmentStop'
        PASSING XMLTYPE(REPLACE(REPLACE(ITRAC.XML_BLOB, 'otm:', ''), ' xmlns:otm="http://xmlns.oracle.com/apps/otm"','')) -- Cast the CLOB to XMLTYPE
        COLUMNS
            stopNum VARCHAR2(20) PATH '@StopSequence'
    ) po_data



SELECT itc.element_name, x.user_classification3
FROM i_transaction itc
CROSS JOIN XMLTABLE(
  XMLNAMESPACES(DEFAULT 'http://xmlns.oracle.com/apps/otm'),
  '/TenderOffer/Shipment/RATE_OFFERING/RATE_OFFERING_ROW'
  PASSING XMLTYPE(itc.xml_blob)
  COLUMNS user_classification3 VARCHAR2(10) PATH 'USER_CLASSIFICATION3'
) x
WHERE itc.i_transaction_no = 801119723
AND ROWNUM = 1
;

SELECT itc.element_name, x.rate_geo_gid
FROM i_transaction itc
CROSS JOIN XMLTABLE(XMLTYPE(REPLACE(REPLACE(ITRAC.XML_BLOB, 'otm:', ''), ' xmlns:otm="http://xmlns.oracle.com/apps/otm"',''))
, '/TenderOffer/Shipment/RATE_GEO/RATE_GEO_ROW'
  PASSING XMLTYPE(itc.xml_blob)
  COLUMNS rate_geo_gid VARCHAR2(50) PATH 'RATE_GEO_GID'
) x
WHERE itc.i_transaction_no = 801119723
AND ROWNUM = 1
                    ;

SELECT 
    xt.Xid 
FROM 
    i_transaction itc, 
    XMLTABLE(
        XMLNAMESPACES(
            DEFAULT 'http://xmlns.oracle.com/apps/otm'  
        ), 
        '/Transmission/TransmissionBody/GLogXMLElement'  
        PASSING xmltype(itc.xml_blob)  
        COLUMNS 
            Xid VARCHAR2(50) PATH '/TransOrder/TransOrderHeader/TransOrderGid/Gid/Xid' 
    ) xt 
WHERE itc.i_transaction_no = 776799254
    ;



SELECT * 
FROM
    i_transaction itc
WHERE
    itc.i_transaction_no = 
    


    SELECT 
    xt.Xid 
FROM 
    i_transaction itc, 
    XMLTABLE(
        XMLNAMESPACES(
            DEFAULT 'http://xmlns.oracle.com/apps/otm'  
        ), 
        '/Transmission/TransmissionBody/GLogXMLElement'  
        PASSING xmltype(itc.xml_blob)  
        COLUMNS 
            Xid VARCHAR2(50) PATH '/TransOrder/TransOrderHeader/TransOrderGid/Gid/Xid' 
    ) xt 
WHERE TO_CHAR(ITMS.INSERT_DATE, 'DD/MM/YYYY') >= '20/05/2025'