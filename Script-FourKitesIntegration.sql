
[829349933] [SQL_STATEMENT] 
update shipment set end_time = (
    select appointment_delivery 
    from shipment_stop 
    where stop_num in (
                            select max(stop_num) 
                            from shipment_stop 
                            where stop_type='D' 
                            and shipment_gid = ?
                        ) 
        and shipment_gid = ? 
        and appointment_delivery is not null
    ) 
        where shipment_gid= ?;
        
        
        
         [NBL.NB52691436, NBL.NB52691436, NBL.NB52691436] 
         Cannot update the record. 
         A required column has not been set. 
         java.sql.SQLException:  ORA-01407: cannot update (???) to NULL


select max(stop_num) 
from shipment_stop 
where stop_type='D' 
and shipment_gid = 'NBL.NB52691436'


select appointment_delivery 
from shipment_stop 
where stop_num in (
                    select max(stop_num) 
                    from shipment_stop 
                    where stop_type='D' 
                    and shipment_gid = 'NBL.NB52691436'
                    ) 
and shipment_gid = 'NBL.NB52691436' 
and appointment_delivery is not null

/*
Funciono
NB52691926

No Funciono
NB52691436
*/



NB52691436,NB52691433,NB52691495,NB52691501 




