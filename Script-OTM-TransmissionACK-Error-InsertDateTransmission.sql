----------------Segundo Query--------------------------------
select *
  from (
   select i_transmission_no,
          object_gid,
          external_status,
          element_name,
          ack_status,
          ack_reason,
          ref_transaction_no,
          rn
     from (
      select distinct itn.i_transmission_no,
                      itn.object_gid,
                      itm.external_status,
                      itn.element_name,
                      iack.ack_status,
                      iack.ack_reason,
                      iack.ref_transaction_no,
                      row_number()
                      over(partition by itn.object_gid
                           order by itn.insert_date asc
                      ) as rn
        from i_transaction itn
       inner join i_transmission itm
      on itn.i_transmission_no = itm.i_transmission_no
       inner join i_transmission_ack iack
      on itn.i_transmission_no = iack.i_transmission_no
       where itm.is_inbound = 'N'
         and itm.insert_date > sysdate - 8 / 24
         and itn.element_name = 'PlannedShipment'
         and itm.external_system_gid in ( 'NBL.XXNBLWSHRECEIVEPSHIPMENTFROMOTM_V63' )
         and iack.ack_status != 'IN PROGRESS'
         and itn.transaction_code != 'D'
        --AND IACK.ACK_REASON !='Processing begun'
   ) t
    where rn = 1
) s
 where ack_status = 'ERROR';


/*
'NBL.NB54131733'
*/