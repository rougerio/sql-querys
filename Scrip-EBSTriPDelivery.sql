SELECT DELIVERY_ID, FTE_TRIP_ID, PICK_UP_STOP_ID
FROM WSH.WSH_DELIVERY_LEGS
WHERE DELIVERY_ID = '39371064';


--DELIVERY_DETAIL_ID
select trip_id
    ,sum(delivery_id_count)
    ,tp_plan_name
    ,attribute1
    ,attribute2
    ,carrier_id
    --,delivery_leg_id
    ,creation_date
from (
select wt.trip_id
    --,count(wdl.delivery_id) as delivery_id_count
    ,wdl.delivery_id
    ,wt.tp_plan_name
    ,wt.attribute1
    ,wt.attribute2
    ,wt.carrier_id
    --,wdl.delivery_leg_id
    ,wt.creation_date
from wsh_trips wt inner join 
    wsh_trip_stops wtp on wt.trip_id = wtp.trip_id inner join 
    wsh_trip_stops wtd on wt.trip_id = wtd.trip_id inner join
    wsh_delivery_legs wdl on wtp.stop_id = wdl.pick_up_stop_id and wtd.stop_id = wdl.drop_off_stop_id
where --wt.tp_plan_name = 'MX51087832' 
--wt.attribute1 not in ('S')
--and 
wt.tp_plan_name like 'MX%'
and wt.creation_date > TO_DATE('2025-10-30','YYYY-MM-DD')
group by wt.trip_id
,wdl.delivery_id
    ,wt.tp_plan_name
    ,wt.attribute1
    ,wt.attribute2
    ,wt.carrier_id
    --,wdl.delivery_leg_id
    ,wt.creation_date
ORDER BY wt.trip_id, wdl.delivery_id, wt.creation_date
) T
group by trip_id
    ,tp_plan_name
    ,attribute1
    ,attribute2
    ,carrier_id
    --,delivery_leg_id
    ,creation_date
    ;


/*
30 ca
59998473
MX51087832

59984395
MX51086809

*/
SELECT wt.*
/*wt.trip_id
      ,wt.name
      ,wt.status_code
      ,wt.vehicle_item_id
      ,wt.vehicle_number
      ,wt.carrier_id
      ,wt.ship_method_code
      ,wtp.stop_id                 pick_stop_id
      ,wtp.stop_location_id        pick_stop_location_id
      ,wtp.status_code             pick_status_code
      ,wtp.stop_sequence_number    pick_stop_sequence_number
      ,wtp.planned_arrival_date    pick_planned_arrival_date
      ,wtp.planned_departure_date  pick_planned_departure_date
      ,wtp.actual_arrival_date     pick_actual_arrival_date
      ,wtp.actual_departure_date   pick_actual_departure_date
      ,wtp.departure_net_weight    pick_departure_net_weight
      ,wtp.weight_uom_code         pick_weight_uom_code
      ,wtd.stop_id                 drop_stop_id
      ,wtd.stop_location_id        drop_stop_location_id
      ,wtd.status_code             drop_status_code
      ,wtd.stop_sequence_number    drop_stop_sequence_number
      ,wtd.planned_arrival_date    drop_planned_arrival_date
      ,wtd.planned_departure_date  drop_planned_departure_date
      ,wtd.actual_arrival_date     drop_actual_arrival_date
      ,wtd.actual_departure_date   drop_actual_departure_date
      ,wtd.departure_net_weight    drop_departure_net_weight
      ,wtd.weight_uom_code         drop_weight_uom_code
      ,wdl.delivery_leg_id
      ,wdl.delivery_id
      ,wdl.sequence_number
      ,wdl.pick_up_stop_id
      ,wdl.drop_off_stop_id
      ,wdl.shipper_title
      ,wdl.shipper_phone
      ,wdl.delivered_quantity
      ,wdl.loaded_quantity
      ,wdl.received_quantity*/
FROM   wsh_trips wt
      ,wsh_trip_stops wtp
      ,wsh_trip_stops wtd
      ,wsh_delivery_legs wdl
WHERE wt.trip_id   =wtp.trip_id
AND   wt.trip_id     =wtd.trip_id
AND   wtp.stop_id    =wdl.pick_up_stop_id
AND   wtd.stop_id    =wdl.drop_off_stop_id
AND   wdl.delivery_id IN 
('39371064',
'39371061',
'39368374',
'39368375',
'39368373',
'39368371',
'39368378',
'39368383',
'39368381',
'39368384',
'39368376',
'39368377',
'39368382',
'39368389',
'39371066',
'39371067');




59988795
59991865
59991888
59993118
59993115
59993117
59992754
59993128
59993129
59993116
59992740
59995335
59995417
59985018
59985019
59971866
59976415

MXC002842620
