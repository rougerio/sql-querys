SELECT orl.order_release_gid, loc.time_zone_gid, orl.early_delivery_date, 
UTC.GET_LOCAL_DATE(orl.early_delivery_date, orl.dest_location_gid) local_date,
FROM_TZ(CAST(SYSDATE +48/24 AS TIMESTAMP), 'UTC') AT TIME ZONE tz.TIME_ZONE_XID AS local_time,
CAST(FROM_TZ(CAST(SYSDATE +48/24 AS TIMESTAMP), 'UTC') AT TIME ZONE tz.TIME_ZONE_XID AS DATE) sys_local_date
FROM order_release orl, order_release_status ors, location loc, time_zone tz 
WHERE orl.ORDER_RELEASE_TYPE_GID <> 'NBL.TONU' 
AND orl.PAYMENT_METHOD_CODE_GID IN ('NBL.DELIVERY','NBL.PAID') 
and orl.dest_location_gid LIKE 'NBL.CUS%' 
AND orl.source_location_gid IN (
                                    select lpd.location_gid 
                                    from location_profile_detail lpd 
                                    where lpd.location_profile_gid='NBL.DF_ENGA' 
                                    and lpd.location_gid=orl.source_location_gid
                                ) 
AND orl.user_defined2_icon_gid IS NULL 
AND orl.total_weight >= '40000' 
AND orl.rate_offering_gid IS NULL 
AND orl.user_defined1_icon_gid IN ('NBL.NBL_SCHEDULED_APPT', 'NBL.APPT_SCHEDULED') 
AND (orl.attribute6 IN ('GENPLAN-APPROVED','READY') OR orl.attribute6 IS NULL) 
AND orl.order_release_gid = ors.order_release_gid 
AND ors.status_type_gid = 'NBL.PLANNING' 
AND ors.status_value_gid IN ('NBL.PLANNING_NEW', 
'NBL.PLANNING_PLANNED - FAILED', 
'NBL.PLANNING_PLANNED - PARTIAL', 
'NBL.PLANNING_UNSCHEDULED' ,
'NBL.PLANNING_PLANNED - FINAL')
-- New join
AND loc.location_gid = orl.dest_location_gid
AND tz.time_zone_gid = loc.time_zone_gid
--Convert everything to Local Time and compare
AND UTC.GET_LOCAL_DATE(orl.early_delivery_date, orl.dest_location_gid) >= FROM_TZ(CAST(SYSDATE +48/24 AS TIMESTAMP), 'UTC') AT TIME ZONE tz.TIME_ZONE_XID 
AND UTC.GET_LOCAL_DATE(orl.early_delivery_date, orl.dest_location_gid) <= FROM_TZ(CAST(SYSDATE +5-0.000012 AS TIMESTAMP), 'UTC') AT TIME ZONE tz.TIME_ZONE_XID 
--AND orl.early_delivery_date >= (trunc(new_time( sysdate +48/24, 'GMT', 'PST' ))) 
--AND orl.early_delivery_date <= (trunc(new_time( sysdate +5, 'GMT', 'PST' ))-0.000012) 
and not exists(
                select 1 
                from order_movement om, shipment s 
                where om.order_release_gid = orl.order_release_gid 
                and om.shipment_gid = s.shipment_gid 
                and s.driver_gid is not null
                ) 
and not exists (
                select 1 
                from shipment_Refnum sr1, order_movement om1 
                where om1.shipment_gid=sr1.shipment_gid 
                and om1.order_Release_Gid=orl.order_release_Gid 
                and sr1.SHIPMENT_REFNUM_QUAL_GID='WORK_ASSIGNMENT_GID' 
                and sr1.shipment_refnum_value='ChangedToOTR'
                ) 
and not exists (
                SELECT 1 
                FROM SERVPROV_PROFILE_DETAIL SPD,SHIPMENT S,ORDER_MOVEMENT OM 
                WHERE OM.SHIPMENT_GID=S.SHIPMENT_GID 
                AND SPD.SERVPROV_PROFILE_GID = 'NBL.DF_ENGA' 
                AND SPD.SERVPROV_GID!=S.SERVPROV_GID 
                AND S.PLANNING_PARAMETER_SET_GID='NBL.DF_PLANNING_PARAMETER' 
                and OM.ORDER_RELEASE_GID=ORL.ORDER_RELEASE_GID
                ) 
and not exists (
                select 1 
                from shipment s11, order_movement om11 
                where om11.shipment_gid=s11.shipment_gid 
                and s11.SERVPROV_GID='NBL.DYNAMIC_ROUTING' 
                and om11.order_release_gid=orl.order_release_gid
                ) 
and exists (
            select orss1.order_release_gid 
            from order_release_special_service ORSS1 
            where ORL.ORDER_RELEASE_GID = ORSS1.ORDER_RELEASE_GID 
            AND ORSS1.SPECIAL_SERVICE_CODE_GID = 'NBL.FLEET'
            )


--------------------------------------FINAL--------------------------------------------------------


SELECT orl.order_release_gid 
FROM order_release orl, order_release_status ors, location loc, time_zone tz 
WHERE orl.ORDER_RELEASE_TYPE_GID <> 'NBL.TONU' 
AND orl.PAYMENT_METHOD_CODE_GID IN ('NBL.DELIVERY','NBL.PAID')  
and orl.dest_location_gid LIKE 'NBL.CUS%'  
AND orl.source_location_gid IN ( 
                                    select lpd.location_gid 
                                    from location_profile_detail lpd 
                                    where lpd.location_profile_gid='NBL.DF_ENGA'  
                                    and lpd.location_gid=orl.source_location_gid 
                                )  
AND orl.user_defined2_icon_gid IS NULL  
AND orl.total_weight >= '40000'  
AND orl.rate_offering_gid IS NULL  
AND orl.user_defined1_icon_gid IN ('NBL.NBL_SCHEDULED_APPT', 'NBL.APPT_SCHEDULED')  
AND (orl.attribute6 IN ('GENPLAN-APPROVED','READY') OR orl.attribute6 IS NULL)  
AND orl.order_release_gid = ors.order_release_gid  
AND ors.status_type_gid = 'NBL.PLANNING'  
AND ors.status_value_gid IN ('NBL.PLANNING_NEW',  
'NBL.PLANNING_PLANNED - FAILED',  
'NBL.PLANNING_PLANNED - PARTIAL',  
'NBL.PLANNING_UNSCHEDULED' , 
'NBL.PLANNING_PLANNED - FINAL')  
AND loc.location_gid = orl.dest_location_gid 
AND tz.time_zone_gid = loc.time_zone_gid 
AND UTC.GET_LOCAL_DATE(orl.early_delivery_date, orl.dest_location_gid) >= FROM_TZ(CAST(SYSDATE +48/24 AS TIMESTAMP), 'UTC') AT TIME ZONE tz.TIME_ZONE_XID  
AND UTC.GET_LOCAL_DATE(orl.early_delivery_date, orl.dest_location_gid) <= FROM_TZ(CAST(SYSDATE +5-0.000012 AS TIMESTAMP), 'UTC') AT TIME ZONE tz.TIME_ZONE_XID  
and not exists( 
                select 1  
                from order_movement om, shipment s  
                where om.order_release_gid = orl.order_release_gid  
                and om.shipment_gid = s.shipment_gid  
                and s.driver_gid is not null  
                )  
and not exists ( 
                select 1  
                from shipment_Refnum sr1, order_movement om1  
                where om1.shipment_gid=sr1.shipment_gid  
                and om1.order_Release_Gid=orl.order_release_Gid   
                and sr1.SHIPMENT_REFNUM_QUAL_GID='WORK_ASSIGNMENT_GID'   
                and sr1.shipment_refnum_value='ChangedToOTR'  
                )  
and not exists (  
                SELECT 1  
                FROM SERVPROV_PROFILE_DETAIL SPD,SHIPMENT S,ORDER_MOVEMENT OM  
                WHERE OM.SHIPMENT_GID=S.SHIPMENT_GID  
                AND SPD.SERVPROV_PROFILE_GID = 'NBL.DF_ENGA'  
                AND SPD.SERVPROV_GID!=S.SERVPROV_GID  
                AND S.PLANNING_PARAMETER_SET_GID='NBL.DF_PLANNING_PARAMETER'  
                and OM.ORDER_RELEASE_GID=ORL.ORDER_RELEASE_GID  
                )  
and not exists (  
                select 1  
                from shipment s11, order_movement om11  
                where om11.shipment_gid=s11.shipment_gid  
                and s11.SERVPROV_GID='NBL.DYNAMIC_ROUTING'   
                and om11.order_release_gid=orl.order_release_gid  
                )   
and exists (  
            select orss1.order_release_gid  
            from order_release_special_service ORSS1  
            where ORL.ORDER_RELEASE_GID = ORSS1.ORDER_RELEASE_GID  
            AND ORSS1.SPECIAL_SERVICE_CODE_GID = 'NBL.FLEET'  
            ) 



--------------


Abraham Rougerio -
Thanks for helping out on the SQL for correcting the dates.
I amended the existing query by adding the condition from your query but unfortunately it is erroring out for me. 
Request you to please take a look at the below sql and help me identify the error:

SELECT orl.order_release_gid, UTC.GET_LOCAL_DATE(orl.early_delivery_date, orl.dest_location_gid), FROM_TZ(CAST(SYSDATE +48/24 AS TIMESTAMP), 'CET') AT TIME ZONE tz.TIME_ZONE_XID
,  tz.TIME_ZONE_XID
FROM order_release orl, order_release_status ors, location loc, time_zone tz 
WHERE orl.ORDER_RELEASE_TYPE_GID <> 'NBL.TONU' 
AND orl.PAYMENT_METHOD_CODE_GID IN ('NBL.DELIVERY','NBL.PAID') 
and orl.dest_location_gid LIKE 'NBL.CUS%' 
AND orl.source_location_gid IN (select lpd.location_gid from location_profile_detail lpd where lpd.location_profile_gid='NBL.DF_ENGA' and lpd.location_gid=orl.source_location_gid) 
AND orl.user_defined2_icon_gid IS NULL 
AND orl.total_weight >= '40000' 
AND orl.rate_offering_gid IS NULL 
AND orl.user_defined1_icon_gid IN ('NBL.NBL_SCHEDULED_APPT', 'NBL.APPT_SCHEDULED')  
AND (orl.attribute6 IN ('GENPLAN-APPROVED','READY') OR orl.attribute6 IS NULL) 
AND orl.order_release_gid = ors.order_release_gid 
AND ors.status_type_gid = 'NBL.PLANNING' 
AND ors.status_value_gid IN ('NBL.PLANNING_NEW', 'NBL.PLANNING_PLANNED - FAILED', 'NBL.PLANNING_PLANNED - PARTIAL', 'NBL.PLANNING_UNSCHEDULED' ,'NBL.PLANNING_PLANNED - FINAL') 
AND loc.location_gid = orl.dest_location_gid 
AND tz.time_zone_gid = loc.time_zone_gid 
AND UTC.GET_LOCAL_DATE(orl.early_delivery_date, orl.dest_location_gid) >= FROM_TZ(CAST(SYSDATE +48/24 AS TIMESTAMP), 'CET') AT TIME ZONE tz.TIME_ZONE_XID 
--AND UTC.GET_LOCAL_DATE(orl.early_delivery_date, orl.dest_location_gid) <= FROM_TZ(CAST(SYSDATE +5-0.000012 AS TIMESTAMP), 'UTC') AT TIME ZONE tz.TIME_ZONE_XID 
and not exists(select 1 from order_movement om, shipment s where om.order_release_gid = orl.order_release_gid and om.shipment_gid = s.shipment_gid and s.driver_gid is not null) 
and not exists (select 1 from shipment_Refnum sr1, order_movement om1 where om1.shipment_gid=sr1.shipment_gid and om1.order_Release_Gid=orl.order_release_Gid and sr1.SHIPMENT_REFNUM_QUAL_GID='WORK_ASSIGNMENT_GID' and sr1.shipment_refnum_value='ChangedToOTR') 
and not exists (SELECT 1 FROM SERVPROV_PROFILE_DETAIL SPD,SHIPMENT S,ORDER_MOVEMENT OM WHERE OM.SHIPMENT_GID=S.SHIPMENT_GID AND SPD.SERVPROV_PROFILE_GID = 'NBL.DF_ENGA' AND SPD.SERVPROV_GID!=S.SERVPROV_GID AND S.PLANNING_PARAMETER_SET_GID='NBL.DF_PLANNING_PARAMETER' and OM.ORDER_RELEASE_GID=ORL.ORDER_RELEASE_GID) 
and not exists (select 1 from shipment s11, order_movement om11 where om11.shipment_gid=s11.shipment_gid and s11.SERVPROV_GID='NBL.DYNAMIC_ROUTING' and om11.order_release_gid=orl.order_release_gid) 
and exists (select order_release_gid from order_release_special_service ORSS where ORL.ORDER_RELEASE_GID = ORSS.ORDER_RELEASE_GID AND ORSS.SPECIAL_SERVICE_CODE_GID in ('NBL.DROP','NBL.DTS')) 
and exists (select orss2.order_release_gid from order_release_special_service ORSS2 where ORL.ORDER_RELEASE_GID = ORSS2.ORDER_RELEASE_GID AND ORSS2.SPECIAL_SERVICE_CODE_GID = 'NBL.FLEET')





SELECT orl.order_release_gid, COUNT(orl.order_release_gid)
FROM order_release orl, order_release_status ors, location loc, time_zone tz 
WHERE orl.ORDER_RELEASE_TYPE_GID <> 'NBL.TONU' 
AND orl.PAYMENT_METHOD_CODE_GID IN ('NBL.DELIVERY','NBL.PAID') 
and orl.dest_location_gid LIKE 'NBL.CUS%' 
AND orl.source_location_gid IN (select lpd.location_gid from location_profile_detail lpd where lpd.location_profile_gid='NBL.DF_ENGA' and lpd.location_gid=orl.source_location_gid) 
AND orl.user_defined2_icon_gid IS NULL 
AND orl.total_weight >= '40000' 
AND orl.rate_offering_gid IS NULL 
AND orl.user_defined1_icon_gid IN ('NBL.NBL_SCHEDULED_APPT', 'NBL.APPT_SCHEDULED')  
AND (orl.attribute6 IN ('GENPLAN-APPROVED','READY') OR orl.attribute6 IS NULL) 
AND orl.order_release_gid = ors.order_release_gid 
AND ors.status_type_gid = 'NBL.PLANNING' 
AND ors.status_value_gid IN ('NBL.PLANNING_NEW', 'NBL.PLANNING_PLANNED - FAILED', 'NBL.PLANNING_PLANNED - PARTIAL', 'NBL.PLANNING_UNSCHEDULED' ,'NBL.PLANNING_PLANNED - FINAL') 
AND loc.location_gid = orl.dest_location_gid 
AND tz.time_zone_gid = loc.time_zone_gid 
AND UTC.GET_LOCAL_DATE(orl.early_delivery_date, orl.dest_location_gid) >= FROM_TZ(CAST(SYSDATE +48/24 AS TIMESTAMP), 'UTC') AT TIME ZONE tz.TIME_ZONE_XID 
AND UTC.GET_LOCAL_DATE(orl.early_delivery_date, orl.dest_location_gid) <= FROM_TZ(CAST(SYSDATE +5-0.000012 AS TIMESTAMP), 'UTC') AT TIME ZONE tz.TIME_ZONE_XID 
and not exists(select 1 from order_movement om, shipment s where om.order_release_gid = orl.order_release_gid and om.shipment_gid = s.shipment_gid and s.driver_gid is not null) 
and not exists (select 1 from shipment_Refnum sr1, order_movement om1 where om1.shipment_gid=sr1.shipment_gid and om1.order_Release_Gid=orl.order_release_Gid and sr1.SHIPMENT_REFNUM_QUAL_GID='WORK_ASSIGNMENT_GID' and sr1.shipment_refnum_value='ChangedToOTR') 
and not exists (SELECT 1 FROM SERVPROV_PROFILE_DETAIL SPD,SHIPMENT S,ORDER_MOVEMENT OM WHERE OM.SHIPMENT_GID=S.SHIPMENT_GID AND SPD.SERVPROV_PROFILE_GID = 'NBL.DF_ENGA' AND SPD.SERVPROV_GID!=S.SERVPROV_GID AND S.PLANNING_PARAMETER_SET_GID='NBL.DF_PLANNING_PARAMETER' and OM.ORDER_RELEASE_GID=ORL.ORDER_RELEASE_GID) 
and not exists (select 1 from shipment s11, order_movement om11 where om11.shipment_gid=s11.shipment_gid and s11.SERVPROV_GID='NBL.DYNAMIC_ROUTING' and om11.order_release_gid=orl.order_release_gid) 
and exists (select order_release_gid from order_release_special_service ORSS where ORL.ORDER_RELEASE_GID = ORSS.ORDER_RELEASE_GID AND ORSS.SPECIAL_SERVICE_CODE_GID in ('NBL.DROP','NBL.DTS')) 
and exists (select orss2.order_release_gid from order_release_special_service ORSS2 where ORL.ORDER_RELEASE_GID = ORSS2.ORDER_RELEASE_GID AND ORSS2.SPECIAL_SERVICE_CODE_GID = 'NBL.FLEET') 
GROUP BY orl.order_release_gid 
HAVING COUNT(orl.order_release_gid) > 1





orl.source_location_gid IN 
(select lpd.location_gid 
from location_profile_detail lpd 
where lpd.location_profile_gid='NBL.DF_ENGA' 
and lpd.location_gid=orl.source_location_gid)

----------------Query Semana del 28 de Abril

SELECT orl.order_release_gid, 
UTC.GET_LOCAL_DATE(orl.early_delivery_date, orl.dest_location_gid) LOCAL_DATE, 
lpd.location_profile_gid, 
orl.source_location_gid, 
orl.ORDER_RELEASE_TYPE_GID, 
orl.PAYMENT_METHOD_CODE_GID, 
orl.dest_location_gid, 
orl.user_defined2_icon_gid, 
orl.total_weight, 
orl.rate_offering_gid, 
orl.user_defined1_icon_gid, 
orl.attribute6, 
ors.status_type_gid, 
ors.status_value_gid, 
tz.TIME_ZONE_XID 
FROM order_release orl, order_release_status ors, location loc, time_zone tz, location_profile_detail lpd 
WHERE orl.order_release_gid = ors.order_release_gid 
AND loc.location_gid = orl.dest_location_gid 
AND tz.time_zone_gid = loc.time_zone_gid 
AND lpd.location_profile_gid='NBL.DF_ENGA' 
AND lpd.location_gid = orl.source_location_gid 
AND orl.ORDER_RELEASE_TYPE_GID <> 'NBL.TONU' 
AND orl.PAYMENT_METHOD_CODE_GID IN ('NBL.DELIVERY','NBL.PAID') 
AND orl.dest_location_gid LIKE 'NBL.CUS%' 
AND orl.user_defined2_icon_gid IS NULL 
AND orl.total_weight >= '40000' 
AND orl.rate_offering_gid IS NULL 
AND orl.user_defined1_icon_gid IN ('NBL.NBL_SCHEDULED_APPT', 'NBL.APPT_SCHEDULED') 
AND (orl.attribute6 IN ('GENPLAN-APPROVED','READY') OR orl.attribute6 IS NULL) 
AND ors.status_type_gid = 'NBL.PLANNING' 
AND ors.status_value_gid IN ('NBL.PLANNING_NEW', 'NBL.PLANNING_PLANNED - FAILED', 'NBL.PLANNING_PLANNED - PARTIAL', 'NBL.PLANNING_UNSCHEDULED' ,'NBL.PLANNING_PLANNED - FINAL')  
AND NOT EXISTS(select 1 from order_movement om, shipment s where om.order_release_gid = orl.order_release_gid and om.shipment_gid = s.shipment_gid and s.driver_gid is not null) 
AND NOT EXISTS(select 1 from shipment_Refnum sr1, order_movement om1 where om1.shipment_gid=sr1.shipment_gid and om1.order_Release_Gid=orl.order_release_Gid and sr1.SHIPMENT_REFNUM_QUAL_GID='WORK_ASSIGNMENT_GID' and sr1.shipment_refnum_value='ChangedToOTR') 
AND NOT EXISTS(SELECT 1 FROM SERVPROV_PROFILE_DETAIL SPD,SHIPMENT S,ORDER_MOVEMENT OM WHERE OM.SHIPMENT_GID=S.SHIPMENT_GID AND SPD.SERVPROV_PROFILE_GID = 'NBL.DF_ENGA' AND SPD.SERVPROV_GID!=S.SERVPROV_GID AND S.PLANNING_PARAMETER_SET_GID='NBL.DF_PLANNING_PARAMETER' and OM.ORDER_RELEASE_GID=ORL.ORDER_RELEASE_GID) 
AND NOT EXISTS(select 1 from shipment s11, order_movement om11 where om11.shipment_gid=s11.shipment_gid and s11.SERVPROV_GID='NBL.DYNAMIC_ROUTING' and om11.order_release_gid=orl.order_release_gid) 
AND EXISTS(select order_release_gid from order_release_special_service ORSS where ORL.ORDER_RELEASE_GID = ORSS.ORDER_RELEASE_GID AND ORSS.SPECIAL_SERVICE_CODE_GID in ('NBL.DROP','NBL.DTS')) 
AND EXISTS(select orss2.order_release_gid from order_release_special_service ORSS2 where ORL.ORDER_RELEASE_GID = ORSS2.ORDER_RELEASE_GID AND ORSS2.SPECIAL_SERVICE_CODE_GID = 'NBL.FLEET')



 --orl.order_release_gid, orl.early_delivery_date, orl.dest_location_gid, loc.time_zone_gid, tz.TIME_ZONE_XID

 --AND UTC.GET_LOCAL_DATE(orl.early_delivery_date, orl.dest_location_gid) >= FROM_TZ(CAST(SYSDATE +48/24 AS TIMESTAMP), 'UTC') AT TIME ZONE tz.TIME_ZONE_XID 
--AND UTC.GET_LOCAL_DATE(orl.early_delivery_date, orl.dest_location_gid) <= FROM_TZ(CAST(SYSDATE +5-0.000012 AS TIMESTAMP), 'UTC') AT TIME ZONE tz.TIME_ZONE_XID 




SELECT orl.order_release_gid 
FROM order_release orl, order_release_status ors, location loc, time_zone tz, location_profile_detail lpd 
WHERE orl.order_release_gid = ors.order_release_gid 
AND loc.location_gid = orl.dest_location_gid 
AND tz.time_zone_gid = loc.time_zone_gid 
AND lpd.location_profile_gid='NBL.DF_ENGA' 
and lpd.location_gid=orl.source_location_gid 
AND  orl.ORDER_RELEASE_TYPE_GID <> 'NBL.TONU' 
AND orl.PAYMENT_METHOD_CODE_GID IN ('NBL.DELIVERY','NBL.PAID') 
and orl.dest_location_gid LIKE 'NBL.CUS%' 
AND orl.user_defined2_icon_gid IS NULL 
AND orl.total_weight >= '40000' 
AND orl.rate_offering_gid IS NULL 
AND orl.user_defined1_icon_gid IN ('NBL.NBL_SCHEDULED_APPT', 'NBL.APPT_SCHEDULED') 
AND (orl.attribute6 IN ('GENPLAN-APPROVED','READY') OR orl.attribute6 IS NULL) 
AND ors.status_type_gid = 'NBL.PLANNING' 
AND ors.status_value_gid IN ('NBL.PLANNING_NEW', 'NBL.PLANNING_PLANNED - FAILED', 'NBL.PLANNING_PLANNED - PARTIAL', 'NBL.PLANNING_UNSCHEDULED' ,'NBL.PLANNING_PLANNED - FINAL') 
AND UTC.GET_LOCAL_DATE(orl.early_delivery_date, orl.dest_location_gid) >= FROM_TZ(CAST(SYSDATE +48/24 AS TIMESTAMP), 'UTC') AT TIME ZONE tz.TIME_ZONE_XID 
AND UTC.GET_LOCAL_DATE(orl.early_delivery_date, orl.dest_location_gid) <= FROM_TZ(CAST(SYSDATE +5-0.000012 AS TIMESTAMP), 'UTC') AT TIME ZONE tz.TIME_ZONE_XID 
and not exists(select 1 from order_movement om, shipment s where om.order_release_gid = orl.order_release_gid and om.shipment_gid = s.shipment_gid and s.driver_gid is not null) 
and not exists (select 1 from shipment_Refnum sr1, order_movement om1 where om1.shipment_gid=sr1.shipment_gid and om1.order_Release_Gid=orl.order_release_Gid and sr1.SHIPMENT_REFNUM_QUAL_GID='WORK_ASSIGNMENT_GID' and sr1.shipment_refnum_value='ChangedToOTR') 
and not exists (SELECT 1 FROM SERVPROV_PROFILE_DETAIL SPD,SHIPMENT S,ORDER_MOVEMENT OM WHERE OM.SHIPMENT_GID=S.SHIPMENT_GID AND SPD.SERVPROV_PROFILE_GID = 'NBL.DF_ENGA' AND SPD.SERVPROV_GID!=S.SERVPROV_GID AND S.PLANNING_PARAMETER_SET_GID='NBL.DF_PLANNING_PARAMETER' and OM.ORDER_RELEASE_GID=ORL.ORDER_RELEASE_GID) 
and not exists (select 1 from shipment s11, order_movement om11 where om11.shipment_gid=s11.shipment_gid and s11.SERVPROV_GID='NBL.DYNAMIC_ROUTING' and om11.order_release_gid=orl.order_release_gid) 
and exists (select order_release_gid from order_release_special_service ORSS where ORL.ORDER_RELEASE_GID = ORSS.ORDER_RELEASE_GID AND ORSS.SPECIAL_SERVICE_CODE_GID in ('NBL.DROP','NBL.DTS')) 
and exists (select orss2.order_release_gid from order_release_special_service ORSS2 where ORL.ORDER_RELEASE_GID = ORSS2.ORDER_RELEASE_GID AND ORSS2.SPECIAL_SERVICE_CODE_GID = 'NBL.FLEET')