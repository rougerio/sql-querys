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

select distinct orl.order_release_gid 
from order_release_status ors inner join 
order_release or1 on ors.order_release_gid = or1.order_release_gid 
--inner join 
--location loc on loc.location_gid = orl.source_location_gid inner join 
--time_zone tz on tz.time_zone_gid = loc.time_zone_gid 
where ors.status_value_gid = 'NBL/MX.PLANNING_UNSCHEDULED'  
and ors.status_type_gid = 'NBL/MX.PLANNING' 
and orl.domain_name = 'NBL/MX'
and UTC.GET_LOCAL_DATE(ors.update_date, orl.source_location_gid) > CAST(from_tz(cast(sysdate - 7 as timestamp), 'UTC') at time zone tz.time_zone_xid AS date) 

SELECT ORL.ORDER_RELEASE_GID, UTC.GET_LOCAL_DATE(ORS.UPDATE_DATE, ORL.SOURCE_LOCATION_GID), TZ.TIME_ZOME_XID
FROM ORDER_RELEASE ORL INNER JOIN
ORDER_RELEASE_STATUS ORS ON ORL.ORDER_RELEASE_GID = ORS.ORDER_RELEASE_GID INNER JOIN 
LOCATION LOC ON LOC.LOCATION_GID = ORL.SOURCE_LOCATION_GID INNER JOIN
TIME_ZONE TZ ON TZ.TIME_ZONE_GID = LOC.TIME_ZONE_GID
WHERE ORS.STATUS_VALUE_GID = 'NBL/MX.PLANNING_UNSCHEDULED' 
AND ORS.STATUS_TYPE_GID = 'NBL/MX.PLANNING' 
AND ORL.DOMAIN_NAME = 'NBL/MX' 
AND UTC.GET_LOCAL_DATE(ORS.UPDATE_DATE, ORL.SOURCE_LOCATION_GID) > CAST(FROM_TZ(CAST(SYSDATE - 7 AS TIMESTAMP), 'UTC') AT TIME ZONE TZ.TIME_ZOME_XID AS DATE) 

------------------------------------------------------------------------------
--OR_WITH_NO_PENDING_REASON_MX

select order_Release_gid 
from order_Release 
where attribute2 is null 
and sysdate > insert_date + 2 
and indicator = 'W' 
and domain_name = 'NBL/MX'

------------------------------------------------------------------------------
--OR_WITH_PENDING_REASON_MX

select order_Release_gid 
from order_Release 
where attribute2 is not null 
and sysdate > insert_date + 2 
and indicator = 'W' 
and domain_name = 'NBL/MX'

------------------------------------------------------------------------------
--OR_WITH_PENDING_REASON_MX

select order_Release_gid 
from order_Release 
where attribute2 is not null 
and sysdate > insert_date + 2 
and indicator = 'W' 
and domain_name = 'NBL/MX'

--------------------------------------------------------------------------
--OR_WITHDRAWN_ORDERS_MX

select distinct om.order_Release_gid 
from order_movement om 
where om.shipment_gid in (
                            select shipment_gid 
                            from shipment_status 
                            where status_value_gid = 'NBL/MX.SECURE RESOURCES_WITHDRAWN' 
                            and status_type_gid = 'NBL/MX.SECURE RESOURCES' 
                            and update_date > sysdate - 7
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




/*
OR_ORDER_NOT_PLANNED_MX: -> 'NBL/MX.PLANNING_PLANNED - FAILED' ,'NBL/MX.PLANNING_NEW'
OR_UNASSIGNED_ORDERS_MX -> NBL/MX.PLANNING_UNSCHEDULED
OR_WITH_NO_PENDING_REASON_MX -> 'NBL/MX.PLANNING_NEW AND User Defined Attribute2 is null
OR_WITH_PENDING_REASON_MX-> 'NBL/MX.PLANNING_NEW AND User Defined Attribute2 is not null
OR_WITHDRAWN_ORDERS_MX: -> tab ORDER_RELEASE_REMARK where ORDER_RELEASE_GID  like %WITHDRAW%

*/