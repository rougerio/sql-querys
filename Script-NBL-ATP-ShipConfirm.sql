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
    t2.lpn
    ,t2.pedimento_flag
    ,t2.pedimento_number
    ,t2.pedimento_status
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
    --t2.process_msg
from nbl_shipconfirm_stg_hdr t1 left join 
nbl_shipconfirm_stg_lines t2 on t1.header_id = t2.header_id
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
--and TRIP_ID in ('5001000082')
--and trip_id in ('5001000013','5001000019','5001000038','5001000034','5001000035','5001000036','5001000037')
--AND t2.PROCESS_STATUS = 'Grouped'
--AND T2.ITEM_NUMBER='SMV20Z24PDSMCH';
and t1.SO_NUMBER='40062027'
--AND DELIEVERY_ID IN ('')
--AND T1.HEADER_ID ='1297'
--AND T2.PROCESS_STATUS ='Grouped'
--AND T2.BATCH_ID ='20251122090034111'
--and t2.pedimento_flag = 'Y'
group by
t1.creation_date,
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
    t2.pedimento_flag
    ,t2.pedimento_number
    ,t2.pedimento_status
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



SELECT distinct
       h.delivery_id
      ,h.creation_date
      ,l.lot_number
      ,l.lpn
      ,l.status
      ,l.pedimento_flag
      ,l.pedimento_number
      ,l.pedimento_status
FROM
    nbl_shipconfirm_stg_lines l,
    nbl_shipconfirm_stg_hdr   h
WHERE 1= 1
    AND h.creation_date              > trunc(sysdate)

    AND l.pedimento_number          is not null
    --
    AND h.ship_from_country          = 'US'
    AND h.ship_to_country            = 'MX'
order by 1,4;


SELECT distinct
       h.delivery_id
      ,h.creation_date
      ,l.lot_number
      ,l.lpn
      ,l.status
      ,l.pedimento_flag
      ,l.pedimento_number
      ,l.pedimento_status
FROM
    nbl_shipconfirm_stg_lines l,
    nbl_shipconfirm_stg_hdr   h
WHERE 1= 1
AND  l.header_id = h.header_id
AND l.lpn = '00000275411903689636'
order by 1,4;
