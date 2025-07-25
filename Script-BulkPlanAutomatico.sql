ALTER SESSION SET NLS_DATE_FORMAT = 'dd/mm/yyyy hh24:mi:ss';
SELECT ORR.* 
FROM ORDER_RELEASE ORR INNER JOIN 
     ORDER_RELEASE_STATUS ORS ON ORR.ORDER_RELEASE_GID = ORS.ORDER_RELEASE_GID 
WHERE ORS.STATUS_TYPE_GID = 'NBL/MX.PLANNING' 
--AND ORS.STATUS_VALUE_GID = 'NBL/MX.PLANNING_NEW' 
AND ORR.DOMAIN_NAME = 'NBL/MX' 
AND ORR.DELIVERY_IS_APPT  = 'Y' 
AND ORR.EARLY_DELIVERY_DATE = ORR.LATE_DELIVERY_DATE 
AND ORR.EARLY_DELIVERY_DATE BETWEEN SYSDATE - 7 AND SYSDATE + 15 
AND ORR.DEST_LOCATION_GID IN ( 
                              SELECT LOCATION_GID 
                              FROM REGION_DETAIL 
                              WHERE REGION_GID IN ('NBL/MX.MXC CANCUN','NBL/MX.MXC VILLAHERMOSA', 
                              'NBL/MX.MXC MERIDA','NBL/MX.MXC PUEBLA','NBL/MX.MXC VERACRUZ')  
                         )
AND ORR.ORDER_RELEASE_XID IN ('35774172','35774173','35774174','35829974','35829975','35829992','35830009','35830011')
ORDER BY ORR.ORDER_RELEASE_GID;


SELECT *
FROM ORDER_RELEASE_REFNUM
WHERE ORDER_RELEASE_GID IN ('NBL/MX.35774172','NBL/MX.35774173','NBL/MX.35774174','NBL/MX.35829974','NBL/MX.35829975','NBL/MX.35829992','NBL/MX.35830009','NBL/MX.35830011')
AND ORDER_RELEASE_REFNUM_QUAL_GID = 'NBL.REF_VALUE';

