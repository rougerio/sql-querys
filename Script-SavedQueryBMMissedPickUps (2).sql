select s.shipment_gid, s.start_time, sysdate - 30, sysdate,  new_time(sysdate, 'CST', 'GMT')

from shipment s 
where user_defined1_icon_gid <> 'NBL.SHIP_CONFIRMED' 
--and start_time < sysdate 
and not exists (
    select 1 from shipment_remark sr 
    where sr.shipment_gid = s.shipment_gid and remark_qual_gid = 'NBL.SHIP_DATE'
    ) 
and s.start_time > sysdate - 30 and domain_name = 'NBL/MX'

/*
Si la fecha de Star Time es mayor a la fecha actual y no tiene Ship Confimed y Ship Date es un Missed Pick UPDATE
30 MIN

*/

select s.shipment_gid from shipment s where user_defined1_icon_gid <> 'NBL.SHIP_CONFIRMED' and not exists (select 1 from shipment_remark sr where sr.shipment_gid = s.shipment_gid and remark_qual_gid = 'NBL.SHIP_DATE') and s.start_time > sysdate - 30 and domain_name = 'NBL/MX'



select s.shipment_gid from shipment s where user_defined1_icon_gid <> 'NBL.SHIP_CONFIRMED' and start_time < sysdate and not exists (select 1 from shipment_remark sr where sr.shipment_gid = s.shipment_gid and remark_qual_gid = 'NBL.SHIP_DATE') and s.start_time > sysdate - 30 and domain_name = 'NBL/MX'