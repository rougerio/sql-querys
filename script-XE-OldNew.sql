--ORDER_MOVEMENT
--SELECT COUNT(*) 
select 
    --count(*)
 t.order_movement_gid,
       t.order_movement_xid,
    --T.source_location_gid,
       t.new_location_id as source_location_gid,
       sai.source_location_gid as source_location_gid_sai,
    --T.dest_location_gid,
       t.new_cus_loc_id as dest_location_gid,
       sai.dest_location_gid as dest_location_gid_sai,
       t.servprov_gid,
       t.domain_name
  from (
   select data.order_movement_gid,
          data.order_movement_xid,
          data.source_location_gid,
          orgsnew.new_location_id,
          data.dest_location_gid,
          cusnew.new_cus_loc_id,
          data.servprov_gid,
          data.domain_name
     from otm_data_order_movement_2026 data
     left join otm_data_orgs_old_new orgsnew
   on data.source_location_gid = orgsnew.old_location_id
     left join otm_data_cus_old_new cusnew
   on data.dest_location_gid = cusnew.old_cus_loc_id
    where data.source_location_gid like '%ORG%'
) t
 inner join otm_data_order_movement_sai sai
on t.order_movement_gid = sai.order_movement_gid
 where ( t.new_cus_loc_id <> sai.dest_location_gid
    or t.new_location_id <> sai.source_location_gid );

select data.order_movement_gid,
       data.order_movement_xid,
        --data.source_location_gid,
       orgsnew.new_location_id source_location_gid,
        --data.dest_location_gid,
       cusnew.new_cus_loc_id dest_location_gid,
       data.servprov_gid,
       data.domain_name
  from otm_data_order_movement_2026 data
  left join otm_data_orgs_old_new orgsnew
on data.source_location_gid = orgsnew.old_location_id
  left join otm_data_cus_old_new cusnew
on data.dest_location_gid = cusnew.old_cus_loc_id
 where data.source_location_gid like '%ORG%';


--18608

--Vaidation
select *
  from otm_data_order_movement_sai
 where source_location_gid like '%ORG%';


select count(*)
  from otm_data_order_movement_2026
 where servprov_gid is null
--WHERE SOURCE_LOCATION_GID LIKE '%ORG%'
 ;
--18608

--ORDER_RELEASE
select dat.order_release_gid,
       dat.order_release_xid,
       --dat.source_location_gid,
       orgsnew.new_location_id source_location_gid,
       --dat.dest_location_gid,
       cusnew.new_cus_loc_id dest_location_gid,
       dat.servprov_gid,
       dat.domain_name
  from otm_data_order_relese_2026 dat
  left join otm_data_orgs_old_new orgsnew
on dat.source_location_gid = orgsnew.old_location_id
  left join otm_data_cus_old_new cusnew
on dat.dest_location_gid = cusnew.old_cus_loc_id
 where dat.source_location_gid like '%ORG%';
--18608

select count(*)
  from otm_data_order_relese_2026
 where source_location_gid like '%ORG%';
--18608


--ORDER_RELEASE_LINE

select dat.order_release_line_gid,
       dat.order_release_line_xid,
       dat.order_release_gid,
    --DAT.PACKAGED_ITEM_GID,
       itemnew.new_id packaged_item_gid,
       dat.domain_name
  from otm_data_order_release_line_2026 dat
  left join otm_data_item_old_new itemnew
on dat.packaged_item_gid = itemnew.old_id;
--25311

select count(*)
  from otm_data_order_release_line_2026;
--25311

--SHIPMENT

select dat.shipment_gid,
       dat.shipment_xid,
       --dat.source_location_gid,
       orgsnew.new_location_id source_location_gid,
       --dat.dest_location_gid,
       cusnew.new_cus_loc_id dest_location_gid,
       dat.servprov_gid,
       case
          when servnew.new_id is null then
             dat.servprov_gid
          else
             servnew.new_id
       end as servprov_new_id,
       dat.domain_name
  from otm_data_shipment_2026 dat
  left join otm_data_orgs_old_new orgsnew
on dat.source_location_gid = orgsnew.old_location_id
  left join otm_data_cus_old_new cusnew
on dat.dest_location_gid = cusnew.old_cus_loc_id
  left join otm_data_carrier_old_new servnew
on dat.servprov_gid = servnew.old_id
--WHERE DAT.SOURCE_LOCATION_GID LIKE '%ORG%'
;
--17379

select count(*)
  from otm_data_shipment_2026
 where source_location_gid like '%ORG%';
--17379

--SHIPMENT_STOP

select dat.shipment_gid,
       dat.stop_num,
       --dat.location_gid,
       orgsnew.new_location_id location_gid,
       dat.domain_name
  from otm_data_shipment_stop_2026 dat
  left join otm_data_orgs_old_new orgsnew
on dat.location_gid = orgsnew.old_location_id
 where dat.location_gid like '%ORG%'
--17379
union all
select dat.shipment_gid,
       dat.stop_num,
       --dat.location_gid,
       cusnew.new_cus_loc_id location_gid,
       dat.domain_name
  from otm_data_shipment_stop_2026 dat
  left join otm_data_cus_old_new cusnew
on dat.location_gid = cusnew.old_cus_loc_id
 where dat.location_gid like '%CUS%';
--18606

select count(*)
  from otm_data_shipment_stop_2026
 where location_gid like '%SUP%';
--35985
--ORGS - 17379
--CUS - 18606