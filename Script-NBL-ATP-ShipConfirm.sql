select t1.creation_date,
       t1.header_id,
       t1.batch_id,
       t1.ship_from_org_id,
       t1.trip_id,
       t1.delivery_id,
       t1.so_number,
       t1.purchase_order_number,
       t1.scac,
       t1.bol_number,
       t1.validation_status,
       t1.status_code,
       t1.status_note,
       t1.pick_wave_status,
       t1.shipconfirm_status,
       t1.check_in_date,
       t1.check_out_date,
       t1.seal_number,
       t1.ship_from_name,
    --t1.ship_to_name,
    --t2.line_id,
    --t2.so_line_id,
    --t2.ordered_qty,
       t2.item_number,
       t2.shipped_qty,
       t2.uom_code,
       t2.lot_number,
       t2.lpn,
       t2.pedimento_flag,
       t2.pedimento_number,
       t2.pedimento_status
    --t2.available_to_reserve,
    --t2.status,
    --t2.process_status,
    --t2.crt_reservation_status,
    --t2.batch_id,
    --t2.total_line_shipped_qty,
    --t2.crt_reservation_id,
    --t2.crt_reservation_response,
    --t2.mfg_date,
    --t2.exp_date,
    --t1.process_msg
  from nbl_shipconfirm_stg_hdr t1
  left join nbl_shipconfirm_stg_lines t2
on t1.header_id = t2.header_id
 where 1 = 1 
--and TRIP_ID In ('53617927')
--'53615300',
--'53615284',
--'53615303')
--'5001000066'--,
--'5001000067'--,
--'5001000064'--,
--'5001000065',
--'5001000063'
--)*/
--and t1.creation_date = TO_DATE('2025-12-09','YYYY-MM-DD')
--AND t2.LPN in ('00000275411903692674')
   and trip_id in ( '5001001033' )
--and trip_id in ('5001000013','5001000019','5001000038','5001000034','5001000035','5001000036','5001000037')
--AND t2.PROCESS_STATUS = 'Grouped'
--AND T2.ITEM_NUMBER='SMV20Z24PDSMCH';
--and t1.SO_NUMBER='40062027'
--AND DELIEVERY_ID IN ('')
--AND T1.HEADER_ID ='1297'
--AND T2.PROCESS_STATUS ='Grouped'
--AND T2.BATCH_ID ='20251122090034111'
--and t2.pedimento_flag = 'Y'
 group by t1.creation_date,
          t1.header_id,
          t1.batch_id,
          t1.ship_from_org_id,
          t1.trip_id,
          t1.delivery_id,
          t1.so_number,
          t1.purchase_order_number,
          t1.scac,
          t1.bol_number,
          t1.validation_status,
          t1.status_code,
          t1.status_note,
          t1.pick_wave_status,
          t1.shipconfirm_status,
          t1.check_in_date,
          t1.check_out_date,
          t1.seal_number,
          t1.ship_from_name,
    --t1.ship_to_name,
          t2.item_number,
          t2.item_number,
          t2.shipped_qty,
          t2.uom_code,
          t2.lot_number,
          t2.lpn,
          t2.pedimento_flag,
          t2.pedimento_number,
          t2.pedimento_status
 order by t1.creation_date desc;

/*
Pedimento LPN               > MA LPN
00000275411903689636 > 00400275411104719390 > 25  40  3628   5004766
00000275411903689865 > 00400275411104719406 > 25  40  3628   5004760
00000275411903690168 > 00400275411104719413 > 25  40  3628   5004756
0000275411903690182 > 00400275411104719420 > 25  40  3628   5004756
 */
/*

('5001000013',
'5001000019',
'5001000038',
'5001000034',
'5001000035',
'5001000036')


000002754119036804356131229
*/

select distinct h.delivery_id,
                h.creation_date,
                l.lot_number,
                l.lpn,
                l.status,
                l.pedimento_flag,
                l.pedimento_number,
                l.pedimento_status
  from nbl_shipconfirm_stg_lines l,
       nbl_shipconfirm_stg_hdr h
 where 1 = 1
   and h.creation_date > trunc(sysdate)
   and l.pedimento_number is not null
    --
   and h.ship_from_country = 'US'
   and h.ship_to_country = 'MX'
 order by 1,
          4;


select distinct h.delivery_id,
                h.creation_date,
                l.lot_number,
                l.lpn,
                l.status,
                l.pedimento_flag,
                l.pedimento_number,
                l.pedimento_status
  from nbl_shipconfirm_stg_lines l,
       nbl_shipconfirm_stg_hdr h
 where 1 = 1
   and l.header_id = h.header_id
   and l.lpn = '00200275412105674431'
 order by 1,
          4;


------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------     Query para errores   ------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------

select ship_from_org_id,
       trip_id,
    --SHIP_FROM_NAME
    --MONTH
    --,DAY
    --,HOUR
       count(*),
       error_msg,
       creation_date
  from (
   select ship_from_org_id,
          trip_id,
          delivery_id,
          so_number,
          purchase_order_number,
          transportation_shipment_id,
          ship_from_name,
          status_code,
          status_note,
          remarks,
          error_msg,
          source_system,
          to_timestamp(to_char(
             creation_date,
             'DD-MON-YY HH12.MI.SS'
          ),
                       'DD-MON-RR HH.MI.SS.FF AM') creation_date,
          extract(year from to_timestamp(to_char(
             creation_date,
             'DD-MON-YY HH12.MI.SS'
          ),
                    'DD-MON-RR HH.MI.SS.FF AM')) year,
          extract(month from to_timestamp(to_char(
             creation_date,
             'DD-MON-YY HH12.MI.SS'
          ),
                    'DD-MON-RR HH.MI.SS.FF AM')) month,
          extract(day from to_timestamp(to_char(
             creation_date,
             'DD-MON-YY HH12.MI.SS'
          ),
                    'DD-MON-RR HH.MI.SS.FF AM')) day,
          extract(hour from to_timestamp(to_char(
             creation_date,
             'DD-MON-YY HH12.MI.SS'
          ),
                    'DD-MON-RR HH.MI.SS.FF AM')) hour,
          8 ship_from_org,
          release_rule,
          validation_status,
          pick_wave_status,
          pick_wave_batchname,
          pickslip_status,
          pickslip_response,
          shipconfirm_status,
          shipconfirm_response,
          subinventory,
          row_number()
          over(partition by trip_id
               order by creation_date desc
          ) as rn
     from xxnbl_intg.nbl_shipconfirm_stg_hdr
    where ship_from_org_id in ( '300000008059577',
                                '300000008059641',
                                '300000008059653',
                                '300000084227497',
                                '300000086880154',
                                '300000037236624' )
    order by trip_id
)
 where 1 = 1
   and rn = 1
   and ( error_msg is not null
    or status_note = 'UNPROCESSED' )
    --AND ERROR_MSG = 'Release Rule Not Found'
 group by error_msg,
          ship_from_org_id,
          trip_id,
          creation_date;


---------------------------------Lines Old---------------------------------

select ship_from_org_id,
       trip_id,
       count(*),
       error_msg,
       line_error_msg,
       creation_date,
       line_id,
       line_number,
       lot_number
  from (
   select t1.ship_from_org_id,
          t1.trip_id,
          t1.delivery_id,
          t1.so_number,
          t1.purchase_order_number,
          t1.transportation_shipment_id,
          t1.ship_from_name,
          t1.status_code,
          t1.status_note,
          t1.remarks,
          t1.error_msg,
          t1.source_system,
          t2.line_id,
          t2.line_number,
          t2.lot_number,
          to_timestamp(to_char(
             t1.creation_date,
             'DD-MON-YY HH12.MI.SS'
          ),
                       'DD-MON-RR HH.MI.SS.FF AM') creation_date,
          extract(year from to_timestamp(to_char(
             t1.creation_date,
             'DD-MON-YY HH12.MI.SS'
          ),
                    'DD-MON-RR HH.MI.SS.FF AM')) year,
          extract(month from to_timestamp(to_char(
             t1.creation_date,
             'DD-MON-YY HH12.MI.SS'
          ),
                    'DD-MON-RR HH.MI.SS.FF AM')) month,
          extract(day from to_timestamp(to_char(
             t1.creation_date,
             'DD-MON-YY HH12.MI.SS'
          ),
                    'DD-MON-RR HH.MI.SS.FF AM')) day,
          extract(hour from to_timestamp(to_char(
             t1.creation_date,
             'DD-MON-YY HH12.MI.SS'
          ),
                    'DD-MON-RR HH.MI.SS.FF AM')) hour,
          t1.ship_from_org,
          t1.release_rule,
          t1.validation_status,
          t1.pick_wave_status,
          t1.pick_wave_batchname,
          t1.pickslip_status,
          t1.pickslip_response,
          t1.shipconfirm_status,
          t1.shipconfirm_response,
          t1.subinventory,
          t2.error_msg line_error_msg,
          row_number()
          over(partition by t1.trip_id
               order by t1.creation_date desc
          ) as rn
     from xxnbl_intg.nbl_shipconfirm_stg_hdr t1
     left join nbl_shipconfirm_stg_lines t2
   on t1.header_id = t2.header_id
    where t1.ship_from_org_id in ( '300000008059577',
                                   '300000008059641',
                                   '300000008059653',
                                   '300000084227497',
                                   '300000086880154',
                                   '300000037236624' )
    order by t1.trip_id
)
 where 1 = 1
   and rn = 1
   and ( error_msg is not null
    or status_note = 'UNPROCESSED' )
    --AND ERROR_MSG = 'Release Rule Not Found'
 group by error_msg,
          line_error_msg,
          ship_from_org_id,
          trip_id,
          creation_date,
          line_id,
          line_number,
          lot_number;



--5001000289
----------------------------------Query Lines----------------------------------
select ship_from_org_id,
       trip_id,
       error_msg,
       line_error_msg,
       creation_date,
       line_id,
       line_number,
       lot_number,
       item_number,
       item_id,
       rn
  from (
   select t1.ship_from_org_id,
          t1.trip_id,
          t1.delivery_id,
          t1.so_number,
          t1.purchase_order_number,
          t1.transportation_shipment_id,
          t1.ship_from_name,
          t1.status_code,
          t1.status_note,
          t1.remarks,
          t1.error_msg,
          t1.source_system,
          t2.line_id,
          t2.line_number,
          t2.lot_number,
          to_timestamp(to_char(
             t1.creation_date,
             'DD-MON-YY HH12.MI.SS'
          ),
                       'DD-MON-RR HH.MI.SS.FF AM') creation_date,
          extract(year from to_timestamp(to_char(
             t1.creation_date,
             'DD-MON-YY HH12.MI.SS'
          ),
                    'DD-MON-RR HH.MI.SS.FF AM')) year,
          extract(month from to_timestamp(to_char(
             t1.creation_date,
             'DD-MON-YY HH12.MI.SS'
          ),
                    'DD-MON-RR HH.MI.SS.FF AM')) month,
          extract(day from to_timestamp(to_char(
             t1.creation_date,
             'DD-MON-YY HH12.MI.SS'
          ),
                    'DD-MON-RR HH.MI.SS.FF AM')) day,
          extract(hour from to_timestamp(to_char(
             t1.creation_date,
             'DD-MON-YY HH12.MI.SS'
          ),
                    'DD-MON-RR HH.MI.SS.FF AM')) hour,
          t1.ship_from_org,
          t1.release_rule,
          t1.validation_status,
          t1.pick_wave_status,
          t1.pick_wave_batchname,
          t1.pickslip_status,
          t1.pickslip_response,
          t1.shipconfirm_status,
          t1.shipconfirm_response,
          t1.subinventory,
          t2.error_msg line_error_msg,
          t2.item_number,
          t2.item_id,
          row_number()
          over(partition by t1.trip_id
               order by t1.creation_date desc
          ) as rn
     from xxnbl_intg.nbl_shipconfirm_stg_hdr t1
     left join nbl_shipconfirm_stg_lines t2
   on t1.header_id = t2.header_id
    where t1.ship_from_org_id in ( '300000008059577',
                                   '300000008059641',
                                   '300000008059653',
                                   '300000084227497',
                                   '300000086880154',
                                   '300000037236624' )
      and ( t1.error_msg is not null
       or t2.error_msg is not null )
      --and t1.trip_id = '5001000289'
    order by t1.trip_id
) t
 where 1 = 1
--and rn = 1
   and ( line_error_msg is not null
    or status_note = 'UNPROCESSED' )
 group by rn,
          error_msg,
          line_error_msg,
          ship_from_org_id,
          trip_id,
          creation_date,
          line_id,
          line_number,
          lot_number,
          item_number,
          item_id
 order by trip_id;


select t2.*
  from xxnbl_intg.nbl_shipconfirm_stg_hdr t1
  left join nbl_shipconfirm_stg_lines t2
on t1.header_id = t2.header_id
 where t1.trip_id = '5001001033'
 order by t2.creation_date desc
--and t2.creation_date = to_date('2026-01-12','YYYY-MM-DD')
 ;