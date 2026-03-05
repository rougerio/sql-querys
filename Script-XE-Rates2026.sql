SELECT * 
FROM (
        SELECT * 
        FROM (
                SELECT ID, ORIGEN, DESTINO, LOC, FIND, ESTADO, CAR_ID, NEW_ID, CARRIER, RAZON_SOCIAL, TIPO_DE_UNIDAD, TARIFA_2026_V2, COMENTARIOS, UPDATES, TIPO, RO1.RATE_OFFERING_GID
                FROM (
                        SELECT T.ID, T.ORIGEN, T.DESTINO, T.LOC, T.FIND, T.ESTADO, T.CAR_ID, C.OLD_ID, C.NEW_ID, T.CARRIER, T.RAZON_SOCIAL, T.TIPO_DE_UNIDAD, 
                        T.TARIFA_2026_V2, T.COMENTARIOS, T.UPDATES, T.TIPO
                        FROM (
                                SELECT ID, ORIGEN, DESTINO, LOC, FIND, ESTADO, 'NBL.' || CAR_ID AS CAR_ID, CARRIER, RAZON_SOCIAL, 
                                TIPO_DE_UNIDAD, TARIFA_2026_V2, COMENTARIOS, UPDATES, 
                                CASE 
                                    WHEN COMENTARIOS LIKE '%Drop%' THEN 'DROP'
                                    WHEN COMENTARIOS LIKE '%Transferencia%' OR TIPO_DE_UNIDAD LIKE '%Ferrocarril%' THEN 'TRFS'
                                    WHEN TIPO_DE_UNIDAD LIKE '%Dedicado%' THEN 'DEDICADO'
                                    ELSE 'RATE'
                                END AS TIPO
                                FROM OTM_RATES_2026
                        ) T LEFT JOIN
                        OTM_DATA_CARRIER_OLD_NEW C ON T.CAR_ID = C.OLD_ID
                        WHERE 1 = 1
                        AND TIPO = 'RATE'
                ) RA LEFT JOIN
                OTM_RATE_OFFERING RO1 ON RO1.SERVPROV_GID = RA.NEW_ID AND RA.TIPO = 'RATE' AND RO1.RATE_OFFERING_GID NOT LIKE '%TRFS%' 
                                    AND RO1.RATE_OFFERING_GID NOT LIKE '%DEDICADO%' AND RO1.RATE_OFFERING_GID NOT LIKE '%DROP%'
                                    AND RO1.RATE_OFFERING_GID NOT LIKE '%TRSF%' 
        ) T1
        UNION ALL
        SELECT * 
        FROM (
                SELECT ID, ORIGEN, DESTINO, LOC, FIND, ESTADO, CAR_ID, NEW_ID, CARRIER, RAZON_SOCIAL, TIPO_DE_UNIDAD, TARIFA_2026_V2, COMENTARIOS, UPDATES, TIPO, RO1.RATE_OFFERING_GID
                FROM (
                        SELECT T.ID, T.ORIGEN, T.DESTINO, T.LOC, T.FIND, T.ESTADO, T.CAR_ID, C.OLD_ID, C.NEW_ID, T.CARRIER, T.RAZON_SOCIAL, T.TIPO_DE_UNIDAD, 
                        T.TARIFA_2026_V2, T.COMENTARIOS, T.UPDATES, T.TIPO
                        FROM (
                                SELECT ID, ORIGEN, DESTINO, LOC, FIND, ESTADO, 'NBL.' || CAR_ID AS CAR_ID, CARRIER, RAZON_SOCIAL, 
                                TIPO_DE_UNIDAD, TARIFA_2026_V2, COMENTARIOS, UPDATES, 
                                CASE 
                                    WHEN COMENTARIOS LIKE '%Drop%' THEN 'DROP'
                                    WHEN COMENTARIOS LIKE '%Transferencia%' OR TIPO_DE_UNIDAD LIKE '%Ferrocarril%' THEN 'TRFS'
                                    WHEN TIPO_DE_UNIDAD LIKE '%Dedicado%' THEN 'DEDICADO'
                                    ELSE 'RATE'
                                END AS TIPO
                                FROM OTM_RATES_2026
                        ) T LEFT JOIN
                        OTM_DATA_CARRIER_OLD_NEW C ON T.CAR_ID = C.OLD_ID
                        WHERE 1 = 1
                        AND TIPO = 'TRFS'
                ) RA LEFT JOIN
                OTM_RATE_OFFERING RO1 ON RO1.SERVPROV_GID = RA.NEW_ID AND RA.TIPO = 'TRFS' AND RO1.RATE_OFFERING_GID LIKE '%TRFS%' 
                                    AND RO1.RATE_OFFERING_GID NOT LIKE '%DEDICADO%' AND RO1.RATE_OFFERING_GID NOT LIKE '%DROP%'
                                    AND RO1.RATE_OFFERING_GID LIKE '%TRSF%'
                WHERE 1 = 1
        ) T2
        UNION ALL
        SELECT * 
        FROM (
                SELECT ID, ORIGEN, DESTINO, LOC, FIND, ESTADO, CAR_ID, NEW_ID, CARRIER, RAZON_SOCIAL, TIPO_DE_UNIDAD, TARIFA_2026_V2, COMENTARIOS, UPDATES, TIPO, RO1.RATE_OFFERING_GID
                FROM (
                        SELECT T.ID, T.ORIGEN, T.DESTINO, T.LOC, T.FIND, T.ESTADO, T.CAR_ID, C.OLD_ID, C.NEW_ID, T.CARRIER, T.RAZON_SOCIAL, T.TIPO_DE_UNIDAD, 
                        T.TARIFA_2026_V2, T.COMENTARIOS, T.UPDATES, T.TIPO
                        FROM (
                                SELECT ID, ORIGEN, DESTINO, LOC, FIND, ESTADO, 'NBL.' || CAR_ID AS CAR_ID, CARRIER, RAZON_SOCIAL, 
                                TIPO_DE_UNIDAD, TARIFA_2026_V2, COMENTARIOS, UPDATES, 
                                CASE 
                                    WHEN COMENTARIOS LIKE '%Drop%' THEN 'DROP'
                                    WHEN COMENTARIOS LIKE '%Transferencia%' OR TIPO_DE_UNIDAD LIKE '%Ferrocarril%' THEN 'TRFS'
                                    WHEN TIPO_DE_UNIDAD LIKE '%Dedicado%' THEN 'DEDICADO'
                                    ELSE 'RATE'
                                END AS TIPO
                                FROM OTM_RATES_2026
                        ) T LEFT JOIN
                        OTM_DATA_CARRIER_OLD_NEW C ON T.CAR_ID = C.OLD_ID
                        WHERE 1 = 1
                        AND TIPO = 'DROP'
                ) RA LEFT JOIN
                OTM_RATE_OFFERING RO1 ON RO1.SERVPROV_GID = RA.NEW_ID AND RA.TIPO = 'DROP' AND RO1.RATE_OFFERING_GID NOT LIKE '%TRFS%' 
                                    AND RO1.RATE_OFFERING_GID NOT LIKE '%DEDICADO%' AND RO1.RATE_OFFERING_GID LIKE '%DROP%'
                                    AND RO1.RATE_OFFERING_GID NOT LIKE '%TRSF%'
                WHERE 1 = 1
        ) T3
        UNION ALL
        SELECT * 
        FROM (
                SELECT ID, ORIGEN, DESTINO, LOC, FIND, ESTADO, CAR_ID, NEW_ID, CARRIER, RAZON_SOCIAL, TIPO_DE_UNIDAD, TARIFA_2026_V2, COMENTARIOS, UPDATES, TIPO, RO1.RATE_OFFERING_GID
                FROM (
                        SELECT T.ID, T.ORIGEN, T.DESTINO, T.LOC, T.FIND, T.ESTADO, T.CAR_ID, C.OLD_ID, C.NEW_ID, T.CARRIER, T.RAZON_SOCIAL, T.TIPO_DE_UNIDAD, 
                        T.TARIFA_2026_V2, T.COMENTARIOS, T.UPDATES, T.TIPO
                        FROM (
                                SELECT ID, ORIGEN, DESTINO, LOC, FIND, ESTADO, 'NBL.' || CAR_ID AS CAR_ID, CARRIER, RAZON_SOCIAL, 
                                TIPO_DE_UNIDAD, TARIFA_2026_V2, COMENTARIOS, UPDATES, 
                                CASE 
                                    WHEN COMENTARIOS LIKE '%Drop%' THEN 'DROP'
                                    WHEN COMENTARIOS LIKE '%Transferencia%' OR TIPO_DE_UNIDAD LIKE '%Ferrocarril%' THEN 'TRFS'
                                    WHEN TIPO_DE_UNIDAD LIKE '%Dedicado%' THEN 'DEDICADO'
                                    ELSE 'RATE'
                                END AS TIPO
                                FROM OTM_RATES_2026
                        ) T LEFT JOIN
                        OTM_DATA_CARRIER_OLD_NEW C ON T.CAR_ID = C.OLD_ID
                        WHERE 1 = 1
                        AND TIPO = 'DEDICADO'
                ) RA LEFT JOIN
                OTM_RATE_OFFERING RO1 ON RO1.SERVPROV_GID = RA.NEW_ID AND RA.TIPO = 'DEDICADO' AND RO1.RATE_OFFERING_GID NOT LIKE '%TRFS%' 
                                    AND RO1.RATE_OFFERING_GID LIKE '%DEDICADO%' AND RO1.RATE_OFFERING_GID NOT LIKE '%DROP%'
                                    AND RO1.RATE_OFFERING_GID NOT LIKE '%TRSF%'
                WHERE 1 = 1
        ) T4
) RATES
WHERE 1 = 1
;

/*
SELECT *
FROM OTM_DATA_CARRIER_OLD_NEW
WHERE OLD_ID LIKE '%4879249%'; 

UPDATE OTM_RATES_2026 A SET TIPO_DE_UNIDAD = (
    SELECT F.TIPO_DE_UNIDAD--F.ID, F.ORIGEN, F.DESTINO, F.LOC, F.FIND, F.ESTADO, F.CAR_ID, F.CARRIER, F.RAZON_SOCIAL, F.TIPO_DE_UNIDAD, F.TIPO_UNIDAD_OLD, F.TARIFA_2026_V2, F.COMENTARIOS, F.UPDATES
    FROM (
            SELECT R.ID, R.ORIGEN, R.DESTINO, R.LOC, R.FIND, R.ESTADO, R.CAR_ID, R.CARRIER, R.RAZON_SOCIAL, 
            R.TIPO_DE_UNIDAD AS TIPO_UNIDAD_OLD, O.TIPO_DE_UNIDAD, R.TARIFA_2026_V2, R.COMENTARIOS, R.UPDATES
            FROM OTM_RATES_2026 R LEFT JOIN
            OTM_RATES_ORG_2026 O ON R.ORIGEN = O.ORIGEN AND R.DESTINO = O.DESTINO AND R.ESTADO = O.ESTADO AND R.CAR_ID = O.CAR_ID AND R.CARRIER = O.CARRIER 
            AND R.RAZON_SOCIAL = O.RAZON_SOCIAL AND R.TARIFA_2026_V2 = O.TARIFA_2026_V2
    ) F
    WHERE F.TIPO_UNIDAD_OLD IS NULL
    AND F.ID = A.ID
) WHERE EXISTS (
    SELECT 1
    FROM (
            SELECT R.ID, R.ORIGEN, R.DESTINO, R.LOC, R.FIND, R.ESTADO, R.CAR_ID, R.CARRIER, R.RAZON_SOCIAL, 
            R.TIPO_DE_UNIDAD AS TIPO_UNIDAD_OLD, O.TIPO_DE_UNIDAD, R.TARIFA_2026_V2, R.COMENTARIOS, R.UPDATES
            FROM OTM_RATES_2026 R LEFT JOIN
            OTM_RATES_ORG_2026 O ON R.ORIGEN = O.ORIGEN AND R.DESTINO = O.DESTINO AND R.ESTADO = O.ESTADO AND R.CAR_ID = O.CAR_ID AND R.CARRIER = O.CARRIER 
            AND R.RAZON_SOCIAL = O.RAZON_SOCIAL AND R.TARIFA_2026_V2 = O.TARIFA_2026_V2
    ) F
    WHERE F.TIPO_UNIDAD_OLD IS NULL
    AND F.ID = A.ID)
;

SELECT * 
FROM OTM_RATES_2026;


UPDATE OTM_RATES_2026 SET CAR_ID = 'CAR-4810107'
WHERE RAZON_SOCIAL = 'TRANSPORT MARTIN SA DE CV';


--NBL.​CAR-4810107
--NBL.CAR-2354403

*/