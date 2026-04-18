SELECT DISTINCT rg.rate_geo_gid,
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
                cl.x_lane_gid             AS c1_x_lane_gid,
                --cl.effective_date as c1_effective_date,
                cl.effective_date         c1_effective_date,
                --cl.expiration_date as c1_expiration_date,
                cl.expiration_date        c1_expiration_date,
                cl.LIMIT,
                cl.mon_limit,
                cl.tue_limit,
                cl.wed_limit,
                cl.thu_limit,
                cl.fri_limit,
                cl.sat_limit,
                cl.sun_limit,
                cu.capacity_limit_gid     cu_capacity_limit_gid,
                cu.is_active              AS capacity_active_flag,
                a.capacity_commitment_alloc_gid,
                --a.effective_date as a_effective_date,
                a.effective_date          a_effective_date,
                --a.expiration_date as a_expiration_date,
                a.expiration_date         a_expiration_date,
                a.allocation_group_gid,
                b.commit_perc,
                cu.USAGE
  FROM nbl_dw.wc_rate_geo_d  rg
       INNER JOIN nbl_dw.wc_rate_offering_d ro
           ON ro.rate_offering_gid = rg.rate_offering_gid
       INNER JOIN nbl_dw.wc_capacity_limit_d cl
           ON     cl.x_lane_gid = rg.x_lane_gid
              --AND cl.capacity_group_gid = rg.rate_offering_gid
              AND cl.expiration_date > SYSDATE
       INNER JOIN nbl_dw.wc_capacity_comnt_alloc_d a
           ON     a.x_lane_gid = rg.x_lane_gid
              AND ro.transport_mode_gid = a.allocation_group_gid
              AND a.expiration_date > SYSDATE
       INNER JOIN nbl_dw.wc_capacity_usage_d cu
           ON cl.capacity_limit_gid = cu.capacity_limit_gid
       INNER JOIN nbl_dw.wc_capacity_comnt_alloc_d b
           ON     b.capacity_commitment_alloc_gid = a.capacity_commitment_alloc_gid
              AND ro.servprov_gid = b.servprov_gid
WHERE     1 = 1
      AND rg.is_active = 'Y'
      AND rg.expiration_date > SYSDATE
       AND cu.is_active = 'Y'
       AND cu.start_date > (SYSDATE - 30)
       AND cu.start_date < (SYSDATE + 30)
       AND cu.DOMAIN_NAME = 'NBL/MX'


SELECT DISTINCT
  rg.domain_name,
  rg.rate_geo_gid,
  rg.rate_offering_gid,
  rg.x_lane_gid,
  rg.effective_date,
  rg.expiration_date,
  rg.insert_user,
  rg.insert_date,
  rg.update_user,
  rg.update_date,
  rg.is_active,
  ro.servprov_gid,
  ro.transport_mode_gid,
  cl.capacity_limit_gid,
  cl.x_lane_gid AS c1_x_lane_gid,
  cl.effective_date c1_effective_date,
  cl.expiration_date c1_expiration_date,
  cl.LIMIT,
  cl.mon_limit,
  cl.tue_limit,
  cl.wed_limit,
  cl.thu_limit,
  cl.fri_limit,
  cl.sat_limit,
  cl.sun_limit,
  cu.capacity_limit_gid cu_capacity_limit_gid,
  cu.is_active AS capacity_active_flag,
  a.capacity_commitment_alloc_gid,
  a.effective_date a_effective_date,
  a.expiration_date a_expiration_date,
  a.allocation_group_gid,
  b.commit_perc,
  cu.start_date,
  cu.USAGE
FROM
  biprodcatalog.nbl_otm_dw.dim_rate_geo rg INNER JOIN 
  biprodcatalog.nbl_otm_dw.dim_rate_offering ro ON ro.rate_offering_gid = rg.rate_offering_gid INNER JOIN
  biprodcatalog.nbl_otm_dw.dim_capacity_limit cl  
  ON cl.x_lane_gid = rg.x_lane_gid INNER JOIN 
  biprodcatalog.nbl_otm_dw.dim_capacity_comnt_alloc a  ON a.x_lane_gid = rg.x_lane_gid AND ro.transport_mode_gid = a.allocation_group_gid INNER JOIN 
  biprodcatalog.nbl_otm_dw.dim_capacity_usage cu ON cl.capacity_limit_gid = cu.capacity_limit_gid
      --    AND cu.start_date BETWEEN TRUNC(ADD_MONTHS(SYSDATE, -12), 'YY') AND LAST_DAY(SYSDATE)
      AND cu.start_date BETWEEN
        TRUNC(ADD_MONTHS(CURRENT_DATE(), -12), 'YYYY')
      AND
        LAST_DAY(CURRENT_DATE()) INNER JOIN biprodcatalog.nbl_otm_dw.dim_capacity_comnt_alloc b
      ON b.capacity_commitment_alloc_gid = a.capacity_commitment_alloc_gid
      AND ro.servprov_gid = b.servprov_gid
    INNER JOIN biprodcatalog.nbl_otm_dw.dim_capacity_group cg
      ON cg.CAPACITY_GROUP_GID = cl.CAPACITY_GROUP_GID
      AND ro.SERVPROV_GID = cg.SERVPROV_GID
WHERE
  1 = 1
  AND rg.is_active = 'Y'
  AND cu.is_active = 'Y'
  AND rg.domain_name = 'NBL/MX'