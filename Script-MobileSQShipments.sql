select sh.shipment_gid 
from SHIPMENT sh, SHIPMENT_TYPE stp 
where (sh.shipment_gid=?) 
and (sh.perspective='B') 
and (sh.shipment_type_gid=stp.shipment_type_gid) 
and (stp.shipment_type_xid!='NON FREIGHT RELATED CHARGE') 
and (sh.domain_gid='NBL/MX') 
and (sh.shipment_gid in (select ss1.shipment_gid 
                        from SHIPMENT_STATUS ss1, STATUS_VALUE sv 
                        where (ss1.status_value_gid = sv.status_value_gid) 
                        and (sv.status_value_xid in ('ENROUTE_DELAYED','ENROUTE_DIVERTED','ENROUTE_ENROUTE','ENROUTE_MERGED','ENROUTE_PARTIAL','ENROUTE_UNLOADED - FULL','ENROUTE_UNLOADED - PARTIAL')))) 
order by sh.start_time desc 



select sh.shipment_gid 
from SHIPMENT sh, SHIPMENT_TYPE stp 
where (sh.perspective='B')  
and (sh.shipment_type_gid=stp.shipment_type_gid)  
and (stp.shipment_type_xid!='NON FREIGHT RELATED CHARGE')  
and (sh.domain_name='NBL/MX') 
and (sh.shipment_gid in (select ss1.shipment_gid 
                        from SHIPMENT_STATUS ss1, STATUS_VALUE sv 
                        where (ss1.status_value_gid = sv.status_value_gid)  
                        and (sv.status_value_xid in ('ENROUTE_DELAYED','ENROUTE_DIVERTED','ENROUTE_ENROUTE','ENROUTE_MERGED','ENROUTE_PARTIAL','ENROUTE_UNLOADED - FULL','ENROUTE_UNLOADED - PARTIAL')))
                        ) 
order by sh.start_time desc 





------------------------Originals------------------------------



select sh.shipment_gid 
from SHIPMENT sh, SHIPMENT_TYPE stp 
where (sh.shipment_gid=?) 
and (sh.perspective='B') 
and (sh.shipment_type_gid=stp.shipment_type_gid) 
and (stp.shipment_type_xid!='NON FREIGHT RELATED CHARGE') 
and (sh.shipment_gid in (
                        select ss1.shipment_gid 
                        from SHIPMENT_STATUS ss1, STATUS_VALUE sv1 
                        where (ss1.status_value_gid = sv1.status_value_gid) 
                        and (sv1.status_value_xid in ('DISPATCH_CONFIRMED','DISPATCH_MOBILE CONFIRMED')))) 
and (sh.shipment_gid in (select ss2.shipment_gid 
                        from SHIPMENT_STATUS ss2, STATUS_VALUE sv2 
                        where (ss2.status_value_gid = sv2.status_value_gid) 
                        and (sv2.status_value_xid='ENROUTE_NOT STARTED'))) 
order by sh.start_time desc


select sh.shipment_gid 
from SHIPMENT sh, SHIPMENT_TYPE stp 
where (sh.perspective='B') 
and (sh.shipment_type_gid=stp.shipment_type_gid) 
and (stp.shipment_type_xid!='NON FREIGHT RELATED CHARGE') 
and (sh.shipment_gid in (
                            select ss1.shipment_gid 
                            from SHIPMENT_STATUS ss1, STATUS_VALUE sv1 
                            where (ss1.status_value_gid = sv1.status_value_gid) 
                            and (sv1.status_value_xid in ('DISPATCH_CONFIRMED','DISPATCH_MOBILE CONFIRMED'))
                        )
    ) 
and (sh.shipment_gid in (
                            select ss2.shipment_gid 
                            from SHIPMENT_STATUS ss2, STATUS_VALUE sv2 
                            where (ss2.status_value_gid = sv2.status_value_gid) 
                            and (sv2.status_value_xid='ENROUTE_NOT STARTED')
                        )
    ) 
order by sh.start_time desc