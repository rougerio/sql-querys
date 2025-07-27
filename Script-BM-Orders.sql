--OR_ORDER_NOT_PLANNED_MX

SELECT ORR.ORDER_RELEASE_GID 
FROM ORDER_RELEASE ORR  
WHERE exists( 
                select 1 
                from ORDER_RELEASE_STATUS ORS 
                where ORR.ORDER_RELEASE_GID = ORS.ORDER_RELEASE_GID 
                AND  ORS.STATUS_TYPE_GID='NBL/MX.PLANNING' 
                AND ORS.STATUS_VALUE_GID IN ('NBL/MX.PLANNING_PLANNED - FAILED' ,'NBL/MX.PLANNING_NEW' ,'NBL/MX.PLANNING_UNSCHEDULED')
            ) 
AND ORR.USER_DEFINED1_ICON_GID IN ('NBL.APPT_SHCEDULED' ,'NBL.SCHEDULED_APPT' ,'NBL.CAR_SCHEDULED_APPT')

-----------Final Query-----------


SELECT ORR.ORDER_RELEASE_GID 
FROM ORDER_RELEASE ORR  
WHERE exists( 
                select 1 
                from ORDER_RELEASE_STATUS ORS 
                where ORR.ORDER_RELEASE_GID = ORS.ORDER_RELEASE_GID 
                AND  ORS.STATUS_TYPE_GID='NBL/MX.PLANNING' 
                AND ORS.STATUS_VALUE_GID IN ('NBL/MX.PLANNING_PLANNED - FAILED' ,'NBL/MX.PLANNING_NEW' ,'NBL/MX.PLANNING_UNSCHEDULED')
            ) 
AND ORR.USER_DEFINED1_ICON_GID IN ('NBL.APPT_SHCEDULED' ,'NBL.SCHEDULED_APPT' ,'NBL.CAR_SCHEDULED_APPT')
AND ORR.DOMAIN_NAME = 'NBL/MX'

-------------------------------------------------------------------------------
--OR_UNASSIGNED_ORDERS_MX

select distinct ors.order_Release_gid 
from order_release_status ors 
where status_value_gid = 'NBL/MX.PLANNING_UNSCHEDULED' 
and status_type_gid = 'NBL/MX.PLANNING' 
and update_date > sysdate - 7

-----------Final Query-----------

SELECT DISTINCT ORL.ORDER_RELEASE_GID 
FROM ORDER_RELEASE ORL INNER JOIN 
ORDER_RELEASE_STATUS ORS ON ORL.ORDER_RELEASE_GID = ORS.ORDER_RELEASE_GID INNER JOIN 
LOCATION LOC ON LOC.LOCATION_GID = ORL.SOURCE_LOCATION_GID INNER JOIN 
TIME_ZONE TZ ON TZ.TIME_ZONE_GID = LOC.TIME_ZONE_GID 
WHERE ORS.STATUS_VALUE_GID = 'NBL/MX.PLANNING_UNSCHEDULED' 
AND ORS.STATUS_TYPE_GID = 'NBL/MX.PLANNING' 
AND ORL.DOMAIN_NAME = 'NBL/MX' 
AND UTC.GET_LOCAL_DATE(ORS.UPDATE_DATE, ORL.SOURCE_LOCATION_GID) > CAST(FROM_TZ(CAST(SYSDATE - 7 AS TIMESTAMP), 'UTC') AT TIME ZONE TZ.TIME_ZONE_XID AS DATE) 

------------------------------------------------------------------------------
--OR_WITH_NO_PENDING_REASON_MX


select order_release_gid 
from order_release 
where attribute2 is null 
and sysdate > insert_date + 2 
and indicator = 'W' 
and domain_name = 'NBL/MX'

-----------Final Query-----------

select orl.order_release_gid 
from order_release orl inner join 
LOCATION LOC ON LOC.LOCATION_GID = ORL.SOURCE_LOCATION_GID INNER JOIN 
TIME_ZONE TZ ON TZ.TIME_ZONE_GID = LOC.TIME_ZONE_GID 
where orl.attribute2 is null 
and orl.indicator = 'W' 
and orl.domain_name = 'NBL/MX' 
AND CAST(FROM_TZ(CAST(SYSDATE + 2 AS TIMESTAMP), 'UTC') AT TIME ZONE TZ.TIME_ZONE_XID AS DATE) > UTC.GET_LOCAL_DATE(orl.INSERT_DATE, orl.SOURCE_LOCATION_GID) 


------------------------------------------------------------------------------
--OR_WITH_PENDING_REASON_MX

select order_Release_gid 
from order_Release 
where attribute2 is not null 
and sysdate > insert_date + 2 
and indicator = 'W' 
and domain_name = 'NBL/MX'


-----------Final Query-----------

select orl.order_release_gid 
from order_release orl inner join 
LOCATION LOC ON LOC.LOCATION_GID = ORL.SOURCE_LOCATION_GID INNER JOIN 
TIME_ZONE TZ ON TZ.TIME_ZONE_GID = LOC.TIME_ZONE_GID 
where orl.attribute2 is not null 
and orl.indicator = 'W' 
and orl.domain_name = 'NBL/MX' 
AND CAST(FROM_TZ(CAST(SYSDATE + 2 AS TIMESTAMP), 'UTC') AT TIME ZONE TZ.TIME_ZONE_XID AS DATE) > UTC.GET_LOCAL_DATE(orl.INSERT_DATE, orl.SOURCE_LOCATION_GID) 

--------------------------------------------------------------------------
--OR_WITHDRAWN_ORDERS_MX

select distinct om.order_release_gid 
from order_movement om 
where om.shipment_gid in (
                            select shipment_gid 
                            from shipment_status 
                            where status_value_gid = 'NBL/MX.SECURE RESOURCES_WITHDRAWN' 
                            and status_type_gid = 'NBL/MX.SECURE RESOURCES' 
                            and update_date > sysdate - 7
                        )

-----------Final Query-----------

select distinct om.order_release_gid 
from order_movement om 
where om.shipment_gid in ( 
                            select sse.shipment_gid 
                            from shipment_status sse inner join 
                            shipment_stop ss on sse.shipment_gid = ss.shipment_gid and ss.stop_num = 1 inner join 
                            location loc on loc.location_gid = ss.location_gid inner join 
                            time_zone tz on tz.time_zone_gid = loc.time_zone_gid 
                            where sse.status_value_gid = 'NBL/MX.SECURE RESOURCES_WITHDRAWN' 
                            and sse.status_type_gid = 'NBL/MX.SECURE RESOURCES' 
                            and UTC.GET_LOCAL_DATE(sse.update_date, loc.LOCATION_GID) > CAST(FROM_TZ(CAST(SYSDATE - 7 AS TIMESTAMP), 'UTC') AT TIME ZONE tz.TIME_ZONE_XID AS DATE) 
                        ) 


--------------------------------------------------------------------------
--OR_RUSH_ORDERS_MX

select order_release_gid 
from order_release OR1 
where user_defined1_icon_gid = 'ITEM' 
and exists(
            select 1 
            from order_release_status ors 
            where ors.order_Release_gid = or1.order_Release_gid 
            and ors.status_type_gid = 'NBL/MX.PLANNING' 
            and ors.status_value_gid in ('NBL/MX.PLANNING_NEW','NBL/MX.PLANNING_UNSCHEDULED','NBL/MX.PLANNING_PLANNED-FAILED')
        ) 
and round(nvl(late_delivery_date,late_pickup_date) - insert_date) <= 2

-----------Final Query-----------

select or1.order_release_gid
from order_release or1 
where exists(
            select 1 
            from order_release_status ors 
            where ors.order_release_gid = or1.order_release_gid 
            and ors.status_type_gid = 'NBL/MX.PLANNING' 
            and ors.status_value_gid in ('NBL/MX.PLANNING_NEW','NBL/MX.PLANNING_UNSCHEDULED','NBL/MX.PLANNING_PLANNED-FAILED')
        ) 
and abs(round(utc.get_local_date(nvl(or1.late_delivery_date, or1.late_pickup_date), or1.source_location_gid) - utc.get_local_date(or1.insert_date, or1.source_location_gid))) > 0 
and abs(round(utc.get_local_date(nvl(or1.late_delivery_date, or1.late_pickup_date), or1.source_location_gid) - utc.get_local_date(or1.insert_date, or1.source_location_gid))) <= 2




/*
OR_ORDER_NOT_PLANNED_MX: -> 'NBL/MX.PLANNING_PLANNED - FAILED' ,'NBL/MX.PLANNING_NEW'
OR_UNASSIGNED_ORDERS_MX -> NBL/MX.PLANNING_UNSCHEDULED
OR_WITH_NO_PENDING_REASON_MX -> 'NBL/MX.PLANNING_NEW AND User Defined Attribute2 is null
OR_WITH_PENDING_REASON_MX-> 'NBL/MX.PLANNING_NEW AND User Defined Attribute2 is not null
OR_WITHDRAWN_ORDERS_MX: -> tab ORDER_RELEASE_REMARK where ORDER_RELEASE_GID  like %WITHDRAW%

*/



/*
Querys nuevos
OR_UNASSIGNED_ORDERS-MX
OR_WITH_NO_PENDING_REASON-MX
OR_WITH_PENDING_REASON-MX
OR_WITHDRAWN_ORDERS-MX
OR_RUSH_ORDERS-MX

Querys a Eliminar
OR_UNASSIGNED_ORDERS_MX