--Querys for BM Missed Pickups


select s.shipment_gid, 
TO_CHAR(FROM_TZ(CAST(s.start_time AS TIMESTAMP), 'UTC') AT TIME ZONE 'America/Mexico_City') AS converted_time
from shipment s 
where user_defined1_icon_gid <> 'NBL.SHIP_CONFIRMED' 
and not exists (
                select 1 
                from shipment_remark sr 
                where sr.shipment_gid = s.shipment_gid 
                and remark_qual_gid = 'NBL.SHIP_DATE') 
--and s.start_time > sysdate - 0.5/24 
and domain_name = 'NBL/MX'
ORDER BY s.shipment_gid DESC


FROM_TZ(CAST(SYSDATE AS TIMESTAMP), 'UTC') AT TIME ZONE 'America/Mexico_City' AS converted_time FROM DUAL;


SELECT CAST(START_DATE AS TIMESTAMP WITH TIME ZONE) AT TIME ZONE 'US/Eastern' AS converted_start_date FROM TABLE_NAME;



select s.shipment_gid, s.user_defined1_icon_gid,s.start_time,
CAST(UTC.GET_LOCAL_DATE(s.start_time, ss.location_gid) AS timestamp) local_start_time,
CAST(from_tz(cast(sysdate - 24/24 as timestamp), 'UTC') at time zone tz.time_zone_xid as date) local_actual_time
from shipment s inner join
shipment_stop ss on s.shipment_gid = ss.shipment_gid and ss.stop_num = 1 inner join
location loc on loc.location_gid = ss.location_gid inner join 
time_zone tz on tz.time_zone_gid = loc.time_zone_gid
where 1 = 1
and (s.user_defined1_icon_gid IS NULL OR s.user_defined1_icon_gid <> 'NBL.SHIP_CONFIRMED')
and not exists ( select 1 from shipment_remark sr where sr.shipment_gid = s.shipment_gid and remark_qual_gid = 'NBL.SHIP_DATE') 
and UTC.GET_LOCAL_DATE(s.start_time, ss.location_gid) > CAST(from_tz(cast(sysdate - 24/24 as timestamp), 'UTC') at time zone tz.time_zone_xid AS date)
and UTC.GET_LOCAL_DATE(s.start_time, ss.location_gid) < CAST(from_tz(cast(sysdate as timestamp), 'UTC') at time zone tz.time_zone_xid AS date)
and s.domain_name = 'NBL/MX'
ORDER BY s.shipment_gid DESC

and s.shipment_xid = 'MX51065887'


AND UTC.GET_LOCAL_DATE(orl.early_delivery_date, orl.dest_location_gid) >= FROM_TZ(CAST(SYSDATE +48/24 AS TIMESTAMP), 'UTC') AT TIME ZONE tz.TIME_ZONE_XID 
AND UTC.GET_LOCAL_DATE(orl.early_delivery_date, orl.dest_location_gid) <= FROM_TZ(CAST(SYSDATE +5-0.000012 AS TIMESTAMP), 'UTC') AT TIME ZONE tz.TIME_ZONE_XID 





select s.shipment_gid 
from shipment s inner join 
shipment_stop ss on s.shipment_gid = ss.shipment_gid and ss.stop_num = 1 inner join 
location loc on loc.location_gid = ss.location_gid inner join  
time_zone tz on tz.time_zone_gid = loc.time_zone_gid 
where (s.user_defined1_icon_gid IS NULL OR s.user_defined1_icon_gid <> 'NBL.SHIP_CONFIRMED') 
and not exists ( select 1 from shipment_remark sr where sr.shipment_gid = s.shipment_gid and remark_qual_gid = 'NBL.SHIP_DATE')  
and UTC.GET_LOCAL_DATE(s.start_time, ss.location_gid) > CAST(from_tz(cast(sysdate - 24/24 as timestamp), 'UTC') at time zone tz.time_zone_xid AS date) 
and UTC.GET_LOCAL_DATE(s.start_time, ss.location_gid) < CAST(from_tz(cast(sysdate as timestamp), 'UTC') at time zone tz.time_zone_xid AS date) 
and s.domain_name = 'NBL/MX' 


BS_MISSED_PICKUPS_MX