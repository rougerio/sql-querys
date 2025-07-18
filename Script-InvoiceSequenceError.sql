select distinct ins.shipment_gid shp,
inv.invoice_gid inv_1,
invs.status_value_gid stat,
inv.lineitem_seq_no seq,
inv.accessorial_code_gid acc,
round(inv.freight_charge,2) FC,
round(inv.freight_charge_base,2) FCB,
round(inv.attribute_number1,2) org,
round(inv.attribute_number2,2) diff,
inv.update_user,
to_char(inv.update_date,'YYYYMMDDHH24MISS') 
updatedt,to_char(inv.insert_date,'YYYYMMDDHH24MISS') InsertDt,
inv.insert_user,
invs.status_type_gid
from invoice_lineitem inv , 
invoice_shipment ins, 
invoice_status invs 
where inv.invoice_gid = ins.invoice_gid 
and invs.invoice_gid = inv.invoice_gid 
and invs.status_type_gid = 'NBL/MX.APPROVAL' 
--and shipment_gid in ('NBL/MX.MX24080443','NBL/MX.MX24077970') 
and shipment_gid in ('NBL/MX.MX24080443','NBL/MX.MX24077970')
order by shipment_gid,stat



20250120-0173
20241227-0072


MX24080443
MX24077970


1332116378
----------------------------------------------------------------------------------------------------------------------------

SELECT s.shipment_gid
FROM   shipment_remark SR,
       shipment s
WHERE  s.shipment_gid LIKE 'NBL.NB5%'
       AND sr.remark_qual_gid = 'NBL.DELIVERY_STOP_2'
       AND To_char(utc.Get_local_date(end_time, dest_location_gid), 'YYYY-MM-DD HH24:MI') != (SELECT Substr (remark_text, 1, 16) FROM shipment_remark WHERE  sr.remark_qual_gid = remark_qual_gid AND shipment_gid = s.shipment_gid)
AND sr.shipment_gid = S.shipment_gid
AND s.rate_offering_gid NOT LIKE 'NBL.CPU%'
AND s.shipment_type_gid != 'TONU SHIPMENT'
AND ( s.dest_location_gid LIKE 'NBL.CUS%'
      AND s.source_location_gid LIKE 'NBL.ORG%' )
AND To_char(SYSDATE, 'YYYY-MM-DD') >= '2025-01-28'
--order by s.shipment_gid


SELECT s.shipment_gid
FROM   shipment_remark sr INNER JOIN
       shipment s ON sr.shipment_gid = s.shipment_gid
WHERE  s.shipment_gid LIKE 'NBL.NB5%'
       AND sr.remark_qual_gid = 'NBL.DELIVERY_STOP_2'
AND s.rate_offering_gid NOT LIKE 'NBL.CPU%'
AND s.shipment_type_gid != 'TONU SHIPMENT'
AND ( s.dest_location_gid LIKE 'NBL.CUS%' AND s.source_location_gid LIKE 'NBL.ORG%' )
AND To_char(utc.Get_local_date(end_time, dest_location_gid), 'YYYY-MM-DD HH24:MI') != Substr (remark_text, 1, 16)
AND To_char(SYSDATE, 'YYYY-MM-DD') >= '2025-01-28'
--order by s.shipment_gid


SELECT s.shipment_gid
FROM   shipment_remark sr INNER JOIN
       shipment s ON sr.shipment_gid = s.shipment_gid
WHERE  s.shipment_gid LIKE 'NBL.NB5%'
       AND sr.remark_qual_gid = 'NBL.DELIVERY_STOP_2'
AND s.rate_offering_gid NOT LIKE 'NBL.CPU%'
AND s.shipment_type_gid != 'TONU SHIPMENT'
AND ( s.dest_location_gid LIKE 'NBL.CUS%' AND s.source_location_gid LIKE 'NBL.ORG%' )
AND To_char(utc.Get_local_date(end_time, dest_location_gid), 'YYYY-MM-DD HH24:MI') != Substr (remark_text, 1, 16)

----------------------------------------------------------------------------------------------------------------------------

SELECT 1 
FROM shipment_REMARK SR, shipment s ,shipment_stop ss
WHERE s.shipment_gid =$gid 
AND sr.REMARK_QUAL_gid = 'NBL.DELIVERY_STOP_2' 
AND TO_CHAR(UTC.GET_LOCAL_DATE(s.END_TIME,DEST_LOCATION_GID),'YYYY-MM-DD HH24:MI') != (
                    SELECT SUBSTR (sr.remark_text, 1, 16) 
                    FROM SHIPMENT_REMARK sr2 
                    WHERE sr.REMARK_QUAL_gid = sr2.REMARK_QUAL_gid 
                    and sr2.shipment_gid =s.shipment_gid ) 
and s.SHIPMENT_gid = Sr.SHIPMENT_GID 
and s.rate_offering_gid not like 'NBL.CPU%' 
and s.shipment_type_gid !='TONU SHIPMENT' 
and (s.dest_location_gid like 'NBL.CUS%' 
and s.SOURCE_location_gid like 'NBL.ORG%' ) 
and s.shipment_gid =ss.shipment_gid 
and ss.stop_type='D' 
and ss.stop_num = (
                        select max(stop_num) 
                        from shipment_stop 
                        where shipment_gid =s.shipment_Gid 
                ) 
and TO_CHAR(UTC.GET_LOCAL_DATE(ss.appointment_delivery,DEST_LOCATION_GID),'YYYY-MM-DD HH24:MI') != (
                                                                                                        SELECT SUBSTR (sr.remark_text, 1, 16) 
                                                                                                        FROM SHIPMENT_REMARK sr2 
                                                                                                        WHERE sr.REMARK_QUAL_gid = sr2.REMARK_QUAL_gid 
                                                                                                        and sr2.shipment_gid =s.shipment_gid 
                                                                                                    )

SELECT 1
FROM shipment_remark sr INNER JOIN
        shipment s ON sr.shipment_gid = s.shipment_gid INNER JOIN
        shipment_stop ss ON s.shipment_gid = ss.shipment_gid
WHERE s.shipment_gid = $gid 
AND sr.REMARK_QUAL_gid = 'NBL.DELIVERY_STOP_2' 
and s.rate_offering_gid not like 'NBL.CPU%' 
and s.shipment_type_gid !='TONU SHIPMENT' 
and (s.dest_location_gid like 'NBL.CUS%' and s.SOURCE_location_gid like 'NBL.ORG%' ) 
and ss.stop_type='D'
and To_char(utc.Get_local_date(s.end_time, s.dest_location_gid), 'YYYY-MM-DD HH24:MI') != SUBSTR (sr.remark_text, 1, 16)
and TO_CHAR(UTC.GET_LOCAL_DATE(ss.appointment_delivery,DEST_LOCATION_GID),'YYYY-MM-DD HH24:MI') != SUBSTR (sr.remark_text, 1, 16)
and ss.stop_num = (
                select max(stop_num) 
                from shipment_stop 
                where shipment_gid =s.shipment_Gid 
        ) 



--and To_char(s.end_time, 'YYYY-MM-DD') >= '2025-01-28'

--s.shipment_gid, ss.stop_num, SUBSTR (sr.remark_text, 1, 16) remark, to_char(s.end_time, 'YYYY-MM-DD HH24:MI'), to_char(ss.appointment_delivery, 'YYYY-MM-DD HH24:MI')
----------------------------------------------------------------------------------------------------------------------------
 
update shipment st set st.end_time = 
( 
    SELECT ss.Appointment_delivery 
    FROM shipment_remark sr INNER JOIN 
        shipment s ON sr.shipment_gid = s.shipment_gid INNER JOIN 
        shipment_stop ss ON s.shipment_gid = ss.shipment_gid 
    WHERE s.shipment_gid like 'NBL.NB5%' 
    and s.shipment_gid = $gid 
    AND sr.REMARK_QUAL_gid = 'NBL.DELIVERY_STOP_2' 
    and to_char(utc.Get_local_date(s.end_time, s.dest_location_gid), 'YYYY-MM-DD HH24:MI') != SUBSTR (sr.remark_text, 1, 16) 
    and s.rate_offering_gid not like 'NBL.CPU%' 
    and s.shipment_type_gid != 'TONU SHIPMENT'  
    and (s.dest_location_gid like 'NBL.CUS%' and s.SOURCE_location_gid like 'NBL.ORG%') 
    and ss.stop_type = 'D'  
    and s.transport_mode_gid = 'NBL.TRUCK'  
    and s.planned_transport_mode_gid = 'NBL.TRUCK'  
    and TO_CHAR(UTC.GET_LOCAL_DATE(ss.appointment_delivery,DEST_LOCATION_GID),'YYYY-MM-DD HH24:MI') != SUBSTR (sr.remark_text, 1, 16) 
    ) 
where st.shipment_gid=$gid
 


 update shipment st set st.end_time = (
    SELECT ss.Appointment_delivery 
    FROM shipment_REMARK SR, shipment s ,shipment_stop ss 
    WHERE s.shipment_gid like  'NBL.NB5%' 
    AND sr.REMARK_QUAL_gid = 'NBL.DELIVERY_STOP_2' 
    and TO_CHAR(UTC.GET_LOCAL_DATE(s.END_TIME,DEST_LOCATION_GID),'YYYY-MM-DD HH24:MI') != (
        SELECT SUBSTR (sr.remark_text, 1, 16) 
        FROM SHIPMENT_REMARK sr2
        WHERE sr.REMARK_QUAL_gid = sr2.REMARK_QUAL_gid 
        and sr2.shipment_gid =s.shipment_gid 
        ) and s.SHIPMENT_gid = Sr.SHIPMENT_GID 
    and s.rate_offering_gid not like 'NBL.CPU%' 
    and s.shipment_type_gid !='TONU SHIPMENT'  
    and (s.dest_location_gid like 'NBL.CUS%' and s.SOURCE_location_gid like 'NBL.ORG%') 
    and s.shipment_gid =ss.shipment_gid 
    and ss.stop_type='D' 
    and s.transport_mode_gid='NBL.TRUCK' 
    and s.planned_transport_mode_gid='NBL.TRUCK' 
    and TO_CHAR(UTC.GET_LOCAL_DATE(ss.appointment_delivery,DEST_LOCATION_GID),'YYYY-MM-DD HH24:MI') = (
        SELECT SUBSTR (sr.remark_text, 1, 16) 
        FROM SHIPMENT_REMARK sr2
        WHERE sr.REMARK_QUAL_gid = sr2.REMARK_QUAL_gid 
        and sr2.shipment_gid =s.shipment_gid 
        and s.shipment_gid =st.shipment_gid)
    )  where st.shipment_gid=$gid