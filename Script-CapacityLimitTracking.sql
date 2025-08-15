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
/*CAPACITY_GROUP cg ON cg.CAPACITY_GROUP_GID = cl.CAPACITY_GROUP_GID  
                  AND ro.SERVPROV_GID = cg.SERVPROV_GID INNER JOIN*/
CAPACITY_COMMITMENT_ALLOC a ON a.x_lane_gid = rg.x_lane_gid
                            AND ro.transport_mode_gid = a.allocation_group_gid
                            AND a.expiration_date > sysdate INNER JOIN 
CAPACITY_USAGE cu ON cl.capacity_limit_gid = cu.capacity_limit_gid INNER JOIN 
CAPACITY_COMMITMENT_ALLOC_D b ON b.capacity_commitment_alloc_gid = a.capacity_commitment_alloc_gid
                              AND ro.servprov_gid = b.servprov_gid
WHERE rg.is_active = 'Y'
    --AND rg.expiration_date > sysdate
   --AND cu.is_active = 'Y'
   --AND cu.start_date > ( sysdate - 90 )
   --AND cu.start_date < ( sysdate + 90 )
   AND rg.domain_name = 'NBL/MX'
   --AND a.CAPACITY_COMMITMENT_ALLOC_GID = 'NBL/MX.MTY_3MZ_NUEVO_LEON_LOW_25'
   --AND ro.SERVPROV_GID = 'NBL.CAR-2685316'
--'NBL/MX.MXC_CUAUTITLAN_PEAK_24'
   ORDER BY rg.rate_offering_gid, a.capacity_commitment_alloc_gid
   ;

SELECT * 
FROM
    (
        SELECT rg.RATE_GEO_GID, xl.X_LANE_GID, xl.SOURCE_REGION_GID, xl.DEST_REGION_GID
        FROM RATE_GEO rg INNER JOIN
        X_LANE xl ON xl.x_lane_gid = rg.x_lane_gid
        WHERE rg.EXPIRATION_DATE IS NULL
        AND rg.IS_ACTIVE = 'Y'
        AND rg.DOMAIN_NAME = 'NBL/MX'
        --AND xl.DEST_REGION_GID = 'NBL/MX.MTY|TEPOTZOTLAN'
        GROUP BY rg.RATE_GEO_GID, xl.X_LANE_GID, xl.SOURCE_REGION_GID, xl.DEST_REGION_GID
        ORDER BY xl.X_LANE_GID, xl.SOURCE_REGION_GID, DEST_REGION_GID
    ) rate LEFT JOIN
    (
        SELECT xl.X_LANE_GID, xl.SOURCE_REGION_GID, xl.DEST_REGION_GID
        FROM CAPACITY_LIMIT cl INNER JOIN
        X_LANE xl ON cl.X_LANE_GID = xl.X_LANE_GID 
        WHERE cl.DOMAIN_NAME = 'NBL/MX'
        AND cl.EXPIRATION_DATE > SYSDATE
        GROUP BY xl.X_LANE_GID, xl.SOURCE_REGION_GID, xl.DEST_REGION_GID
    ) xcapa ON rate.SOURCE_REGION_GID = xcapa.SOURCE_REGION_GID 
            AND rate.DEST_REGION_GID = xcapa.DEST_REGION_GID
;




'NBL/MX.FEMSA|MXC|MXC FEMSA CUAUTITLAN|24';

--'NBL/MX.MXC_CUAUTITLAN_ANDRADE_PEAK_24'

SELECT /*RATE_GEO_XID, DEST_REGION_GID*/X_LANE_XID
FROM (
SELECT /*rg.RATE_GEO_XID, xl.DEST_REGION_GID*/ xl.X_LANE_XID
FROM RATE_GEO rg INNER JOIN
X_LANE xl ON xl.x_lane_gid = rg.x_lane_gid
WHERE rg.EXPIRATION_DATE IS NULL
AND rg.IS_ACTIVE = 'Y'
AND rg.DOMAIN_NAME = 'NBL/MX'
AND rg.X_LANE_GID NOT IN (SELECT xl.X_LANE_GID
                          FROM CAPACITY_LIMIT cl INNER JOIN
                          X_LANE xl ON cl.X_LANE_GID = xl.X_LANE_GID 
                        WHERE cl.DOMAIN_NAME = 'NBL/MX'
                        AND cl.EXPIRATION_DATE > SYSDATE
)
AND xl.X_LANE_XID LIKE '%|%'
GROUP BY /*rg.RATE_GEO_XID, xl.DEST_REGION_GID*/xl.X_LANE_XID
ORDER BY /*rg.RATE_GEO_XID, xl.DEST_REGION_GID*/xl.X_LANE_XID
) t
GROUP BY /*RATE_GEO_XID, DEST_REGION_GID*/X_LANE_XID
;


SELECT xl.X_LANE_GID
FROM CAPACITY_LIMIT cl INNER JOIN
X_LANE xl ON cl.X_LANE_GID = xl.X_LANE_GID 
WHERE cl.DOMAIN_NAME = 'NBL/MX'
AND cl.EXPIRATION_DATE > SYSDATE
GROUP BY xl.X_LANE_GID, xl.SOURCE_REGION_GID, xl.DEST_REGION_GID;




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
   AND TO_CHAR(cu.start_date, 'YYYY-MM-DD') = '2025-02-07'
   --AND cu.start_date > ( sysdate - 30 )
   --AND cu.start_date < ( sysdate + 30 )
   AND rg.domain_name = 'NBL/MX';



SELECT DISTINCT
rg.domain_name,
rg.rate_geo_gid,
rg.rate_offering_gid,
rg.x_lane_gid,
rg.effective_date
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
   --AND rg.expiration_date > sysdate
   AND CL.EXPIRATION_DATE > sysdate
   AND cu.is_active = 'Y'
   AND TO_CHAR(cu.start_date, 'YYYY-MM-DD') = '2025-02-07'
   --AND cu.start_date > ( sysdate - 30 )
   --AND cu.start_date < ( sysdate + 30 )
   AND rg.domain_name = 'NBL/MX';

/*
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
ro.transport_mode_gid--, 
/*cl.capacity_limit_gid,
cl.x_lane_gid                                         AS c1_x_lane_gid,
cl.effective_date  c1_effective_date,
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
cu.is_active                                          AS capacity_active_flag */
--a.capacity_commitment_alloc_gid,
--a.effective_date   a_effective_date,
--a.expiration_date  a_expiration_date,
--a.allocation_group_gid,
--b.commit_perc
,ro.servprov_gid
,cg.SERVPROV_GID
*/

SELECT domain_name,
        rate_geo_gid,
        rate_offering_gid,
        x_lane_gid,
        effective_date,
        expiration_date,
        insert_user,
        insert_date,
        update_user,
        update_date,
        is_active,
        servprov_gid,
        transport_mode_gid,
        capacity_limit_gid,
        c1_x_lane_gid,
        c1_effective_date,
        c1_expiration_date,
        limit,
        mon_limit,
        tue_limit,
        wed_limit,
        thu_limit,
        fri_limit,
        sat_limit,
        sun_limit,
        cu_capacity_limit_gid,
        capacity_active_flag,
        capacity_commitment_alloc_gid,
        a_effective_date,
        a_expiration_date,
        allocation_group_gid,
        commit_perc,
        start_date,
        USAGE
FROM (
        SELECT rg.domain_name,
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
                cl.x_lane_gid                                         AS c1_x_lane_gid,
                cl.effective_date  c1_effective_date,
                cl.expiration_date c1_expiration_date,
                cl.limit,
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
                a.effective_date          a_effective_date,
                a.expiration_date         a_expiration_date,
                a.allocation_group_gid,
                b.commit_perc,
                cu.start_date,
                cu.USAGE
        FROM RATE_GEO rg INNER JOIN 
        RATE_OFFERING ro ON ro.rate_offering_gid = rg.rate_offering_gid INNER JOIN 
        CAPACITY_GROUP cg ON ro.SERVPROV_GID = cg.SERVPROV_GID INNER JOIN
        CAPACITY_LIMIT Cl ON cg.CAPACITY_GROUP_GID = cl.CAPACITY_GROUP_GID AND cl.x_lane_gid = rg.x_lane_gid INNER JOIN 
        CAPACITY_USAGE cu ON cl.capacity_limit_gid = cu.capacity_limit_gid LEFT JOIN
        CAPACITY_COMMITMENT_ALLOC a ON a.x_lane_gid = rg.x_lane_gid AND ro.transport_mode_gid = a.allocation_group_gid LEFT JOIN 
        CAPACITY_COMMITMENT_ALLOC_D b ON b.capacity_commitment_alloc_gid = a.capacity_commitment_alloc_gid AND ro.SERVPROV_GID = b.SERVPROV_GID
        WHERE rg.is_active = 'Y' 
        AND cu.is_active = 'Y'
        --AND TO_CHAR(cu.start_date, 'YYYY-MM-DD') > '2025-02-07' 
        AND cu.start_date BETWEEN add_months(trunc(sysdate, 'MONTH'), -12) and last_day(sysdate)
        AND rg.domain_name = 'NBL/MX'
        AND cl.expiration_date > sysdate
        AND a.expiration_date > sysdate
) T
GROUP BY domain_name,
        rate_geo_gid,
        rate_offering_gid,
        x_lane_gid,
        effective_date,
        expiration_date,
        insert_user,
        insert_date,
        update_user,
        update_date,
        is_active,
        servprov_gid,
        transport_mode_gid,
        capacity_limit_gid,
        c1_x_lane_gid,
        c1_effective_date,
        c1_expiration_date,
        limit,
        mon_limit,
        tue_limit,
        wed_limit,
        thu_limit,
        fri_limit,
        sat_limit,
        sun_limit,
        cu_capacity_limit_gid,
        capacity_active_flag,
        capacity_commitment_alloc_gid,
        a_effective_date,
        a_expiration_date,
        allocation_group_gid,
        commit_perc,
        start_date,
        USAGE
ORDER BY start_date DESC

--INNER JOIN
--CAPACITY_COMMITMENT_ALLOC a ON a.x_lane_gid = rg.x_lane_gid AND ro.transport_mode_gid = a.allocation_group_gid /*AND a.expiration_date > sysdate*/ --INNER JOIN 
--CAPACITY_COMMITMENT_ALLOC_D b ON b.capacity_commitment_alloc_gid = a.capacity_commitment_alloc_gid

GROUP BY rg.rate_geo_gid, rg.x_lane_gid, cl.x_lane_gid, cg.CAPACITY_GROUP_GID

--AND cg.capacity_group_gid = 'NBL/MX.ESJ'




ORDER BY a.effective_date DESC
;

SERVPROV_GID
NBL.CAR-2242743



/* Formatted on 12/23/2024 11:52:46 AM (QP5 v5.371) */
SELECT DISTINCT rg.domain_name,
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
                cl.x_lane_gid             AS c1_x_lane_gid,
                cl.effective_date         c1_effective_date,
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
                a.effective_date          a_effective_date,
                a.expiration_date         a_expiration_date,
                a.allocation_group_gid,
                b.commit_perc,
                cu.start_date,
                cu.USAGE
  FROM nbl_dw.wc_rate_geo_d  rg INNER JOIN 
        nbl_dw.wc_rate_offering_d ro ON ro.rate_offering_gid = rg.rate_offering_gid INNER JOIN 
        nbl_dw.wc_capacity_limit_d cl ON cl.x_lane_gid = rg.x_lane_gid INNER JOIN 
        nbl_dw.wc_capacity_comnt_alloc_d a ON a.x_lane_gid = rg.x_lane_gid AND ro.transport_mode_gid = a.allocation_group_gid INNER JOIN 
        nbl_dw.wc_capacity_usage_d cu ON cl.capacity_limit_gid = cu.capacity_limit_gid AND cu.start_date BETWEEN TRUNC(ADD_MONTHS(SYSDATE, -12), 'YY') AND LAST_DAY(SYSDATE) INNER JOIN 
        nbl_dw.wc_capacity_comnt_alloc_d b ON b.capacity_commitment_alloc_gid = a.capacity_commitment_alloc_gid AND ro.servprov_gid = b.servprov_gid INNER JOIN 
        OTM.CAPACITY_GROUP cg ON cg.CAPACITY_GROUP_GID = cl.CAPACITY_GROUP_GID AND ro.SERVPROV_GID = cg.SERVPROV_GID
WHERE     1 = 1
       AND rg.is_active = 'Y'
       AND cu.is_active = 'Y'
       AND rg.domain_name = 'NBL/MX'

MXC|MXC|CHALCO

MXC|MXC CHALCO


SELECT rg.domain_name,
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
                cl.x_lane_gid                                         AS c1_x_lane_gid,
                cl.effective_date  c1_effective_date,
                cl.expiration_date c1_expiration_date,
                cl.limit,
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
                a.effective_date          a_effective_date,
                a.expiration_date         a_expiration_date,
                a.allocation_group_gid,
                b.commit_perc,
                cu.start_date,
                cu.USAGE*
                b.rate_offering_gid,
                a.capacity_commitment_alloc_gid
        FROM RATE_GEO rg INNER JOIN 
        RATE_OFFERING ro ON ro.rate_offering_gid = rg.rate_offering_gid INNER JOIN 
        CAPACITY_GROUP cg ON ro.SERVPROV_GID = cg.SERVPROV_GID INNER JOIN
        CAPACITY_LIMIT Cl ON cg.CAPACITY_GROUP_GID = cl.CAPACITY_GROUP_GID AND cl.x_lane_gid = rg.x_lane_gid INNER JOIN 
        CAPACITY_USAGE cu ON cl.capacity_limit_gid = cu.capacity_limit_gid INNER JOIN
        CAPACITY_COMMITMENT_ALLOC a ON a.x_lane_gid = rg.x_lane_gid AND ro.transport_mode_gid = a.allocation_group_gid  INNER JOIN 
        CAPACITY_COMMITMENT_ALLOC_D b ON b.capacity_commitment_alloc_gid = a.capacity_commitment_alloc_gid AND ro.SERVPROV_GID = b.SERVPROV_GID AND ro.rate_offering_gid = b.rate_offering_gid
        WHERE rg.is_active = 'Y' 
        --AND cu.is_active = 'Y'
        --AND TO_CHAR(cu.start_date, 'YYYY-MM-DD') > '2025-02-07' 
        --AND cu.start_date BETWEEN add_months(trunc(sysdate, 'MONTH'), -12) and last_day(sysdate)
        AND rg.domain_name = 'NBL/MX'
        --AND cl.expiration_date > sysdate
        --AND a.expiration_date > sysdate
        and b.capacity_commitment_alloc_gid LIKE '%HIGH_25' 
        AND rg.rate_offering_gid LIKE '%DEDICADOS%'

SELECT * 
FROM CAPACITY_LIMIT
WHERE CAPACITY_GROUP_GID = 'NBL/MX.ESJ'
AND CAPACITY_LIMIT_GID LIKE '%HIGH_25'

SELECT * 
FROM RATE_GEO
WHERE RATE_OFFERING_GID = 'NBL/MX.ESJ'
AND IS_ACTIVE = 'Y'

SELECT *
FROM CAPACITY_COMMITMENT_ALLOC
WHERE CAPACITY_COMMITMENT_XID LIKE '%_HIGH_25' 
AND DOMAIN_NAME = 'NBL/MX'

--Query con LEFT's
SELECT DISTINCT rg.domain_name
                ,rg.rate_geo_gid
                ,rg.rate_offering_gid
                ,rg.x_lane_gid
                ,rg.effective_date
                ,rg.expiration_date
                ,rg.insert_user
                ,rg.insert_date
                ,rg.update_user
                ,rg.update_date
                ,rg.is_active
                ,ro.servprov_gid
                ,ro.transport_mode_gid
                ,cl.capacity_limit_gid
                ,cl.x_lane_gid AS c1_x_lane_gid
                ,cl.effective_date AS c1_effective_date
                ,cl.expiration_date AS c1_expiration_date
                ,cl.LIMIT
                ,cl.mon_limit
                ,cl.tue_limit
                ,cl.wed_limit
                ,cl.thu_limit
                ,cl.fri_limit
                ,cl.sat_limit
                ,cl.sun_limit
                ,cu.capacity_limit_gid AS cu_capacity_limit_gid
                ,cu.is_active AS capacity_active_flag
                ,a.capacity_commitment_alloc_gid
                ,a.effective_date AS a_effective_date
                ,a.expiration_date AS a_expiration_date
                ,a.allocation_group_gid
                ,b.commit_perc
                ,cu.start_date
                ,cu.USAGE
    FROM nbl_dw.wc_rate_geo_d rg
        INNER JOIN nbl_dw.wc_rate_offering_d ro
            ON ro.rate_offering_gid = rg.rate_offering_gid
        LEFT OUTER JOIN nbl_dw.wc_capacity_limit_d cl
            ON cl.x_lane_gid = rg.x_lane_gid
        INNER JOIN nbl_dw.wc_capacity_comnt_alloc_d a
            ON a.x_lane_gid = rg.x_lane_gid
                AND ro.transport_mode_gid = a.allocation_group_gid
        LEFT OUTER JOIN nbl_dw.wc_capacity_usage_d cu
            ON cl.capacity_limit_gid = cu.capacity_limit_gid
                AND cu.start_date BETWEEN TRUNC(ADD_MONTHS(SYSDATE, -12), 'YY') AND LAST_DAY(SYSDATE)
        LEFT OUTER JOIN nbl_dw.wc_capacity_comnt_alloc_d b
            ON b.capacity_commitment_alloc_gid = a.capacity_commitment_alloc_gid
                AND ro.servprov_gid = b.servprov_gid
        LEFT OUTER JOIN otm.capacity_group cg
            ON cg.capacity_group_gid = cl.capacity_group_gid
                AND ro.servprov_gid = cg.servprov_gid
WHERE 1=1 
    AND rg.is_active = 'Y'
    AND cu.is_active = 'Y'
    AND rg.domain_name = 'NBL/MX'
    AND rg.rate_offering_gid IN ('NBL/MX.ESJ', 'NBL/MX.ESJ_DEDICADOS')



/*
NBL/MX.SAENZ|MTY|CHIHUAHUA|25
NBL/MX.SER|MTY|CHIHUAHUA|25
NBL/MX.BKHL|MXC|FULL MERIDA|25
NBL/MX.JJGC|MXC| JJGC MERIDA|25
NBL/MX.JJGC|MXC| JJGC VILLAHERMOSA|25
NBL/MX.ANDRADE|MXC|VILLAHERMOSA|25
NBL/MX.MEXAMERIK|MXC|VILLAHERMOSA|25
NBL/MX.JJGC|MXC| JJGC CANCUN|25

NBL/MX.EHUB|MXC|CHALCO|25
NBL/MX.SAENZ|MTY|CULIACAN|25
NBL/MX.VENTURA|3TJ|TIJUANA|25
NBL/MX.ARACELY|MTY|CD JUAREZ|25
NBL/MX.SAENZ|MTY|CD JUAREZ|25
NBL/MX.FIDUM|MTY|CD JUAREZ|25
NBL/MX.SER|MTY|CD JUAREZ|25
NBL/MX.BKHL|MXC|CUAUTITLAN|25
NBL/MX.TPEREZ|MXC| CUAUTITLAN|25
*/




SELECT DISTINCT rg.domain_name,
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
                cl.x_lane_gid             AS c1_x_lane_gid,
                cl.effective_date         c1_effective_date,
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
                a.effective_date          a_effective_date,
                a.expiration_date         a_expiration_date,
                a.allocation_group_gid,
                b.commit_perc,
                cu.start_date,
                cu.USAGE
  FROM rate_geo  rg INNER JOIN 
      rate_offering ro ON ro.rate_offering_gid = rg.rate_offering_gid INNER JOIN 
      CAPACITY_GROUP cg ON ro.SERVPROV_GID = cg.SERVPROV_GID INNER JOIN
      capacity_limit cl ON cg.CAPACITY_GROUP_GID = cl.CAPACITY_GROUP_GID AND cl.x_lane_gid = rg.x_lane_gid INNER JOIN 
      capacity_usage cu ON cl.capacity_limit_gid = cu.capacity_limit_gid --AND cu.start_date BETWEEN TRUNC(ADD_MONTHS(SYSDATE, -12), 'YY') AND LAST_DAY(SYSDATE) 
      INNER JOIN  
      CAPACITY_COMMITMENT_ALLOC a ON a.x_lane_gid = rg.x_lane_gid AND ro.transport_mode_gid = a.allocation_group_gid  INNER JOIN 
      CAPACITY_COMMITMENT_ALLOC_D b ON b.capacity_commitment_alloc_gid = a.capacity_commitment_alloc_gid AND ro.servprov_gid = b.servprov_gid
WHERE     1 = 1
       AND rg.is_active = 'Y'
       AND cu.is_active = 'Y'
       AND rg.domain_name = 'NBL/MX'
       AND rg.x_lane_gid LIKE '%MXC%CHALCO%'
ORDER BY cu.start_date




----Validacion Corona Chalco

SELECT rg.domain_name,
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
                cl.x_lane_gid             AS c1_x_lane_gid,
                cl.effective_date         c1_effective_date,
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
                a.effective_date          a_effective_date,
                a.expiration_date         a_expiration_date,
                a.allocation_group_gid,
                b.commit_perc,
                cu.start_date,
                cu.USAGE,
                cua.PLANNED_TOTAL_COUNT cua_planned_total_count
                cua.FINAL_TOTAL_COUNT cua_final_total_count
                cua.START_DATE cua_start_date
FROM rate_geo  rg INNER JOIN 
    rate_offering ro ON ro.rate_offering_gid = rg.rate_offering_gid INNER JOIN 
    CAPACITY_GROUP cg ON ro.SERVPROV_GID = cg.SERVPROV_GID INNER JOIN
    capacity_limit cl ON cg.CAPACITY_GROUP_GID = cl.CAPACITY_GROUP_GID AND cl.x_lane_gid = rg.x_lane_gid INNER JOIN 
    capacity_usage cu ON cl.capacity_limit_gid = cu.capacity_limit_gid --AND cu.start_date BETWEEN TRUNC(ADD_MONTHS(SYSDATE, -12), 'YY') AND LAST_DAY(SYSDATE) 
    INNER JOIN  
    CAPACITY_COMMITMENT_ALLOC a ON a.x_lane_gid = rg.x_lane_gid AND ro.transport_mode_gid = a.allocation_group_gid INNER JOIN 
    CAPACITY_COMMITMENT_ALLOC_D b ON b.capacity_commitment_alloc_gid = a.capacity_commitment_alloc_gid AND ro.servprov_gid = b.servprov_gid 
    AND b.rate_offering_gid = ro.rate_offering_gid 
    INNER JOIN COMMIT_ALLOC_USAGE cua ON cua.capacity_commitment_alloc_gid = a.capacity_commitment_alloc_gid
    INNER JOIN 
WHERE 1 = 1
    AND rg.is_active = 'Y'
    AND cu.is_active = 'Y'
    AND rg.domain_name = 'NBL/MX'
    AND rg.x_lane_gid = 'MXC|MXC CHALCO'
--AND rg.RATE_OFFERING_GID LIKE '%CORONA%'
AND a.expiration_date >= sysdate
AND TO_CHAR(cu.START_DATE, 'dd/mm/yyyy') = '15/06/2025'
ORDER BY cu.start_date

---Validacion Corona Cua


------Query en Prod
SELECT DISTINCT rg.domain_name,
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
                cl.x_lane_gid             AS c1_x_lane_gid,
                cl.effective_date         c1_effective_date,
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
                a.effective_date          a_effective_date,
                a.expiration_date         a_expiration_date,
                a.allocation_group_gid,
                b.commit_perc,
                cu.start_date,
                cu.USAGE
FROM nbl_dw.wc_rate_geo_d  rg INNER JOIN 
    nbl_dw.wc_rate_offering_d ro ON ro.rate_offering_gid = rg.rate_offering_gid INNER JOIN 
    OTM.CAPACITY_GROUP cg ON ro.SERVPROV_GID = cg.SERVPROV_GID INNER JOIN
    nbl_dw.wc_capacity_limit_d cl ON cg.CAPACITY_GROUP_GID = cl.CAPACITY_GROUP_GID AND cl.x_lane_gid = rg.x_lane_gid INNER JOIN 
    nbl_dw.wc_capacity_usage_d cu ON cl.capacity_limit_gid = cu.capacity_limit_gid AND cu.start_date BETWEEN TRUNC(ADD_MONTHS(SYSDATE, -12), 'YY') AND LAST_DAY(SYSDATE) INNER JOIN 
    nbl_dw.wc_capacity_comnt_alloc_d a ON a.x_lane_gid = rg.x_lane_gid AND ro.transport_mode_gid = a.allocation_group_gid INNER JOIN 
    nbl_dw.wc_capacity_comnt_alloc_d b ON b.capacity_commitment_alloc_gid = a.capacity_commitment_alloc_gid AND ro.servprov_gid = b.servprov_gid
    AND ro.rate_offering_gid = b.rate_offering_gid
WHERE     1 = 1
       AND rg.is_active = 'Y'
       AND cu.is_active = 'Y'
       AND rg.domain_name = 'NBL/MX'
ORDER BY cu.start_date


SELECT * FROM COMMIT_ALLOC_USAGE_D
WHERE COMMIT_ALLOC_USAGE_GID = 'NBL/MX.MTY_PIEDRAS_NEGRAS_HIGH_25-0014'

SELECT * FROM COMMIT_ALLOC_USAGE
WHERE CAPACITY_COMMITMENT_ALLOC_GID = 'NBL/MX.MTY_PIEDRAS_NEGRAS_HIGH_25'






SELECT DISTINCT rg.domain_name,
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
                cl.x_lane_gid             AS c1_x_lane_gid,
                cl.effective_date         c1_effective_date,
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
                a.effective_date          a_effective_date,
                a.expiration_date         a_expiration_date,
                a.allocation_group_gid,
                b.commit_perc,
                cu.start_date,
                cu.USAGE
  FROM nbl_dw.wc_rate_geo_d  rg INNER JOIN 
      nbl_dw.wc_rate_offering_d ro ON ro.rate_offering_gid = rg.rate_offering_gid INNER JOIN 
      OTM.CAPACITY_GROUP cg ON ro.SERVPROV_GID = cg.SERVPROV_GID INNER JOIN
      nbl_dw.wc_capacity_limit_d cl ON cg.CAPACITY_GROUP_GID = cl.CAPACITY_GROUP_GID AND cl.x_lane_gid = rg.x_lane_gid INNER JOIN 
      nbl_dw.wc_capacity_usage_d cu ON cl.capacity_limit_gid = cu.capacity_limit_gid AND cu.start_date BETWEEN TRUNC(ADD_MONTHS(SYSDATE, -12), 'YY') AND LAST_DAY(SYSDATE) INNER JOIN 
      nbl_dw.wc_capacity_comnt_alloc_d a ON a.x_lane_gid = rg.x_lane_gid AND ro.transport_mode_gid = a.allocation_group_gid INNER JOIN 
      nbl_dw.wc_capacity_comnt_alloc_d b ON b.capacity_commitment_alloc_gid = a.capacity_commitment_alloc_gid AND ro.servprov_gid = b.servprov_gid
WHERE     1 = 1
       AND rg.is_active = 'Y'
       AND cu.is_active = 'Y'
       AND rg.domain_name = 'NBL/MX'
ORDER BY cu.start_date

---Analisis de Acapulco
--Casos de Agosto 2025

SELECT * FROM COMMIT_ALLOC_USAGE_D
WHERE COMMIT_ALLOC_USAGE_GID = 'NBL/MX.MXC_ACAPULCO_HIGH_25_V2-0087'

SELECT * FROM COMMIT_ALLOC_USAGE
WHERE CAPACITY_COMMITMENT_ALLOC_GID = 'NBL/MX.MXC_ACAPULCO_HIGH_25_V2'