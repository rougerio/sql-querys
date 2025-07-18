--Final Query
SELECT order_release_gid
FROM order_release o
WHERE o.order_release_gid = ?
AND ( EXISTS
    (
    SELECT '1'
    FROM order_release_refnum or2
    WHERE or2.order_release_refnum_qual_gid LIKE '%REF_VALUE%'
    AND (length(or2.order_release_refnum_value) < 30)
    AND or2.order_release_gid = o.order_release_gid
) OR 
    NOT EXISTS 
(
    SELECT '1'
    FROM order_release_refnum orr
    WHERE orr.order_release_refnum_qual_gid LIKE '%REF_VALUE%'
    AND orr.order_release_gid = o.order_release_gid
)
);
------------------------------------------------------

SELECT * 
FROM order_release_refnum or2
WHERE or2.order_release_refnum_qual_gid LIKE '%REF_VALUE%'
AND (length(or2.order_release_refnum_value) < 30)
AND or2.order_release_gid = 'NBL/MX.36511856';



SELECT DISTINCT O.ORDER_RELEASE_GID 
FROM ORDER_RELEASE O 
WHERE O.ORDER_RELEASE_GID = ? 
AND NOT EXISTS (SELECT '1' 
FROM ORDER_RELEASE_REFNUM R , ORDER_RELEASE_REFNUM ORR 
WHERE ORR.ORDER_RELEASE_REFNUM_QUAL_GID = 'NBL.REF_VALUE' 
AND R.ORDER_RELEASE_REFNUM_QUAL_GID = 'NBL.REF_VALUE' 
AND ORR.ORDER_RELEASE_GID = R.ORDER_RELEASE_GID 
AND R.ORDER_RELEASE_REFNUM_VALUE!= ORR.ORDER_RELEASE_REFNUM_VALUE 
AND O.ORDER_RELEASE_GID = R.ORDER_RELEASE_GID 
AND O.ORDER_RELEASE_GID = ORR.ORDER_RELEASE_GID)


SELECT DISTINCT O.ORDER_RELEASE_GID 
FROM ORDER_RELEASE O 
WHERE O.ORDER_RELEASE_GID = 'NBL/MX.38372545'
AND NOT EXISTS (
                    SELECT '1' 
                    FROM ORDER_RELEASE_REFNUM R , ORDER_RELEASE_REFNUM ORR 
                    WHERE ORR.ORDER_RELEASE_REFNUM_QUAL_GID = 'NBL.CUS_LOAD_REF'
                    AND R.ORDER_RELEASE_REFNUM_QUAL_GID = 'NBL.CUS_LOAD_REF'
                    AND ORR.ORDER_RELEASE_GID = R.ORDER_RELEASE_GID 
                    AND R.ORDER_RELEASE_REFNUM_VALUE != ORR.ORDER_RELEASE_REFNUM_VALUE 
                    AND O.ORDER_RELEASE_GID = R.ORDER_RELEASE_GID 
                    AND O.ORDER_RELEASE_GID = ORR.ORDER_RELEASE_GID
                )

SELECT R.* 
FROM ORDER_RELEASE_REFNUM R , ORDER_RELEASE_REFNUM ORR 
WHERE ORR.ORDER_RELEASE_REFNUM_QUAL_GID = 'NBL.CUS_LOAD_REF'
AND R.ORDER_RELEASE_REFNUM_QUAL_GID = 'NBL.CUS_LOAD_REF'
AND ORR.ORDER_RELEASE_GID = R.ORDER_RELEASE_GID 
AND R.ORDER_RELEASE_REFNUM_VALUE!= ORR.ORDER_RELEASE_REFNUM_VALUE 
AND R.ORDER_RELEASE_GID = 'NBL/MX.38372545'


-----Validacion CUS_LOAD_REF
SELECT order_release_gid 
FROM order_release o 
WHERE o.order_release_gid = ? 
AND (
        NOT EXISTS  
        ( 
            SELECT '1' 
            FROM order_release_refnum orr 
            WHERE orr.order_release_refnum_qual_gid = 'NBL.CUS_LOAD_REF' 
            AND orr.order_release_gid = o.order_release_gid 
        ) 
    OR 
    EXISTS 
        ( 
        SELECT '1' 
        FROM order_release_refnum or2 
        WHERE or2.order_release_refnum_qual_gid = 'NBL.CUS_LOAD_REF' 
        AND (length(or2.order_release_refnum_value) < 30) 
        AND or2.order_release_gid = o.order_release_gid 
    ) 
) ;

Only one cus_load_ref refnum is allowed.


38372545


SELECT order_release_gid
FROM order_release o
WHERE o.order_release_gid = 'NBL/MX.38372545'
AND (
    NOT EXISTS 
    (
        SELECT '1'
        FROM order_release_refnum orr
        WHERE orr.order_release_refnum_qual_gid = 'NBL.CUS_LOAD_REF'
        AND orr.order_release_gid = o.order_release_gid
    )
    OR
    EXISTS
        (
        SELECT '1'
        FROM order_release_refnum or2
        WHERE or2.order_release_refnum_qual_gid = 'NBL.CUS_LOAD_REF'
        AND (length(or2.order_release_refnum_value) < 30)
        AND or2.order_release_gid = o.order_release_gid
    )
)
;


SELECT DISTINCT O.ORDER_RELEASE_GID 
FROM ORDER_RELEASE O  
WHERE O.ORDER_RELEASE_GID = ? 
AND NOT EXISTS ( 
                    SELECT '1'  
                    FROM ORDER_RELEASE_REFNUM R , ORDER_RELEASE_REFNUM ORR  
                    WHERE ORR.ORDER_RELEASE_REFNUM_QUAL_GID = 'NBL.CUS_LOAD_REF' 
                    AND R.ORDER_RELEASE_REFNUM_QUAL_GID = 'NBL.CUS_LOAD_REF' 
                    AND ORR.ORDER_RELEASE_GID = R.ORDER_RELEASE_GID  
                    AND R.ORDER_RELEASE_REFNUM_VALUE != ORR.ORDER_RELEASE_REFNUM_VALUE  
                    AND O.ORDER_RELEASE_GID = R.ORDER_RELEASE_GID  
                    AND O.ORDER_RELEASE_GID = ORR.ORDER_RELEASE_GID 
                ) 