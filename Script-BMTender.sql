--BS_NOT_TENDERED

select s.shipment_gid 
from shipment s 
where exists(
            select 1 
            from TENDER_COLLABORATION tc, TENDER_COLLABORATION_STATUS tcs, TENDER_COLLAB_SERVPROV tcc 
            where tc.i_transaction_no = tcs.i_transaction_no 
            and tc.i_transaction_no = tcc.i_transaction_no 
            and tc.shipment_gid = s.shipment_gid 
            AND tcs.status_value_gid not in ('NBL.TENDER.SECURE RESOURCES_DECLINED','NBL.TENDER.SECURE RESOURCES_WITHDRAWN','NBL.TENDER.SECURE RESOURCES_TIMED OUT','NBL.TENDER.SECURE RESOURCES_ACCEPTED') 
            AND TCC.SERVPROV_GID = S.SERVPROV_GID 
            AND TC.RATE_GEO_GID != 'NBL.DYNAMICROUTING_RR' 
            and rownum = 1
) 
AND exists(
            select 1 
            from shipment_status drg 
            where s.shipment_gid = drg.shipment_gid 
            and drg.status_value_gid in ('NBL.SENT_TO_DR_NOT_SENT_INVALID','NBL.SENT_TO_DR_SENT','NBL.SENT_TO_DR_CANCELLED') 
            and drg.status_type_gid = 'NBL.SENT_TO_DR'
            ) 
and exists(
            select 1 
            from shipment_status drg2 
            where s.shipment_gid = drg2.shipment_gid 
            and drg2.status_type_gid = 'NBL.DYNAMIC_ROUTING_STATUS' 
            AND drg2.status_value_gid != 'NBL.DYNAMIC_ROUTING_STATUS_CAPACITY_AVAILABLE'
            ) 
and S.USER_DEFINED1_ICON_GID IS NULL 
and (s.start_time between (SYSDATE-1) 
and (SYSDATE+20))



--BS_TENDER_FAILED_TIMEOUT

select s.shipment_gid 
from shipment s 
where exists(
                select distinct 1 
                from tender_collaboration tc, tender_collaboration_status tcs 
                where tc.i_transaction_no = tcs.i_transaction_no 
                and tc.shipment_gid = s.shipment_gid 
                AND tcs.status_value_gid = 'NBL.TENDER.SECURE RESOURCES_TENDERED'
            ) 
and exists(
                select 1 
                from shipment_status drg 
                where s.shipment_gid = drg.shipment_gid 
                and drg.status_type_gid = 'NBL.SENT_TO_DR' 
                and drg.status_value_gid in ('NBL.SENT_TO_DR_NOT_SENT_INVALID','NBL.SENT_TO_DR_SENT','NBL.SENT_TO_DR_CANCELLED') 
            ) 
and exists(
                select 1
                from shipment_status drg2 
                where s.shipment_gid = drg2.shipment_gid 
                and drg2.status_type_gid = 'NBL.DYNAMIC_ROUTING_VALID' 
                and drg2.status_value_gid in ('NBL.DYNAMIC_ROUTING_VALID-NA','NBL.DYNAMIC_ROUTING_VALID-NO')
            ) 
and s.start_time > (SYSDATE-3) 
and s.start_time < (SYSDATE+10) 
AND S.DOMAIN_NAME = 'NBL' 
AND S.user_defined1_icon_gid is null
