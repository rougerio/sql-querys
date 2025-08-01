select COUNT(distinct sh.shipment_gid )
from location_profile_detail lpd, 
shipment sh 
where sh.source_location_gid = lpd.location_profile_gid 
and (sh.servprov_gid = lpd.location_gid or sh.dest_location_gid=lpd.location_gid);
 
--Hacer Join con Shipment Stop para buscar la ubicacion

SELECT SH.SHIPMENT_GID 
FROM LOCATION_PROFILE LP , 
LOCATION_PROFILE_DETAIL LPD , 
SHIPMENT SH, 
SHIPMENT_STOP SS
WHERE LP.LOCATION_PROFILE_GID = LPD.LOCATION_PROFILE_GID 
AND SH.SHIPMENT_GID = SS.SHIPMENT_GID 
AND LP.LOCATION_PROFILE_GID = SH.SOURCE_LOCATION_GID||'_TRANSFER'
AND SS.STOP_NUM = 2 
AND (SH.SERVPROV_GID = LPD.LOCATION_GID OR SS.LOCATION_GID = LPD.LOCATION_GID );



SELECT COUNT(SHIPMENT_GID)
FROM (
        SELECT SH.SHIPMENT_GID
        FROM LOCATION_PROFILE_DETAIL LPD , 
        SHIPMENT SH, 
        SHIPMENT_STOP SS
        WHERE SH.SHIPMENT_GID = SS.SHIPMENT_GID 
        AND SS.STOP_NUM = 2 
        AND (SH.SERVPROV_GID = LPD.LOCATION_GID OR SS.LOCATION_GID = LPD.LOCATION_GID )
        GROUP BY SH.SHIPMENT_GID
);
 
  
 select count(distinct sh.shipment_gid) 
 from location_profile_detail lpd, 
 shipment sh 
 where sh.source_location_gid = lpd.location_profile_gid 
 and (sh.servprov_gid = lpd.location_gid or (lpd.location_gid in (select ss.location_gid from shipment_stop ss where sh.shipment_gid = ss.shipment_gid and ss.stop_num = 2)));
 
SELECT COUNT(SHIPMENT_GID)
FROM (
 SELECT SH.SHIPMENT_GID, SS.SHIPMENT_GID
 FROM LOCATION_PROFILE_DETAIL LPD LEFT JOIN
 SHIPMENT SH ON SH.SERVPROV_GID = LPD.LOCATION_GID 
 GROUP BY SH.SHIPMENT_GID
 );
 
SELECT COUNT(SHIPMENT_GID)
FROM (
 SELECT (SS.SHIPMENT_GID)
 FROM LOCATION_PROFILE_DETAIL LPD INNER JOIN
 SHIPMENT_STOP SS ON SS.LOCATION_GID = LPD.LOCATION_GID AND SS.STOP_NUM = 2
 GROUP BY SS.SHIPMENT_GID
 );
 
 SELECT 1492867+340464 FROM DUAL;
 
 
SELECT COUNT(SHIPMENT_GID)
FROM (
 SELECT LPD.*, LPD2.*--SH.SHIPMENT_GID
 FROM  SHIPMENT SH INNER JOIN
 SHIPMENT_STOP SS ON SH.SHIPMENT_GID = SS.SHIPMENT_GID INNER JOIN
 LOCATION_PROFILE_DETAIL LPD ON SS.LOCATION_GID = LPD.LOCATION_GID AND SS.STOP_NUM = 2 INNER JOIN
 LOCATION_PROFILE_DETAIL LPD2 ON SH.SERVPROV_GID = LPD2.LOCATION_GID
 GROUP BY SH.SHIPMENT_GID
 );
 
SELECT COUNT(SHIPMENT_GID)
FROM (
 SELECT SH.SHIPMENT_GID
 FROM  SHIPMENT SH INNER JOIN
 SHIPMENT_STOP SS ON SH.SHIPMENT_GID = SS.SHIPMENT_GID INNER JOIN
 LOCATION_PROFILE_DETAIL LPD ON SS.LOCATION_GID = LPD.LOCATION_GID AND SS.STOP_NUM = 2 OR SH.SERVPROV_GID = LPD.LOCATION_GID
 GROUP BY SH.SHIPMENT_GID
 );
 
 -- 1,833,331
 
 --1,698,101
 
 
 SELECT *
 FROM location_profile_detail;
 
 
 
 
SELECT * --RATE_DISTANCE_GID
FROM DISTANCE_BY_ADDRESSES
WHERE DOMAIN_NAME = 'NBL';

SELECT * FROM DISTANCE_LOOKUP
WHERE DOMAIN_NAME = 'NBL/MX';