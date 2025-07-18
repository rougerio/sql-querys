select s.shipment_gid, s.start_time, sysdate - 0.5/24, sysdate,
       cast(from_tz(cast(s.start_time as timestamp), 'CST') at time zone 'UTC' as date)
from shipment s 
where user_defined1_icon_gid <> 'NBL.SHIP_CONFIRMED' 
--and start_time < sysdate 
and not exists (
    select 1 from shipment_remark sr 
    where sr.shipment_gid = s.shipment_gid and remark_qual_gid = 'NBL.SHIP_DATE'
    ) 
--and s.start_time > sysdate - 30
and domain_name = 'NBL/MX'

/*
 Start Time se guarda la fecha en UTC

 */
select s.shipment_gid, s.start_time, sysdate, sysdate - 30, sysdate - 0.5/24,
       cast(from_tz(cast(s.start_time as timestamp), 'CST') at time zone 'UTC' as date)
from shipment s
where s.SHIPMENT_GID = 'NBL/MX.MX51009967'

select s.shipment_gid, s.start_time, sysdate, sysdate - 30, sysdate - 0.5/24
from shipment s
where s.SHIPMENT_GID = 'NBL/MX.MX51009967'
/*
Si la fecha de Star Time es mayor a la fecha actual y no tiene Ship Confimed y Ship Date es un Missed Pick UPDATE
30 MIN

*/

select s.shipment_gid from shipment s where user_defined1_icon_gid <> 'NBL.SHIP_CONFIRMED' and not exists (select 1 from shipment_remark sr where sr.shipment_gid = s.shipment_gid and remark_qual_gid = 'NBL.SHIP_DATE') and s.start_time > sysdate - 30 and domain_name = 'NBL/MX'



select s.shipment_gid from shipment s where user_defined1_icon_gid <> 'NBL.SHIP_CONFIRMED' and start_time < sysdate and not exists (select 1 from shipment_remark sr where sr.shipment_gid = s.shipment_gid and remark_qual_gid = 'NBL.SHIP_DATE') and s.start_time > sysdate - 30 and domain_name = 'NBL/MX'



SELECT CURRENT_TIMESTAMP at time zone 'UTC', CAST(CURRENT_DATE AS TIMESTAMP),
       SYS_EXTRACT_UTC(CAST (CURRENT_DATE AS TIMESTAMP))--, FROM_TZ(CAST('2025-01-17T17:00:00' AS TIMESTAMP), 'CST')
FROM DUAL;

ALTER SESSION SET NLS_DATE_FORMAT = 'dd/mm/yyyy hh24:mi:ss';

select sysdate - 1, --(subtract 1 day),
        sysdate - 1/24, --(subtract 1 hour,)
        sysdate - 0.5/24, --(subtract 30 minutes),
        --sysdate - 0.5 * 2/ 24 * 2 = sysdate - 1/48, 
        sysdate 
from dual;

--Query Final
--BS_MISSED_PICKUPS_MX

select s.shipment_gid 
from shipment s 
where user_defined1_icon_gid <> 'NBL.SHIP_CONFIRMED' 
and not exists (
                select 1 
                from shipment_remark sr 
                where sr.shipment_gid = s.shipment_gid 
                and remark_qual_gid = 'NBL.SHIP_DATE'
                ) 
and s.start_time > sysdate - 0.5/24
and domain_name = 'NBL/MX'

select s.shipment_gid, s.start_time, sysdate - 0.5/24
from shipment s 
where user_defined1_icon_gid <> 'NBL.SHIP_CONFIRMED' 
and s.start_time > sysdate - 0.5/24
and domain_name = 'NBL/MX'

