select location_xid,
       province,
       province_code,
       postal_code
  from location
 where country_code3_gid = 'MEX'
   and location_xid like 'CUS%';



select fkcus.location_id,
       cus.new_cus_loc_id,
       fkcus.address_name,
       fkcus.address_line_1,
       fkcus.address_line_2,
       fkcus.city,
       fkcus.state,
       otmcus.province_code province_code_otm,
       fkcus.country,
       fkcus.postal,
       fkcus.latitude,
       fkcus.longitude,
       fkcus.geofence_type,
       fkcus.custom_geofence,
       fkcus.geofence_radius__metres_,
       fkcus.geofence_points,
       fkcus.inaccurate_address,
       fkcus.location_tracked_loads__last_365_days_,
       fkcus.geofence_passed_loads__last_365_days_,
       fkcus.geofence_failed_loads__last_365_days_,
       fkcus.geofence_success____last_365_days_,
       fkcus.auto_completed_loads__last_365_days_,
       fkcus.manually_completed_loads__last_365_days_,
       fkcus.incompleted_loads__last_365_days_,
       fkcus.business_hours,
       fkcus.custom_load_unload_time,
       fkcus.tags,
       fkcus.customers,
       fkcus.user_sent___address_line_1,
       fkcus.user_sent___address_line_2,
       fkcus.user_sent___city,
       fkcus.user_sent___state,
       fkcus.user_sent___postal
  from fk_cus_address fkcus
 inner join otm_cus_old_new cus
on substr(
   cus.old_cus_loc_id,
   5,
   length(cus.old_cus_loc_id) - 4
) = fkcus.location_id
 inner join otm_cus_state otmcus
on otmcus.location_xid = substr(
   cus.new_cus_loc_id,
   5,
   length(cus.new_cus_loc_id) - 4
)

--WHERE LOCATION_ID LIKE '%132231%'
;

/*
777
521
*/

select --SUBSTR(OLD_CUS_LOC_ID, 5, LENGTH(OLD_CUS_LOC_ID)-5) OLD_CUS_LOC_ID
--, 

 new_cus_loc_id,
       substr(
          new_cus_loc_id,
          5,
          length(new_cus_loc_id) - 4
       ) old_cus_loc_id
  from otm_cus_old_new
 where old_cus_loc_id like '%132231%';