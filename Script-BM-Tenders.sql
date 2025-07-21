--BS_SHIPMENTS_NOT_ACCEPTED_MX
SELECT S.SHIPMENT_GID 
FROM SHIPMENT S 
WHERE S.TRANSPORT_MODE_GID NOT IN ('NBL/MX.PICKUP') 
AND exists(
        select 1 
        from shipment_status ss 
        where SS.STATUS_TYPE_GID ='NBL/MX.DYNAMIC_ROUTING_VALID' 
        AND SS.STATUS_VALUE_GID='NBL/MX.DYNAMIC_ROUTING_VALID-NO' 
        AND S.SHIPMENT_GID=SS.SHIPMENT_GID) 
AND exists(
        select 1 
        from shipment_status ss1 
        where S.SHIPMENT_GID=SS1.SHIPMENT_GID 
        and SS1.STATUS_TYPE_GID='NBL/MX.SECURE RESOURCES' 
        AND SS1.STATUS_VALUE_GID NOT IN ('NBL/MX.SECURE RESOURCES_ACCEPTED')
        ) 
and s.start_Time > sysdate - 10


--BS_TENDER_FAILED_TIMEOUT_MX
select s.shipment_gid 
from shipment s 
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
        and drg.status_type_gid = 'NBL /MX .SENT_TO_DR' 
        and drg.status_value_gid in ('NBL/MX.SENT_TO_DR_NOT_SENT_INVALID','NBL/MX.SENT_TO_DR_SENT','NBL/MX.SENT_TO_DR_CANCELLED') 
        ) 
and exists( 
        select 1 
        from shipment_status drg2 
        where s.shipment_gid = drg2.shipment_gid 
        and drg2.status_type_gid = 'NBL/MX.DYNAMIC_ROUTING_VALID' 
        and drg2.status_value_gid in ('NBL/MX.DYNAMIC_ROUTING_VALID-NA','NBL/MX.DYNAMIC_ROUTING_VALID-NO')
        ) 
and s.start_time > (SYSDATE-3) 
and s.start_time < (SYSDATE+10) 
AND S.DOMAIN_NAME = 'NBL' 
AND S.user_defined1_icon_gid is null



--BS_NOT_TENDERED_MX

select s.shipment_gid 
from shipment s 
where exists(
                select 1 
                from TENDER_COLLABORATION tc, TENDER_COLLABORATION_STATUS tcs, TENDER_COLLAB_SERVPROV tcc 
                where tc.i_transaction_no = tcs.i_transaction_no 
                and tc.i_transaction_no = tcc.i_transaction_no 
                and tc.shipment_gid = s.shipment_gid 
                AND tcs.status_value_gid not in ('NBL/MX.TENDER.SECURE RESOURCES_DECLINED','NBL/MX.TENDER.SECURE RESOURCES_WITHDRAWN','NBL/MX.TENDER.SECURE RESOURCES_TIMED OUT','NBL/MX.TENDER.SECURE RESOURCES_ACCEPTED') 
                AND TCC.SERVPROV_GID = S.SERVPROV_GID 
                AND TC.RATE_GEO_GID != 'NBL/MX.DYNAMICROUTING_RR' and rownum = 1
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
                AND drg2.status_value_gid != 'NBL/MX.DYNAMIC_ROUTING_STATUS_CAPACITY_AVAILABLE'
            ) 
and S.USER_DEFINED1_ICON_GID IS NULL 
and (s.start_time between (SYSDATE-1) and (SYSDATE+20))
