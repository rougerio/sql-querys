SELECT I_TRANSMISSION_NO, ShipmentGid, EventDate, TZ, TZOffset, EventEndDate, EndTZ, EndTZOffset
FROM (
        SELECT ITRAC.I_TRANSACTION_NO, ITRAC.I_TRANSMISSION_NO/*, ITRAC.XML_BLOB*/, ITRAC.OBJECT_GID,
            EXTRACTVALUE(XMLTYPE(REPLACE(REPLACE(ITRAC.XML_BLOB, 'otm:', ''), ' xmlns:otm="http://xmlns.oracle.com/apps/otm"','')),
            '/ShipmentStatus/ShipmentGid/Gid/Xid') ShipmentGid,
            EXTRACTVALUE(XMLTYPE(REPLACE(REPLACE(ITRAC.XML_BLOB, 'otm:', ''), ' xmlns:otm="http://xmlns.oracle.com/apps/otm"','')),
            '/ShipmentStatus/EventDt/GLogDate') EventDate, 
            EXTRACTVALUE(XMLTYPE(REPLACE(REPLACE(ITRAC.XML_BLOB, 'otm:', ''), ' xmlns:otm="http://xmlns.oracle.com/apps/otm"','')),
            '/ShipmentStatus/EventDt/TZId') TZ, 
            EXTRACTVALUE(XMLTYPE(REPLACE(REPLACE(ITRAC.XML_BLOB, 'otm:', ''), ' xmlns:otm="http://xmlns.oracle.com/apps/otm"','')),
            '/ShipmentStatus/EventDt/TZOffset') TZOffset,
            EXTRACTVALUE(XMLTYPE(REPLACE(REPLACE(ITRAC.XML_BLOB, 'otm:', ''), ' xmlns:otm="http://xmlns.oracle.com/apps/otm"','')),
            '/ShipmentStatus/EventEndDate/GLogDate') EventEndDate,
            EXTRACTVALUE(XMLTYPE(REPLACE(REPLACE(ITRAC.XML_BLOB, 'otm:', ''), ' xmlns:otm="http://xmlns.oracle.com/apps/otm"','')),
            '/ShipmentStatus/EventEndDate/TZId') EndTZ, 
            EXTRACTVALUE(XMLTYPE(REPLACE(REPLACE(ITRAC.XML_BLOB, 'otm:', ''), ' xmlns:otm="http://xmlns.oracle.com/apps/otm"','')),
            '/ShipmentStatus/EventEndDate/TZOffset') EndTZOffset
        FROM I_TRANSMISSION ITMS INNER JOIN
        I_TRANSACTION ITRAC ON ITMS.I_TRANSMISSION_NO = ITRAC.I_TRANSMISSION_NO
        WHERE 1 = 1
        AND ITRAC.ELEMENT_NAME = 'ShipmentStatus'
        AND ITMS.INSERT_DATE >= TO_DATE('02/03/2026', 'DD/MM/YYYY')
        AND ITMS.SENDER_TRANSMISSION_ID LIKE 'FOURKITES_MX%'
        AND ITRAC.STATUS = 'ERROR'
        --AND ITMS.I_TRANSMISSION_NO = 79133480
) T
ORDER BY I_TRANSMISSION_NO, ShipmentGid ASC

/*
/ShipmentStatus/EventDt/GLogDate
/ShipmentStatus/ShipmentRefnum/ShipmentRefnumValue
/ShipmentStatus/ServiceProviderAlias/ServiceProviderAliasQualifierGid/Gid/Xid
/ShipmentStatus/otm:ShipmentRefnum[1]/ShipmentRefnumValue
/ShipmentStatus/ShipmentGid/Gid/Xid
/ShipmentStatus/EventEndDate/GLogDate
/ShipmentStatus/EventEndDate/TZOffset
*/


Update user defined image icon2 CAR_SCHEDULED_APPT
UPDATE SHIPMENT SET user_defined2_icon_gid = 'NBL.CAR_SCHEDULED_APPT' WHERE SHIPMENT_GID = $GID

Update Pickup appointment time
Update shipment_stop s   set APPOINTMENT_PICKUP=  (select * from (select ies.EVENTDATE  from ss_status_history ssh, ie_shipmentstatus ies where ssh.shipment_gid = $GID and ssh.I_TRANSACTION_NO=ies.I_TRANSACTION_NO and ies.STATUS_CODE_GID='AA' and ssh.shipment_gid =s.shipment_gid order by ies.insert_date desc) where rownum=1 ) where s.shipment_gid =$GID and s.stop_type='P'

If - Updating the pickup appt to -2hrs due to time zone issue from fourkites 3TJ
Update shipment_stop s   set s.APPOINTMENT_PICKUP= s.APPOINTMENT_PICKUP-1/24  where s.shipment_gid = $gid and s.stop_type='P'

Pickup appointment received from FK
insert into shipment_remark (shipment_gid, remark_sequence, remark_qual_gid, remark_text, domain_name) select distinct s.shipment_gid, (select nvl(max(sr.REMARK_SEQUENCE),0) + 1 from shipment_remark sr where sr.shipment_gid = $gid),'NBL.FK_APPOINTMENT MANAGER', 'Pickup appointment received from FourKites' , s.domain_name from shipment_stop s where s.shipment_gid = $gid and s.stop_type = 'P' and s.appointment_pickup is not null

Insert PU_APPOINTMENT shipment remark
insert into shipment_remark (shipment_gid, remark_sequence, remark_qual_gid, remark_text, domain_name) select distinct s.shipment_gid, (select nvl(max(sr.REMARK_SEQUENCE),0) + 1 from shipment_remark sr where sr.shipment_gid = $gid),'NBL.PU_APPOINTMENT', to_char(UTC.GET_LOCAL_DATE(s.appointment_pickup, s.location_gid), 'YYYY-MM-DD HH24:MI:SS'), s.domain_name from shipment_stop s where s.shipment_gid = $gid and s.stop_type ='P' and s.appointment_pickup is not null

Insert PU_APPOINTMENT shipment refnum
INSERT INTO shipment_refnum (shipment_gid,shipment_refnum_qual_gid,shipment_refnum_value,domain_name) select shipment_gid, remark_qual_gid, remark_text, domain_name from shipment_remark s where shipment_gid = $gid and remark_qual_gid = 'NBL.PU_APPOINTMENT'and exists( select 1 from shipment_remark r where r.remark_qual_gid = 'NBL.PU_APPOINTMENT' and r.shipment_gid = s.shipment_gid)

Update stop 1 planned time with pickup appointment time
update shipment_stop set planned_arrival=appointment_pickup, estimated_arrival=appointment_pickup, IS_FIXED_ARRIVAL='Y', planned_departure=appointment_pickup  , ESTIMATED_DEPARTURE=appointment_pickup where shipment_gid = $gid and stop_num= 1 and appointment_pickup is not null

insert delivery stop information into SHIPMENT_REMARK
INSERT INTO shipment_remark (shipment_gid, remark_sequence, remark_qual_gid, remark_text, domain_name) SELECT DISTINCT s.shipment_gid, 09905+s.stop_num, 'NBL.DELIVERY_STOP_' ||s.stop_num, TO_CHAR(UTC.GET_LOCAL_DATE(S.APPOINTMENT_DELIVERY, s.location_gid), 'YYYY-MM-DD HH24:MI')||'---'||l.location_xid||', ' ||l.city||', '||l.province_code||', '||l.postal_code, s.domain_name FROM shipment_stop s, location l WHERE s.shipment_gid = $gid AND s.stop_num != 1 AND s.location_gid = l.location_gid

Update delivery appointment on stop 2
UPDATE shipment_stop SET planned_arrival = appointment_delivery, estimated_arrival = appointment_delivery, IS_FIXED_DEPARTURE = 'Y', planned_departure = appointment_delivery , ESTIMATED_DEPARTURE = appointment_delivery WHERE shipment_gid = $gid AND stop_type = 'D' AND appointment_delivery IS NOT NULL