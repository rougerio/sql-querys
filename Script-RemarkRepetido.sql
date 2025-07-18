SELECT
    sh.shipment_gid,
    sh.source_location_gid,
    sh.dest_location_gid,
    sh.rate_geo_gid,
    sh.transport_mode_gid,
    sh.user_defined5_icon_gid,
    (
        SELECT
            sr_r0.shipment_refnum_value
        FROM
            shipment_refnum      sr_r0,
            shipment_refnum_qual srq_r0
        WHERE
                1 = 1
            AND ( sr_r0.shipment_refnum_qual_gid = srq_r0.shipment_refnum_qual_gid )
            AND ( ( srq_r0.shipment_refnum_qual_xid = 'CUST_PO_GROUP' )
                  OR ( srq_r0.shipment_refnum_qual_xid IS NULL ) )
            AND ( sh.shipment_gid = sr_r0.shipment_gid )
    ) AS pseudo_r0,
    (
        SELECT
            ls.location_name
        FROM
            location ls
        WHERE
            ( sh.source_location_gid = ls.location_gid )
    ),
    (
        SELECT
            sr_r1.shipment_refnum_value
        FROM
            shipment_refnum      sr_r1,
            shipment_refnum_qual srq_r1
        WHERE
                1 = 1
            AND ( sr_r1.shipment_refnum_qual_gid = srq_r1.shipment_refnum_qual_gid )
            AND ( ( srq_r1.shipment_refnum_qual_xid = 'OR_GROUP' )
                  OR ( srq_r1.shipment_refnum_qual_xid IS NULL ) )
            AND ( sh.shipment_gid = sr_r1.shipment_gid )
    ) AS pseudo_r1,
    sh.indicator,
    (
        SELECT
            icon1.path
        FROM
            icon icon1
        WHERE
            ( sh.user_defined1_icon_gid = icon1.icon_gid )
    ),
    (
        SELECT
            esr_r2.remark_text
        FROM
            shipment_remark esr_r2,
            remark_qual     rq_r2
        WHERE
                1 = 1
            AND ( esr_r2.remark_qual_gid = rq_r2.remark_qual_gid (+) )
            AND ( ( rq_r2.remark_qual_xid = 'SHIP_DATE' )
                  OR ( rq_r2.remark_qual_xid IS NULL ) )
            AND ( sh.shipment_gid = esr_r2.shipment_gid )
    ) AS pseudo_r2,
    (
        SELECT
            esr_r3.remark_text
        FROM
            shipment_remark esr_r3,
            remark_qual     rq_r3
        WHERE
                1 = 1
            AND ( esr_r3.remark_qual_gid = rq_r3.remark_qual_gid (+) )
            AND ( ( rq_r3.remark_qual_xid = 'PU_APPOINTMENT' )
                  OR ( rq_r3.remark_qual_xid IS NULL ) )
            AND ( sh.shipment_gid = esr_r3.shipment_gid )
    ) AS pseudo_r3,
    (
        SELECT
            esr_r4.remark_text
        FROM
            shipment_remark esr_r4,
            remark_qual     rq_r4
        WHERE
                1 = 1
            AND ( esr_r4.remark_qual_gid = rq_r4.remark_qual_gid (+) )
            AND ( ( rq_r4.remark_qual_xid = 'DELIVERY_STOP_2' )
                  OR ( rq_r4.remark_qual_xid IS NULL ) )
            AND ( sh.shipment_gid = esr_r4.shipment_gid )
    ) AS pseudo_r4,
    (
        SELECT
            ld.location_name
        FROM
            location ld
        WHERE
            ( sh.dest_location_gid = ld.location_gid )
    ),
    (
        SELECT
            servloc.location_name
        FROM
            location servloc,
            servprov car
        WHERE
            ( car.servprov_gid = servloc.location_gid )
            AND ( sh.servprov_gid = car.servprov_gid )
    ),
    (
        SELECT
            sv_r5.status_value_xid
        FROM
            status_value    sv_r5,
            shipment_status ss_r5,
            status_type     st_r5
        WHERE
                1 = 1
            AND ( ss_r5.status_value_gid = sv_r5.status_value_gid )
            AND ( ss_r5.status_type_gid = st_r5.status_type_gid )
            AND ( ( st_r5.status_type_xid = 'WMS_STATUS' )
                  OR ( st_r5.status_type_xid IS NULL ) )
            AND ( sh.shipment_gid = ss_r5.shipment_gid )
    ) AS pseudo_r5,
    sh.start_time,
    (
        SELECT
            sr_r6.shipment_refnum_value
        FROM
            shipment_refnum      sr_r6,
            shipment_refnum_qual srq_r6
        WHERE
                1 = 1
            AND ( sr_r6.shipment_refnum_qual_gid = srq_r6.shipment_refnum_qual_gid )
            AND ( ( srq_r6.shipment_refnum_qual_xid = 'IS_PRELOAD' )
                  OR ( srq_r6.shipment_refnum_qual_xid IS NULL ) )
            AND ( sh.shipment_gid = sr_r6.shipment_gid )
    ) AS pseudo_r6,
    sh.attribute3,
    (
        SELECT
            sr_r7.shipment_refnum_value
        FROM
            shipment_refnum      sr_r7,
            shipment_refnum_qual srq_r7
        WHERE
                1 = 1
            AND ( sr_r7.shipment_refnum_qual_gid = srq_r7.shipment_refnum_qual_gid )
            AND ( ( srq_r7.shipment_refnum_qual_xid = 'CPU_CONTACT' )
                  OR ( srq_r7.shipment_refnum_qual_xid IS NULL ) )
            AND ( sh.shipment_gid = sr_r7.shipment_gid )
    ) AS pseudo_r7,
    sh.source_location_gid,
    (
        SELECT
            sr_r8.shipment_refnum_value
        FROM
            shipment_refnum      sr_r8,
            shipment_refnum_qual srq_r8
        WHERE
                1 = 1
            AND ( sr_r8.shipment_refnum_qual_gid = srq_r8.shipment_refnum_qual_gid )
            AND ( ( srq_r8.shipment_refnum_qual_xid = 'SO_NUM_GROUP' )
                  OR ( srq_r8.shipment_refnum_qual_xid IS NULL ) )
            AND ( sh.shipment_gid = sr_r8.shipment_gid )
    ) AS pseudo_r8,
    sh.dest_location_gid,
    (
        SELECT
            ld.city
        FROM
            location ld
        WHERE
            ( sh.dest_location_gid = ld.location_gid )
    ),
    (
        SELECT
            ld.province_code
        FROM
            location ld
        WHERE
            ( sh.dest_location_gid = ld.location_gid )
    ),
    sh.attribute2,
    (
        SELECT
            icon4.path
        FROM
            icon icon4
        WHERE
            ( sh.user_defined4_icon_gid = icon4.icon_gid )
    ),
    sh.rate_geo_gid,
    (
        SELECT
            sr_r9.shipment_refnum_value
        FROM
            shipment_refnum      sr_r9,
            shipment_refnum_qual srq_r9
        WHERE
                1 = 1
            AND ( sr_r9.shipment_refnum_qual_gid = srq_r9.shipment_refnum_qual_gid )
            AND ( ( srq_r9.shipment_refnum_qual_xid = 'BASE_COST' )
                  OR ( srq_r9.shipment_refnum_qual_xid IS NULL ) )
            AND ( sh.shipment_gid = sr_r9.shipment_gid )
    ) AS pseudo_r9,
    sh.total_actual_cost,
    sh.original_invoice_cost,
    sh.tot_matched_invoice_cost,
    sh.total_approved_cost,
    sh.total_weight,
    (
        SELECT
            sr_r10.shipment_refnum_value
        FROM
            shipment_refnum      sr_r10,
            shipment_refnum_qual srq_r10
        WHERE
                1 = 1
            AND ( sr_r10.shipment_refnum_qual_gid = srq_r10.shipment_refnum_qual_gid )
            AND ( ( srq_r10.shipment_refnum_qual_xid = 'TOTAL_PALLET' )
                  OR ( srq_r10.shipment_refnum_qual_xid IS NULL ) )
            AND ( sh.shipment_gid = sr_r10.shipment_gid )
    ) AS pseudo_r10,
    sh.loaded_distance,
    (
        SELECT
            sv_r11.status_value_xid
        FROM
            status_value    sv_r11,
            shipment_status ss_r11,
            status_type     st_r11
        WHERE
                1 = 1
            AND ( ss_r11.status_value_gid = sv_r11.status_value_gid )
            AND ( ss_r11.status_type_gid = st_r11.status_type_gid )
            AND ( ( st_r11.status_type_xid = 'TENDER_HOLD' )
                  OR ( st_r11.status_type_xid IS NULL ) )
            AND ( sh.shipment_gid = ss_r11.shipment_gid )
    ) AS pseudo_r11,
    (
        SELECT
            sv_r12.status_value_xid
        FROM
            status_value    sv_r12,
            shipment_status ss_r12,
            status_type     st_r12
        WHERE
                1 = 1
            AND ( ss_r12.status_value_gid = sv_r12.status_value_gid )
            AND ( ss_r12.status_type_gid = st_r12.status_type_gid )
            AND ( ( st_r12.status_type_xid = 'TENDER_SPOT_BID' )
                  OR ( st_r12.status_type_xid IS NULL ) )
            AND ( sh.shipment_gid = ss_r12.shipment_gid )
    ) AS pseudo_r12,
    sh.insert_user,
    sh.insert_date,
    sh.update_user,
    sh.update_date,
    (
        SELECT
            sr_r13.shipment_refnum_value
        FROM
            shipment_refnum      sr_r13,
            shipment_refnum_qual srq_r13
        WHERE
                1 = 1
            AND ( sr_r13.shipment_refnum_qual_gid = srq_r13.shipment_refnum_qual_gid )
            AND ( ( srq_r13.shipment_refnum_qual_xid = 'ORIGINAL_REQ_DATE_GROUP' )
                  OR ( srq_r13.shipment_refnum_qual_xid IS NULL ) )
            AND ( sh.shipment_gid = sr_r13.shipment_gid )
    ) AS pseudo_r13,
    sh.transport_mode_gid,
    (
        SELECT
            sr_r14.shipment_refnum_value
        FROM
            shipment_refnum      sr_r14,
            shipment_refnum_qual srq_r14
        WHERE
                1 = 1
            AND ( sr_r14.shipment_refnum_qual_gid = srq_r14.shipment_refnum_qual_gid )
            AND ( ( srq_r14.shipment_refnum_qual_xid = 'QTY_MOD' )
                  OR ( srq_r14.shipment_refnum_qual_xid IS NULL ) )
            AND ( sh.shipment_gid = sr_r14.shipment_gid )
    ) AS pseudo_r14,
    (
        SELECT
            icon3.path
        FROM
            icon icon3
        WHERE
            ( sh.user_defined3_icon_gid = icon3.icon_gid )
    ),
    sh.user_defined5_icon_gid,
    sh.num_stops,
    (
        SELECT
            sr_r15.shipment_refnum_value
        FROM
            shipment_refnum      sr_r15,
            shipment_refnum_qual srq_r15
        WHERE
                1 = 1
            AND ( sr_r15.shipment_refnum_qual_gid = srq_r15.shipment_refnum_qual_gid )
            AND ( ( srq_r15.shipment_refnum_qual_xid = 'REF_VALUE_GROUP' )
                  OR ( srq_r15.shipment_refnum_qual_xid IS NULL ) )
            AND ( sh.shipment_gid = sr_r15.shipment_gid )
    ) AS pseudo_r15,
    sh.total_item_package_count,
    sh.domain_name,
    (
        SELECT
            sv_r16.status_value_xid
        FROM
            status_value    sv_r16,
            shipment_status ss_r16,
            status_type     st_r16
        WHERE
                1 = 1
            AND ( ss_r16.status_value_gid = sv_r16.status_value_gid )
            AND ( ss_r16.status_type_gid = st_r16.status_type_gid )
            AND ( ( st_r16.status_type_xid = 'TIER' )
                  OR ( st_r16.status_type_xid IS NULL ) )
            AND ( sh.shipment_gid = ss_r16.shipment_gid )
    ) AS pseudo_r16,
    (
        SELECT
            sv_r17.status_value_xid
        FROM
            status_value    sv_r17,
            shipment_status ss_r17,
            status_type     st_r17
        WHERE
                1 = 1
            AND ( ss_r17.status_value_gid = sv_r17.status_value_gid )
            AND ( ss_r17.status_type_gid = st_r17.status_type_gid )
            AND ( ( st_r17.status_type_xid = 'SECURE RESOURCES' )
                  OR ( st_r17.status_type_xid IS NULL ) )
            AND ( sh.shipment_gid = ss_r17.shipment_gid )
    ) AS pseudo_r17,
    sh.drop_inventory_processed,
    sh.attribute4,
    sh.t_actual_cost_currency_gid,
    sh.original_invoice_cost_curr_gid,
    sh.tot_matched_inv_cost_curr_gid,
    sh.total_approved_cost_curr_gid,
    sh.total_weight_uom_code,
    sh.loaded_distance_uom_code,
    (
        SELECT
            sl.time_zone_gid
        FROM
            location sl
        WHERE
            sl.location_gid = sh.source_location_gid
    ),
    sh.exchange_rate_date,
    sh.exchange_rate_date,
    sh.exchange_rate_date,
    sh.exchange_rate_date,
    sh.exchange_rate_gid,
    sh.exchange_rate_gid,
    sh.exchange_rate_gid,
    sh.exchange_rate_gid,
    sh.total_actual_c_fn_currency_gid,
    sh.original_inv_c_fn_currency_gid,
    sh.tot_match_inv_fn_currency_gid,
    sh.total_app_cost_fn_currency_gid,
    sh.total_actual_c_fn,
    sh.original_inv_c_fn,
    sh.tot_match_inv_fn,
    sh.total_app_cost_fn
FROM
    shipment      sh,
    shipment_type stp
WHERE
    ( ( ( sh.shipment_gid IN (
    --'NBL/MX.MX24056687', 
'NBL/MX.MX24056495'
--'NBL/MX.MX24056390'
--'NBL/MX.MX24056527'
--'NBL/MX.MX24056382'
--'NBL/MX.MX24055869'
--'NBL/MX.MX24056853'
--'NBL/MX.MX24056776' 
--'NBL/MX.MX24056166'
--'NBL/MX.MX24056858' 
--'NBL/MX.MX24056859' 
--'NBL/MX.MX24056544' 
--'NBL/MX.MX24056465' 
--'NBL/MX.MX24056558' 
--'NBL/MX.MX24056163' 
--'NBL/MX.MX24055644' 
--'NBL/MX.MX24056401' 
--'NBL/MX.MX24056396'
) ) ) )
    AND ( sh.perspective = 'B' )
    AND ( sh.shipment_type_gid = stp.shipment_type_gid )
    AND ( stp.shipment_type_xid != 'NON FREIGHT RELATED CHARGE' );




--MX24056687,MX24056495,MX24056390,MX24056527,MX24056382,MX24055869,MX24056853,MX24056776,MX24056166,MX24056858,MX24056859,MX24056544,MX24056465,MX24056558,MX24056163,MX24055644,MX24056401,MX24056396