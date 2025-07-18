select distinct orr.order_release_gid,orr.insert_date, orr.rate_offering_gid 
from order_release orr INNER JOIN 
    order_release_status ors ON orr.order_release_gid = ors.order_release_gid INNER JOIN 
    location_profile_detail lpd  ON orr.source_location_gid=lpd.location_gid 
where orr.order_base_gid is not null 
and TO_CHAR(orr.insert_date, 'YYYY-DD-MM') = TO_CHAR(sysdate - 2, 'YYYY-DD-MM') 
and ors.status_type_gid='NBL.PLANNING' 
and ors.status_value_gid IN ('NBL.PLANNING_NEW','NBL.PLANNING_UNSCHEDULED') 
and orr.USER_DEFINED2_ICON_GID is null 
and orr.rate_offering_gid like  'NBL.VENDOR%' 
and lpd.location_profile_gid='NBL.SHIPMENT_BELONGS_TO_RAWMATERIAL_INBOUND' 