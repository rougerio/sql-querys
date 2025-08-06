--BS_SHIPMENTS_NOT_ACCEPTED_MX
SELECT S.SHIPMENT_GID 
FROM SHIPMENT S inner join 
shipment_stop ss on s.shipment_gid = ss.shipment_gid and ss.stop_num = 1 inner join
location loc on loc.location_gid = ss.location_gid inner join 
time_zone tz on tz.time_zone_gid = loc.time_zone_gid
WHERE S.TRANSPORT_MODE_GID NOT IN ('NBL/MX.PICKUP') 
/*AND exists(
        select 1 
        from shipment_status ss 
        where SS.STATUS_TYPE_GID ='NBL/MX.DYNAMIC_ROUTING_VALID' 
        AND SS.STATUS_VALUE_GID='NBL/MX.DYNAMIC_ROUTING_VALID-NO' 
        AND S.SHIPMENT_GID=SS.SHIPMENT_GID) 
        */ 
AND exists(
        select 1 
        from shipment_status ss1 
        where S.SHIPMENT_GID=SS1.SHIPMENT_GID 
        and SS1.STATUS_TYPE_GID='NBL/MX.SECURE RESOURCES' 
        AND SS1.STATUS_VALUE_GID NOT IN ('NBL/MX.SECURE RESOURCES_ACCEPTED')
        ) 
--and s.start_Time > sysdate - 10
and UTC.GET_LOCAL_DATE(s.start_time, ss.location_gid) between CAST(from_tz(cast(sysdate + 1 as timestamp), 'UTC') at time zone tz.time_zone_xid AS date) and 
CAST(from_tz(cast(sysdate + 10 as timestamp), 'UTC') at time zone tz.time_zone_xid AS date)


select * 
from shipment_status ss1  
where SS1.SHIPMENT_GID= 'NBL/MX.MX51067858'
and SS1.STATUS_TYPE_GID='NBL/MX.SECURE RESOURCES'  
AND SS1.STATUS_VALUE_GID IN ('NBL/MX.SECURE RESOURCES_DECLINED', 'NBL/MX.SECURE RESOURCES_WITHDRAWN')


-------------Final Query-------------------
SELECT S.SHIPMENT_GID 
FROM SHIPMENT S inner join 
shipment_stop ss on s.shipment_gid = ss.shipment_gid and ss.stop_num = 1 inner join 
location loc on loc.location_gid = ss.location_gid inner join 
time_zone tz on tz.time_zone_gid = loc.time_zone_gid 
WHERE S.TRANSPORT_MODE_GID NOT IN ('NBL/MX.PICKUP')  
AND exists( 
        select 1  
        from shipment_status ss1  
        where S.SHIPMENT_GID = SS1.SHIPMENT_GID  
        and SS1.STATUS_TYPE_GID='NBL/MX.SECURE RESOURCES'  
        AND SS1.STATUS_VALUE_GID IN ('NBL/MX.SECURE RESOURCES_DECLINED', 'NBL/MX.SECURE RESOURCES_WITHDRAWN') 
        )  
and UTC.GET_LOCAL_DATE(s.start_time, ss.location_gid) between CAST(from_tz(cast(sysdate - 1 as timestamp), 'UTC') at time zone tz.time_zone_xid AS date) and  
CAST(from_tz(cast(sysdate + 20 as timestamp), 'UTC') at time zone tz.time_zone_xid AS date) 
AND S.DOMAIN_NAME = 'NBL/MX' 


--BS_TENDER_FAILED_TIMEOUT_MX
-----------------------------------------------------------------------------------------------------------
select s.shipment_gid 
from shipment s inner join 
shipment_stop ss on s.shipment_gid = ss.shipment_gid and ss.stop_num = 1 inner join 
location loc on loc.location_gid = ss.location_gid inner join 
time_zone tz on tz.time_zone_gid = loc.time_zone_gid 
where exists(
        select distinct 1 
        from tender_collaboration tc, tender_collaboration_status tcs 
        where tc.i_transaction_no = tcs.i_transaction_no 
        and tc.shipment_gid = s.shipment_gid 
        AND tcs.status_value_gid = 'NBL /MX .TENDER.SECURE RESOURCES_TENDERED'
        ) 
and exists(
        select 1 
        from shipment_status drg 
        where s.shipment_gid = drg.shipment_gid 
        and drg.status_type_gid = 'NBL /MX.SENT_TO_DR' 
        and drg.status_value_gid in ('NBL/MX.SENT_TO_DR_NOT_SENT_INVALID','NBL/MX.SENT_TO_DR_SENT','NBL/MX.SENT_TO_DR_CANCELLED') 
        ) 
and exists( 
        select 1 
        from shipment_status drg2 
        where s.shipment_gid = drg2.shipment_gid 
        and drg2.status_type_gid = 'NBL/MX.DYNAMIC_ROUTING_VALID' 
        and drg2.status_value_gid in ('NBL/MX.DYNAMIC_ROUTING_VALID-NA','NBL/MX.DYNAMIC_ROUTING_VALID-NO')
        ) 
--and s.start_time > (SYSDATE-3) 
--and s.start_time < (SYSDATE+10) 
and UTC.GET_LOCAL_DATE(s.start_time, ss.location_gid) between CAST(from_tz(cast(sysdate - 3 as timestamp), 'UTC') at time zone tz.time_zone_xid AS date) and  
CAST(from_tz(cast(sysdate + 10 as timestamp), 'UTC') at time zone tz.time_zone_xid AS date) 
AND S.DOMAIN_NAME = 'NBL/MX' 
AND S.user_defined1_icon_gid is null

-------------Final Query-------------------
select s.shipment_gid 
from shipment s inner join 
shipment_stop ss on s.shipment_gid = ss.shipment_gid and ss.stop_num = 1 inner join 
location loc on loc.location_gid = ss.location_gid inner join 
time_zone tz on tz.time_zone_gid = loc.time_zone_gid 
where exists( 
        select 1  
        from shipment_status ss1  
        where S.SHIPMENT_GID = SS1.SHIPMENT_GID  
        and SS1.STATUS_TYPE_GID='NBL/MX.SECURE RESOURCES'  
        AND SS1.STATUS_VALUE_GID IN ('NBL/MX.SECURE RESOURCES_NO RESPONSE', 'NBL/MX.SECURE RESOURCES_NO RESOURCES')  
        )  
and UTC.GET_LOCAL_DATE(s.start_time, ss.location_gid) between CAST(from_tz(cast(sysdate - 3 as timestamp), 'UTC') at time zone tz.time_zone_xid AS date) and  
CAST(from_tz(cast(sysdate + 10 as timestamp), 'UTC') at time zone tz.time_zone_xid AS date)  
AND S.DOMAIN_NAME = 'NBL/MX' 
--AND S.user_defined1_icon_gid is null


select * 
from tender_collaboration tc, tender_collaboration_status tcs 
where tc.i_transaction_no = tcs.i_transaction_no 
and tc.shipment_gid = 'NBL/MX.MX51068067'
--and tcs.status_value_gid = 'NBL/MX.TENDER SECURE RESOURCES_TENDERED'
and tc.domain_name = 'NBL/MX'



--BS_NOT_TENDERED_MX
------------------------------------------------------------------------------------------------------------
select s.shipment_gid 
from shipment s 
where exists(
                select 1 
                from TENDER_COLLABORATION tc, TENDER_COLLABORATION_STATUS tcs, TENDER_COLLAB_SERVPROV tcc 
                where tc.i_transaction_no = tcs.i_transaction_no 
                and tc.i_transaction_no = tcc.i_transaction_no 
                and tc.shipment_gid = s.shipment_gid 
                and tcs.status_value_gid not in ('NBL/MX.TENDER.SECURE RESOURCES_DECLINED','NBL/MX.TENDER.SECURE RESOURCES_WITHDRAWN','NBL/MX.TENDER.SECURE RESOURCES_TIMED OUT','NBL/MX.TENDER.SECURE RESOURCES_ACCEPTED') 
                and TCC.SERVPROV_GID = S.SERVPROV_GID 
                and TC.RATE_GEO_GID != 'NBL/MX.DYNAMICROUTING_RR' 
                and rownum = 1
            ) 
AND exists(
                select 1 
                from shipment_status drg 
                where s.shipment_gid = drg.shipment_gid 
                and drg.status_value_gid in ('NBL/MX.SENT_TO_DR_NOT_SENT_INVALID','NBL/MX.SENT_TO_DR_SENT','NBL/MX.SENT_TO_DR_CANCELLED') 
                and drg.status_type_gid = 'NBL/MX.SENT_TO_DR' 
            ) 
and exists(
                select 1 
                from shipment_status drg2 
                where s.shipment_gid = drg2.shipment_gid 
                and drg2.status_type_gid = 'NBL/MX.DYNAMIC_ROUTING_STATUS' 
                and drg2.status_value_gid != 'NBL/MX.DYNAMIC_ROUTING_STATUS_CAPACITY_AVAILABLE'
            ) 
and S.USER_DEFINED1_ICON_GID IS NULL 
and (s.start_time between (SYSDATE-1) and (SYSDATE+20))

--------------Final Query-------------------
select s.shipment_gid 
from shipment s inner join 
shipment_stop ss on s.shipment_gid = ss.shipment_gid and ss.stop_num = 1 inner join 
location loc on loc.location_gid = ss.location_gid inner join 
time_zone tz on tz.time_zone_gid = loc.time_zone_gid 
where exists(  
        select 1  
        from shipment_status ss1  
        where S.SHIPMENT_GID = SS1.SHIPMENT_GID  
        and SS1.STATUS_TYPE_GID='NBL/MX.SECURE RESOURCES'  
        AND SS1.STATUS_VALUE_GID IN ('NBL/MX.SECURE RESOURCES_NOT STARTED')  
        )  
and UTC.GET_LOCAL_DATE(s.start_time, ss.location_gid) between CAST(from_tz(cast(sysdate - 1 as timestamp), 'UTC') at time zone tz.time_zone_xid AS date) and  
CAST(from_tz(cast(sysdate + 20 as timestamp), 'UTC') at time zone tz.time_zone_xid AS date)  
AND S.DOMAIN_NAME = 'NBL/MX'  
--and S.USER_DEFINED1_ICON_GID IS NULL

--MXC
--BS_NOT_TENDERED_MXC-MX
select s.shipment_gid 
from shipment s inner join 
shipment_stop ss on s.shipment_gid = ss.shipment_gid and ss.stop_num = 1 inner join 
location loc on loc.location_gid = ss.location_gid inner join 
location_refnum lr on lr.location_gid = loc.location_gid and lr.location_refnum_qual_gid = 'ORGID' inner join 
time_zone tz on tz.time_zone_gid = loc.time_zone_gid 
where exists(  
        select 1  
        from shipment_status ss1  
        where S.SHIPMENT_GID = SS1.SHIPMENT_GID  
        and SS1.STATUS_TYPE_GID='NBL/MX.SECURE RESOURCES'  
        AND SS1.STATUS_VALUE_GID IN ('NBL/MX.SECURE RESOURCES_NOT STARTED')  
        )  
and UTC.GET_LOCAL_DATE(s.start_time, ss.location_gid) between CAST(from_tz(cast(sysdate - 1 as timestamp), 'UTC') at time zone tz.time_zone_xid AS date) and  
CAST(from_tz(cast(sysdate + 20 as timestamp), 'UTC') at time zone tz.time_zone_xid AS date)  
AND S.DOMAIN_NAME = 'NBL/MX'  
and lr.location_refnum_value in ('MXC','3EM')  

--MTY
--BS_NOT_TENDERED_MTY-MX
select s.shipment_gid 
from shipment s inner join 
shipment_stop ss on s.shipment_gid = ss.shipment_gid and ss.stop_num = 1 inner join 
location loc on loc.location_gid = ss.location_gid inner join 
location_refnum lr on lr.location_gid = loc.location_gid and lr.location_refnum_qual_gid = 'ORGID' inner join 
time_zone tz on tz.time_zone_gid = loc.time_zone_gid 
where exists(  
        select 1  
        from shipment_status ss1  
        where S.SHIPMENT_GID = SS1.SHIPMENT_GID  
        and SS1.STATUS_TYPE_GID='NBL/MX.SECURE RESOURCES'  
        AND SS1.STATUS_VALUE_GID IN ('NBL/MX.SECURE RESOURCES_NOT STARTED')  
        )  
and UTC.GET_LOCAL_DATE(s.start_time, ss.location_gid) between CAST(from_tz(cast(sysdate - 1 as timestamp), 'UTC') at time zone tz.time_zone_xid AS date) and  
CAST(from_tz(cast(sysdate + 20 as timestamp), 'UTC') at time zone tz.time_zone_xid AS date)  
AND S.DOMAIN_NAME = 'NBL/MX'  
and lr.location_refnum_value in ('MTY','3MZ', '3SV')  

--GDL
--BS_NOT_TENDERED_GDL-MX
select s.shipment_gid 
from shipment s inner join 
shipment_stop ss on s.shipment_gid = ss.shipment_gid and ss.stop_num = 1 inner join 
location loc on loc.location_gid = ss.location_gid inner join 
location_refnum lr on lr.location_gid = loc.location_gid and lr.location_refnum_qual_gid = 'ORGID' inner join 
time_zone tz on tz.time_zone_gid = loc.time_zone_gid 
where exists(  
        select 1  
        from shipment_status ss1  
        where S.SHIPMENT_GID = SS1.SHIPMENT_GID  
        and SS1.STATUS_TYPE_GID='NBL/MX.SECURE RESOURCES'  
        AND SS1.STATUS_VALUE_GID IN ('NBL/MX.SECURE RESOURCES_NOT STARTED')  
        )  
and UTC.GET_LOCAL_DATE(s.start_time, ss.location_gid) between CAST(from_tz(cast(sysdate - 1 as timestamp), 'UTC') at time zone tz.time_zone_xid AS date) and  
CAST(from_tz(cast(sysdate + 20 as timestamp), 'UTC') at time zone tz.time_zone_xid AS date)  
AND S.DOMAIN_NAME = 'NBL/MX'  
and lr.location_refnum_value in ('GDL','3GD')  

--3MX
--BS_NOT_TENDERED_3MX-MX
select s.shipment_gid 
from shipment s inner join 
shipment_stop ss on s.shipment_gid = ss.shipment_gid and ss.stop_num = 1 inner join 
location loc on loc.location_gid = ss.location_gid inner join 
location_refnum lr on lr.location_gid = loc.location_gid and lr.location_refnum_qual_gid = 'ORGID' inner join 
time_zone tz on tz.time_zone_gid = loc.time_zone_gid 
where exists(  
        select 1  
        from shipment_status ss1  
        where S.SHIPMENT_GID = SS1.SHIPMENT_GID  
        and SS1.STATUS_TYPE_GID='NBL/MX.SECURE RESOURCES'  
        AND SS1.STATUS_VALUE_GID IN ('NBL/MX.SECURE RESOURCES_NOT STARTED')  
        )  
and UTC.GET_LOCAL_DATE(s.start_time, ss.location_gid) between CAST(from_tz(cast(sysdate - 1 as timestamp), 'UTC') at time zone tz.time_zone_xid AS date) and  
CAST(from_tz(cast(sysdate + 20 as timestamp), 'UTC') at time zone tz.time_zone_xid AS date)  
AND S.DOMAIN_NAME = 'NBL/MX'  
and lr.location_refnum_value in ('3MX')  

--3TJ
--BS_NOT_TENDERED_3TJ-MX
select s.shipment_gid 
from shipment s inner join 
shipment_stop ss on s.shipment_gid = ss.shipment_gid and ss.stop_num = 1 inner join 
location loc on loc.location_gid = ss.location_gid inner join 
location_refnum lr on lr.location_gid = loc.location_gid and lr.location_refnum_qual_gid = 'ORGID' inner join 
time_zone tz on tz.time_zone_gid = loc.time_zone_gid 
where exists(  
        select 1  
        from shipment_status ss1  
        where S.SHIPMENT_GID = SS1.SHIPMENT_GID  
        and SS1.STATUS_TYPE_GID='NBL/MX.SECURE RESOURCES'  
        AND SS1.STATUS_VALUE_GID IN ('NBL/MX.SECURE RESOURCES_NOT STARTED')  
        )  
and UTC.GET_LOCAL_DATE(s.start_time, ss.location_gid) between CAST(from_tz(cast(sysdate - 1 as timestamp), 'UTC') at time zone tz.time_zone_xid AS date) and  
CAST(from_tz(cast(sysdate + 20 as timestamp), 'UTC') at time zone tz.time_zone_xid AS date)  
AND S.DOMAIN_NAME = 'NBL/MX'  
and lr.location_refnum_value in ('3TJ')  


--BS_ACTUAL_VS_TENDERED_MX
------------------------------------------------------------------------------------------------------------
select s.shipment_gid  
from shipment s   
where exists(
                select distinct 1 
                from tender_collaboration tc, tender_collaboration_status tcs, TENDER_COLLAB_SERVPROV tcc 
                where tc.i_transaction_no = tcs.i_transaction_no 
                and tc.i_transaction_no = tcc.i_transaction_no 
                and tc.shipment_gid = s.shipment_gid 
                AND tcs.status_value_gid = 'NBL/MX.TENDER.SECURE RESOURCES_ACCEPTED' 
                AND TCC.SERVPROV_GID <> S.SERVPROV_GID
        )
and exists(
                select 1 
                from shipment_status drg 
                where s.shipment_gid = drg.shipment_gid 
                and drg.status_type_gid = 'NBL/MX.SENT_TO_DR'
                and drg.status_value_gid in ('NBL/MX.SENT_TO_DR_NOT_SENT_INVALID','NBL/MX.SENT_TO_DR_SENT','NBL/MX.SENT_TO_DR_CANCELLED')
        )  
and exists(
                select 1 
                from shipment_status drg2 
                where  s.shipment_gid = drg2.shipment_gid
                and drg2.status_type_gid = 'NBL/MX.DYNAMIC_ROUTING_VALID'
                and drg2.status_value_gid in ('NBL/MX.DYNAMIC_ROUTING_VALID-NA','NBL/MX.DYNAMIC_ROUTING_VALID-NO')
        )
and s.start_time > (SYSDATE-2)
and s.start_time < (SYSDATE+20)
AND S.DOMAIN_NAME = 'NBL'
AND S.user_defined1_icon_gid is null

--------------Final Query-------------------
select s.shipment_gid 
from shipment s inner join 
shipment_stop ss on s.shipment_gid = ss.shipment_gid and ss.stop_num = 1 inner join 
location loc on loc.location_gid = ss.location_gid inner join 
time_zone tz on tz.time_zone_gid = loc.time_zone_gid 
where exists( 
                select distinct 1 
                from tender_collaboration tc, tender_collaboration_status tcs, TENDER_COLLAB_SERVPROV tcc 
                where tc.i_transaction_no = tcs.i_transaction_no 
                and tc.i_transaction_no = tcc.i_transaction_no 
                and tc.shipment_gid = s.shipment_gid 
                AND tcs.status_value_gid = 'NBL/MX.TENDER.SECURE RESOURCES_ACCEPTED' 
                AND TCC.SERVPROV_GID <> S.PLANNED_SERVPROV_GID 
        ) 
and UTC.GET_LOCAL_DATE(s.start_time, ss.location_gid) between CAST(from_tz(cast(sysdate - 2 as timestamp), 'UTC') at time zone tz.time_zone_xid AS date) and  
CAST(from_tz(cast(sysdate + 20 as timestamp), 'UTC') at time zone tz.time_zone_xid AS date)  
AND S.DOMAIN_NAME = 'NBL/MX'


select distinct 1 
from tender_collaboration tc, tender_collaboration_status tcs, TENDER_COLLAB_SERVPROV tcc, shipment s
where tc.i_transaction_no = tcs.i_transaction_no 
and tc.i_transaction_no = tcc.i_transaction_no 
and tc.shipment_gid = s.shipment_gid 
AND tcs.status_value_gid = 'NBL/MX.TENDER.SECURE RESOURCES_ACCEPTED' 
AND TCC.SERVPROV_GID <> S.SERVPROV_GID



--BS_SHIPMENTS_NO_APPOINTMENT_MX
------------------------------------------------------------------------------------------------------------
select shipment_gid 
from shipment s 
where exists(
                select 1 
                from shipment_stop ss 
                where ss.shipment_gid = s.shipment_gid 
                and stop_num = 1 
                and APPOINTMENT_PICKUP is null
        ) 
and s.start_time between sysdate and sysdate + 3 
and exists(
                select 1 
                from shipment_status ss 
                where ss.shipment_gid = s.shipment_gid 
                and ss.status_type_gid = 'NBL/MX.SHIPMENT_SENT_TO_FK_AM' 
                and ss.status_value_gid in ('NBL/MX.SHIPMENT_NOT_SENT_TO_FK_AM','NBL/MX.APPOINTMENT_AUTO_SCHEDULE_FAILED')
        )


--------------Final Query-------------------
select s.shipment_gid 
from shipment s inner join 
shipment_stop ss on s.shipment_gid = ss.shipment_gid and ss.stop_num = 1 inner join 
location loc on loc.location_gid = ss.location_gid inner join 
time_zone tz on tz.time_zone_gid = loc.time_zone_gid 
where exists( 
                select 1 
                from shipment_stop ss 
                where ss.shipment_gid = s.shipment_gid 
                and stop_num = 1 
                and APPOINTMENT_PICKUP is null 
        )  
and exists( 
                select 1  
                from shipment_status ss 
                where ss.shipment_gid = s.shipment_gid 
                and ss.status_type_gid = 'NBL/MX.SHIPMENT_SENT_TO_FK_AM'  
                and ss.status_value_gid in ('NBL/MX.SHIPMENT_NOT_SENT_TO_FK_AM','NBL/MX.APPOINTMENT_AUTO_SCHEDULE_FAILED') 
        ) 
and UTC.GET_LOCAL_DATE(s.start_time, ss.location_gid) between CAST(from_tz(cast(sysdate as timestamp), 'UTC') at time zone tz.time_zone_xid AS date) and  
CAST(from_tz(cast(sysdate + 20 as timestamp), 'UTC') at time zone tz.time_zone_xid AS date)  
and s.domain_name = 'NBL/MX'


----BS_MISSED_PICKUPS_MX
select s.shipment_gid 
from shipment s inner join 
shipment_stop ss on s.shipment_gid = ss.shipment_gid and ss.stop_num = 1 inner join 
location loc on loc.location_gid = ss.location_gid inner join 
time_zone tz on tz.time_zone_gid = loc.time_zone_gid 
where (s.user_defined1_icon_gid IS NULL OR s.user_defined1_icon_gid <> 'NBL.SHIP_CONFIRMED') 
and not exists ( select 1 
                from shipment_remark sr 
                where sr.shipment_gid = s.shipment_gid 
                and remark_qual_gid = 'NBL.SHIP_DATE'
                ) 
and UTC.GET_LOCAL_DATE(s.start_time, ss.location_gid) > CAST(from_tz(cast(sysdate - 48/24 as timestamp), 'UTC') at time zone tz.time_zone_xid AS date) 
and UTC.GET_LOCAL_DATE(s.start_time, ss.location_gid) < CAST(from_tz(cast(sysdate as timestamp), 'UTC') at time zone tz.time_zone_xid AS date) 
and s.domain_name = 'NBL/MX'

--------------Final Querys-----------------
--MXC
select s.shipment_gid 
from shipment s inner join 
shipment_stop ss on s.shipment_gid = ss.shipment_gid and ss.stop_num = 1 inner join 
location loc on loc.location_gid = ss.location_gid inner join 
location_refnum lr on lr.location_gid = loc.location_gid and lr.location_refnum_qual_gid = 'ORGID' inner join 
time_zone tz on tz.time_zone_gid = loc.time_zone_gid 
where (s.user_defined1_icon_gid IS NULL OR s.user_defined1_icon_gid <> 'NBL.SHIP_CONFIRMED') 
and not exists ( select 1 
                from shipment_remark sr 
                where sr.shipment_gid = s.shipment_gid 
                and remark_qual_gid = 'NBL.SHIP_DATE'
                ) 
and UTC.GET_LOCAL_DATE(s.start_time, ss.location_gid) > CAST(from_tz(cast(sysdate - 48/24 as timestamp), 'UTC') at time zone tz.time_zone_xid AS date) 
and UTC.GET_LOCAL_DATE(s.start_time, ss.location_gid) < CAST(from_tz(cast(sysdate as timestamp), 'UTC') at time zone tz.time_zone_xid AS date) 
and lr.location_refnum_value in ('MXC','3EM') 

--MTY
select s.shipment_gid 
from shipment s inner join 
shipment_stop ss on s.shipment_gid = ss.shipment_gid and ss.stop_num = 1 inner join 
location loc on loc.location_gid = ss.location_gid inner join 
location_refnum lr on lr.location_gid = loc.location_gid and lr.location_refnum_qual_gid = 'ORGID' inner join 
time_zone tz on tz.time_zone_gid = loc.time_zone_gid 
where (s.user_defined1_icon_gid IS NULL OR s.user_defined1_icon_gid <> 'NBL.SHIP_CONFIRMED') 
and not exists (select 1 
                from shipment_remark sr 
                where sr.shipment_gid = s.shipment_gid 
                and remark_qual_gid = 'NBL.SHIP_DATE'
                ) 
and UTC.GET_LOCAL_DATE(s.start_time, ss.location_gid) > CAST(from_tz(cast(sysdate - 48/24 as timestamp), 'UTC') at time zone tz.time_zone_xid AS date) 
and UTC.GET_LOCAL_DATE(s.start_time, ss.location_gid) < CAST(from_tz(cast(sysdate as timestamp), 'UTC') at time zone tz.time_zone_xid AS date) 
and lr.location_refnum_value in ('MTY','3MZ', '3SV') 

--GDL
select s.shipment_gid 
from shipment s inner join 
shipment_stop ss on s.shipment_gid = ss.shipment_gid and ss.stop_num = 1 inner join 
location loc on loc.location_gid = ss.location_gid inner join 
location_refnum lr on lr.location_gid = loc.location_gid and lr.location_refnum_qual_gid = 'ORGID' inner join 
time_zone tz on tz.time_zone_gid = loc.time_zone_gid 
where (s.user_defined1_icon_gid IS NULL OR s.user_defined1_icon_gid <> 'NBL.SHIP_CONFIRMED') 
and not exists ( select 1 
                from shipment_remark sr 
                where sr.shipment_gid = s.shipment_gid 
                and remark_qual_gid = 'NBL.SHIP_DATE'
                ) 
and UTC.GET_LOCAL_DATE(s.start_time, ss.location_gid) > CAST(from_tz(cast(sysdate - 48/24 as timestamp), 'UTC') at time zone tz.time_zone_xid AS date) 
and UTC.GET_LOCAL_DATE(s.start_time, ss.location_gid) < CAST(from_tz(cast(sysdate as timestamp), 'UTC') at time zone tz.time_zone_xid AS date) 
and lr.location_refnum_value in ('GDL','3GD') 

--3MX
select s.shipment_gid 
from shipment s inner join 
shipment_stop ss on s.shipment_gid = ss.shipment_gid and ss.stop_num = 1 inner join 
location loc on loc.location_gid = ss.location_gid inner join 
location_refnum lr on lr.location_gid = loc.location_gid and lr.location_refnum_qual_gid = 'ORGID' inner join 
time_zone tz on tz.time_zone_gid = loc.time_zone_gid 
where (s.user_defined1_icon_gid IS NULL OR s.user_defined1_icon_gid <> 'NBL.SHIP_CONFIRMED') 
and not exists ( select 1 
                from shipment_remark sr 
                where sr.shipment_gid = s.shipment_gid 
                and remark_qual_gid = 'NBL.SHIP_DATE'
                ) 
and UTC.GET_LOCAL_DATE(s.start_time, ss.location_gid) > CAST(from_tz(cast(sysdate - 48/24 as timestamp), 'UTC') at time zone tz.time_zone_xid AS date) 
and UTC.GET_LOCAL_DATE(s.start_time, ss.location_gid) < CAST(from_tz(cast(sysdate as timestamp), 'UTC') at time zone tz.time_zone_xid AS date) 
and lr.location_refnum_value in ('3MX') 

--3TJ
select s.shipment_gid 
from shipment s inner join 
shipment_stop ss on s.shipment_gid = ss.shipment_gid and ss.stop_num = 1 inner join 
location loc on loc.location_gid = ss.location_gid inner join 
location_refnum lr on lr.location_gid = loc.location_gid and lr.location_refnum_qual_gid = 'ORGID' inner join 
time_zone tz on tz.time_zone_gid = loc.time_zone_gid 
where (s.user_defined1_icon_gid IS NULL OR s.user_defined1_icon_gid <> 'NBL.SHIP_CONFIRMED') 
and not exists ( select 1 
                from shipment_remark sr 
                where sr.shipment_gid = s.shipment_gid 
                and remark_qual_gid = 'NBL.SHIP_DATE'
                ) 
and UTC.GET_LOCAL_DATE(s.start_time, ss.location_gid) > CAST(from_tz(cast(sysdate - 48/24 as timestamp), 'UTC') at time zone tz.time_zone_xid AS date) 
and UTC.GET_LOCAL_DATE(s.start_time, ss.location_gid) < CAST(from_tz(cast(sysdate as timestamp), 'UTC') at time zone tz.time_zone_xid AS date) 
and lr.location_refnum_value in ('3TJ') 

--BS_MISSED_PICKUPS_MX
--Querys
/*
BS_MISSED_PICKUPS_MXC_MX

BS_MISSED_PICKUPS_MTY_MX

BS_MISSED_PICKUPS_GDL_MX

BS_MISSED_PICKUPS_3MX_MX

BS_MISSED_PICKUPS_3TJ_MX

WB3-TRANSPORTATION_MX
/*
TIMEOUT:

SECURE RESOURCES_NO RESPONSE
SECURE RESOURCES_NO RESOURCES

NOT TENDERED:
SECURE RESOURCES_NOT STARTED

DECLINED:
SECURE RESOURCES_DECLINED
SECURE RESOURCES_WITHDRAWN

TENDERED/pending:
SECURE RESOURCES_TENDERED

ACEPTADO:
SECURE RESOURCES_ACCEPTED
*/


--------Saved Querys------------
/*
BS_ACTUAL_VS_TENDERED-MX - ok
BS_NOT_TENDERED-MX - Ok
BS_TENDER_FAILED_TIMEOUT-MX - Ok
BS_SHIPMENTS_NOT_ACCEPTED-MX - Ok
BS_SHIPMENTS_NO_APPOINTMENT-MX - OK
*/



/*
BS_ACTUAL_VS_TENDERED-MX
Embarques donde el carrier actual es distinto al carrier que acepto el tender

BS_NOT_TENDERED-MX
No se ha enviado la oferta al carrier

BS_TENDER_FAILED_TIMEOUT-MX
Ofertas sin respuesta

BS_SHIPMENTS_NOT_ACCEPTED-MX
Embarque no aceptados por el carrier o con oferta retirada

BS_MISSED_PICKUPS_MX
Embarque que su fecha de pick up es anterior a la fecha y hora actual

BS_SHIPMENTS_NO_APPOINTMENT-MX
Embarques que no tienen Pickup appointment

*/


rnolasco@niagarawater.com
mariflores@niagarawater.com

BS_NOT_TENDERED

BUY_SHIPMENT_CUSTOMER_LOGISTICS_SUPERVISOR_MX_1

WB3-TRANSPORTATION_MX