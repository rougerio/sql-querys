SELECT DISTINCT 
    --ITM.I_TRANSMISSION_NO,
    SUBSTR(ITN.OBJECT_GID, 5, 3) AS ORG_CODE,
    SUBSTR(ITN.OBJECT_GID, 9, LENGTH(ITN.OBJECT_GID)-8) AS ITEM_CODE,
    ITN.OBJECT_GID,
    ITM.STATUS,
    ITM.CREATE_DATE
FROM I_TRANSACTION ITN INNER JOIN 
I_TRANSMISSION ITM ON ITN.I_TRANSMISSION_NO = ITM.I_TRANSMISSION_NO 
WHERE 1 = 1
AND ITM.IS_INBOUND='Y' 
AND ITN.ELEMENT_NAME ='Release' 
--AND ITM.I_TRANSMISSION_NO = 63980309
AND ITM.STATUS = 'ERROR'
AND SUBSTR(ITN.OBJECT_GID, 5, 3) IN ('3SV','3TJ','3MX','3GD','3EM','3MZ','MTY','MXC','GDL') 
AND ITM.INSERT_DATE BETWEEN TO_DATE('2025-12-25','YYYY-MM-DD') AND TO_DATE('2026-01-25','YYYY-MM-DD')



--AND ITM.INSERT_DATE > SYSDATE-1/24  

--AND ITN.TRANSACTION_CODE != 'D'
----------------------------------------------------------------------------------------------------------------
SELECT ORE.ORDER_RELEASE_GID, ED.EarlyDeliveryDate    
FROM ORDER_RELEASE ORE INNER JOIN
(
    SELECT OBJECT_GID, EarlyDeliveryDate
    FROM (
            SELECT  ITRAC.OBJECT_GID,
                    EXTRACTVALUE(XMLTYPE(REPLACE(REPLACE(ITRAC.XML_BLOB, 'otm:', ''), ' xmlns:otm="http://xmlns.oracle.com/apps/otm/transmission/v6.4" xmlns:gtm="http://xmlns.oracle.com/apps/gtm/transmission/v6.4"','')),
                    '/Release/TimeWindow/EarlyDeliveryDt/GLogDate') EarlyDeliveryDate
                    FROM I_TRANSMISSION ITMS INNER JOIN
                    I_TRANSACTION ITRAC ON ITMS.I_TRANSMISSION_NO = ITRAC.I_TRANSMISSION_NO
                    WHERE ITRAC.OBJECT_GID IN (
                            SELECT OBJECT_GID--, EarlyDeliveryDate, SUM(OBJECT_GID) AS RELEASE_COUNT
                            FROM (
                                    SELECT /*ITRAC.I_TRANSACTION_NO, ITRAC.I_TRANSMISSION_NO,*/ ITRAC.OBJECT_GID,
                                            EXTRACTVALUE(XMLTYPE(REPLACE(REPLACE(ITRAC.XML_BLOB, 'otm:', ''), ' xmlns:otm="http://xmlns.oracle.com/apps/otm/transmission/v6.4" xmlns:gtm="http://xmlns.oracle.com/apps/gtm/transmission/v6.4"','')),
                                            '/Release/TimeWindow/EarlyDeliveryDt/GLogDate') EarlyDeliveryDate
                                    FROM I_TRANSMISSION ITMS INNER JOIN
                                    I_TRANSACTION ITRAC ON ITMS.I_TRANSMISSION_NO = ITRAC.I_TRANSMISSION_NO
                                    WHERE ELEMENT_NAME = 'Release'
                                    AND ITMS.INSERT_DATE BETWEEN TO_DATE('2026-01-15','YYYY-MM-DD') AND TO_DATE('2026-02-05','YYYY-MM-DD')
                                    AND OBJECT_GID LIKE 'NBL/MX%'
                                    --AND ITRAC.OBJECT_GID = 'NBL/MX.41046979'
                                    AND ITRAC.TRANSACTION_CODE != 'D'
                                    AND ITMS.IS_INBOUND='Y' 
                            )
                            GROUP BY OBJECT_GID--, EarlyDeliveryDate
                            HAVING COUNT(*) > 1
            )
    )
    GROUP BY OBJECT_GID, EarlyDeliveryDate
) ED ON ORE.ORDER_RELEASE_GID = ED.OBJECT_GID INNER JOIN
ORDER_RELEASE_STATUS ORS ON ORE.ORDER_RELEASE_GID = ORS.ORDER_RELEASE_GID AND ORS.STATUS_TYPE_GID = 'NBL/MX.PLANNING' 
AND ORS.STATUS_VALUE_GID = 'NBL/MX.PLANNING_EXECUTED - FINAL'
WHERE 1 = 1
AND ORS.UPDATE_DATE
ORDER BY ORE.ORDER_RELEASE_GID, ED.EarlyDeliveryDate
;

--Obtener las transmisiones despues de la planeacion final





