select *
  from (
   select record_id,
          tp_shipment,
          action_code,
          order_num,
          process_status,
          error_message,
          source_order,
          ship_to_party_id,
          mode_of_transport_code,
          service_level_code,
          carrier,
          order_release,
          net_weight,
          total_volume,
          cust_po_group,
          pu_appointment,
          commodity_group,
          is_preload,
          ref_value,
          appt_start_time,
          appt_end_time,
          planned_arrival_date,
          planned_drop_off_date,
          planned_time,
          target_system,
          path,
          oic_instance_id,
          created_by,
          creation_date,
          last_updated_by,
          last_update_date,
          row_number()
          over(partition by tp_shipment
               order by creation_date desc
          ) as rn
     from nbl_wsh_otm_int_hist_stg
    where 1 = 1
      and tp_shipment like '%MX%'
      and action_code != 'D'
      and creation_date >= to_date('2025-01-01','YYYY-MM-DD')
        --AND PROCESS_STATUS = 'Error'
      and tp_shipment = 'MX5001000121'
    order by record_id asc
) t
--WHERE RN = 1
--AND PROCESS_STATUS = 'Error'
 order by error_message asc;

/*
NBL/MX.MX51110474
MX51110214
*/