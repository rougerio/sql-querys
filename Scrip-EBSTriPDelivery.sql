
--DELIVERY_DETAIL_ID
select trip_id 
        ,tp_plan_name
        ,org_id
        --,delivery_id
        ,org_code
        --,vendor_name
        ,freight_code
        ,scac_code
        --,num_del
        ,attribute1
        ,attribute2
        ,creation_date
from (
        select trip_id ,tp_plan_name ,vehicle_organization_id org_id,organization_code org_code, 
                vendor_name, freight_code ,scac_code
                ,sum(delivery_id_count) num_del
                ,attribute1, attribute2, creation_date
                --,delivery_id
                --,delivery_leg_id
        from (
                select wt.trip_id
                    ,count(wdl.delivery_id) as delivery_id_count
                    --,wdl.delivery_id
                    ,wt.tp_plan_name
                    ,wt.attribute1
                    ,wt.attribute2
                    ,wt.carrier_id
                    ,wdl.delivery_leg_id
                    ,wt.creation_date
                    ,wt.vehicle_organization_id  
                    ,h.organization_code
                    ,wa.vendor_name
                    ,wc.freight_code
                    ,wc.scac_code
                from wsh_trips wt inner join 
                    wsh_trip_stops wtp on wt.trip_id = wtp.trip_id inner join
                    org_organization_definitions h on wt.vehicle_organization_id = h.organization_id inner join 
                    wsh_carriers wc on wt.carrier_id = wc.carrier_id inner join
                    ap_suppliers wa on wc.supplier_id = wa.vendor_id left join
                    wsh_trip_stops wtd on wt.trip_id = wtd.trip_id left join
                    wsh_delivery_legs wdl on wtp.stop_id = wdl.pick_up_stop_id and wtd.stop_id = wdl.drop_off_stop_id
                where 
                wt.attribute1 in ('F') --or wt.attribute2 is null)
                and 
                wt.tp_plan_name like 'MX%'
                and wt.creation_date > TO_DATE('2025-12-09','YYYY-MM-DD')
                --and h.organization_code in ('MTY')--'MXC','MTY','GDL')
                --and wdl.delivery_id in ('39674696','39674697','39674700','39674699','39674702','39674698','39674703')
                --and wt.tp_plan_name = 'MX51087832' 
                --and wt.trip_id = '60150589'
                group by wt.trip_id, wt.tp_plan_name ,wt.attribute1 ,wt.attribute2 ,wt.carrier_id 
                ,wdl.delivery_leg_id ,wt.creation_date ,wt.vehicle_organization_id ,h.organization_code
                , wt.carrier_id, wa.vendor_name ,wc.freight_code ,wc.scac_code
                --,wdl.delivery_id
                ORDER BY wt.trip_id, wt.creation_date
                --wdl.delivery_id, 
            ) T
        group by trip_id, tp_plan_name ,attribute1 ,attribute2 ,carrier_id 
            ,creation_date ,vehicle_organization_id ,organization_code,
            vendor_name,freight_code ,scac_code
            --,delivery_id
            --,delivery_leg_id
        order by organization_code, trip_id, attribute2
) T1
where num_del > 0;

describe wsh_trips;