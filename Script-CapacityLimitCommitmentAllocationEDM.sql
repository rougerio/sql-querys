SELECT DISTINCT
rg.domain_name,
rg.rate_geo_gid,
rg.rate_offering_gid,
rg.x_lane_gid,
--rg.effective_date,
rg.effective_date,
--rg.expiration_date,
rg.expiration_date,
rg.insert_user,
--rg.insert_date,
rg.insert_date,
rg.update_user,
--rg.insert_date,
rg.update_date,
rg.is_active,
ro.servprov_gid,
ro.transport_mode_gid,
cl.capacity_limit_gid,
cl.x_lane_gid                                         AS c1_x_lane_gid,
--cl.effective_date as c1_effective_date,
cl.effective_date  c1_effective_date,
--cl.expiration_date as c1_expiration_date,
cl.expiration_date c1_expiration_date,
cl.limit,
cl.mon_limit,
cl.tue_limit,
cl.wed_limit,
cl.thu_limit,
cl.fri_limit,
cl.sat_limit,
cl.sun_limit,
cu.capacity_limit_gid                                 cu_capacity_limit_gid,
cu.is_active                                          AS capacity_active_flag,
a.capacity_commitment_alloc_gid,
--a.effective_date as a_effective_date,
a.effective_date   a_effective_date,
--a.expiration_date as a_expiration_date,
a.expiration_date  a_expiration_date,
a.allocation_group_gid,
b.commit_perc
FROM RATE_GEO rg INNER JOIN 
RATE_OFFERING ro ON ro.rate_offering_gid = rg.rate_offering_gid INNER JOIN 
CAPACITY_LIMIT Cl ON cl.x_lane_gid = rg.x_lane_gid 
                 AND cl.expiration_date > sysdate 
                 /*AND cl.capacity_group_gid = rg.rate_offering_gid*/ INNER JOIN 
CAPACITY_GROUP cg ON cg.CAPACITY_GROUP_GID = cl.CAPACITY_GROUP_GID  
                  AND ro.SERVPROV_GID = cg.SERVPROV_GID INNER JOIN
CAPACITY_COMMITMENT_ALLOC a ON a.x_lane_gid = rg.x_lane_gid
                            AND ro.transport_mode_gid = a.allocation_group_gid
                            AND a.expiration_date > sysdate INNER JOIN 
CAPACITY_USAGE cu ON cl.capacity_limit_gid = cu.capacity_limit_gid INNER JOIN 
CAPACITY_COMMITMENT_ALLOC_D b ON b.capacity_commitment_alloc_gid = a.capacity_commitment_alloc_gid
                              AND ro.servprov_gid = b.servprov_gid
WHERE rg.is_active = 'Y'
   AND rg.expiration_date > sysdate
   AND cu.is_active = 'Y'
   AND cu.start_date > ( sysdate - 30 )
   AND cu.start_date < ( sysdate + 30 )
   AND rg.domain_name = 'NBL/MX';