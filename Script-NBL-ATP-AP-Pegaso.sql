select count(*)
  from nbl_ap_hdr_pegaso_stg;


select count(*)
  from nbl_ap_lin_pegaso_stg;

select *
  from nbl_ap_hdr_pegaso_stg hdr
 inner join nbl_ap_lin_pegaso_stg ln
on hdr.record_id = ln.record_id
 order by hdr.record_id;