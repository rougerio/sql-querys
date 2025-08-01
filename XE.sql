SELECT RM2.ORIGEN ORIGEN_MAY24, 
RM2.DESTINO DESTINO_MAY24, 
RF2.ORIGEN ORIGEN_FEB24, 
RF2.DESTINO DESTINO_FEB24, 
RM2.NICK_NAME NICK_NAME_MAY24, 
RM2.SERVICE_PROVIDER_ID SERVPROV_MAY24, 
RM2.TIPO_DE_UNIDAD TIPO_UNIDAD_MAY24, 
RF2.CARRIER NICK_NAME_FEB24, 
RF2.SERVICE_PROVIDER_ID SERVPROV_FEB24, 
RF2.TIPO_DE_UNIDAD TIPO_UNIDAD_FEB24,
ROUND(RM2.TARIFA) TARIFA_MAY24, 
ROUND(RF2.TARIFA_2024) TARIFA_FEB24, 
ROUND(RM2.TARIFA) - ROUND(RF2.TARIFA_2024) DIFF
FROM RATESMAY2024 RM2 LEFT JOIN
    RATESFEB2024 RF2 ON RM2.ORIGEN = RF2.ORIGEN 
                    AND RM2.DESTINO = RF2.DESTINO 
                    AND  RM2.SERVICE_PROVIDER_ID = RF2.SERVICE_PROVIDER_ID 
                    AND RM2.TIPO_DE_UNIDAD = RF2.TIPO_DE_UNIDAD
WHERE (ROUND(RM2.TARIFA) != ROUND(RF2.TARIFA_2024))
ORDER BY RM2.SERVICE_PROVIDER_ID, 
        RM2.ORIGEN, 
        RM2.DESTINO;

SELECT *
FROM RATESMAY2024
WHERE NICK_NAME = 'TMS'
ORDER BY ORIGEN;

SELECT *
FROM RATESFEB2024;
WHERE CARRIER = 'TMS';

SELECT *
FROM RATESMAR2024
WHERE NICK_NAME = 'TMS'
ORDER BY SOURCE;

SELECT RM2.ORIGEN ORIGEN_MAY24, 
RM2.DESTINO DESTINO_MAY24, 
RR2.SOURCE ORIGEN_MAR24, 
RR2.DESTINATION_CITY DESTINO_MAR24, 
RM2.NICK_NAME NICK_NAME_MAY24, 
RM2.SERVICE_PROVIDER_ID SERVPROV_MAY24, 
RM2.TIPO_DE_UNIDAD TIPO_UNIDAD_MAY24, 
RR2.NICK_NAME NICK_NAME_MAR24, 
RR2.SERVICE_PROVIDER_ID SERVPROV_MAR24, 
RR2.TIPO_DE_UNIDAD TIPO_UNIDAD_MAR24,
ROUND(RR2.TARIFA) TARIFA_MAR24, 
ROUND(RM2.TARIFA) TARIFA_MAY24, 
ROUND(RM2.TARIFA) - ROUND(RR2.TARIFA) DIFF
FROM RATESMAY2024 RM2 LEFT JOIN
    RATESMAR2024 RR2 ON RM2.ORIGEN = RR2.SOURCE
                    AND RM2.DESTINO = RR2.DESTINATION_CITY
                    AND  RM2.SERVICE_PROVIDER_ID = RR2.SERVICE_PROVIDER_ID 
                    AND RM2.TIPO_DE_UNIDAD = RR2.TIPO_DE_UNIDAD
WHERE (ROUND(RM2.TARIFA) != ROUND(RR2.TARIFA))
ORDER BY RM2.SERVICE_PROVIDER_ID, 
        RM2.ORIGEN, 
        RM2.DESTINO;


SELECT RM2.ORIGEN ORIGEN_MAY24, 
RM2.DESTINO DESTINO_MAY24, 
--RR2.SOURCE ORIGEN_MAR24, 
--RR2.DESTINATION_CITY DESTINO_MAR24, 
RM2.NICK_NAME NICK_NAME_MAY24, 
RM2.SERVICE_PROVIDER_ID SERVPROV_MAY24, 
RM2.TIPO_DE_UNIDAD TIPO_UNIDAD_MAY24, 
--RR2.NICK_NAME NICK_NAME_MAR24, 
--RR2.SERVICE_PROVIDER_ID SERVPROV_MAR24, 
--RR2.TIPO_DE_UNIDAD TIPO_UNIDAD_MAR24,
TO_NUMBER(RR2.TARIFA) TARIFA_MAR24, 
TO_NUMBER(RM2.TARIFA) TARIFA_MAY24, 
(RM2.TARIFA) - (RR2.TARIFA) DIFF
FROM RATESMAY2024 RM2 LEFT JOIN
    RATESMAR2024 RR2 ON RM2.ORIGEN = RR2.SOURCE
                    AND RM2.DESTINO = RR2.DESTINATION_CITY
                    AND  RM2.SERVICE_PROVIDER_ID = RR2.SERVICE_PROVIDER_ID 
                    AND RM2.TIPO_DE_UNIDAD = RR2.TIPO_DE_UNIDAD
WHERE (ROUND(RM2.TARIFA) != ROUND(RR2.TARIFA))
ORDER BY RM2.ORIGEN, 
         RM2.DESTINO,
         RM2.SERVICE_PROVIDER_ID;
         
         
SELECT JUNE24.ORIGEN ORIGEN_JUNE24, 
JUNE24.DESTINO DESTINO_JUNE24, 
--RR2.SOURCE ORIGEN_MAR24, 
--RR2.DESTINATION_CITY DESTINO_MAR24, 
JUNE24.NICK_NAME NICK_NAME_JUNE24, 
JUNE24.SERVICE_PROVIDER_ID SERVPROV_JUNE24, 
JUNE24.TIPO_DE_UNIDAD TIPO_UNIDAD_JUNE24, 
--RR2.NICK_NAME NICK_NAME_MAR24, 
--RR2.SERVICE_PROVIDER_ID SERVPROV_MAR24, 
--RR2.TIPO_DE_UNIDAD TIPO_UNIDAD_MAR24,
TO_NUMBER(MAY24.TARIFA) TARIFA_MAY24, 
TO_NUMBER(JUNE24.TARIFA) TARIFA_JUNE24, 
(JUNE24.TARIFA) - (MAY24.TARIFA) DIFF
FROM RATESJUN2024 JUNE24 LEFT JOIN
    RATESMAY2024 MAY24 ON JUNE24.ORIGEN = MAY24.ORIGEN
                    AND JUNE24.DESTINO = MAY24.DESTINO
                    AND  JUNE24.SERVICE_PROVIDER_ID = MAY24.SERVICE_PROVIDER_ID 
                    AND JUNE24.TIPO_DE_UNIDAD = MAY24.TIPO_DE_UNIDAD
WHERE (ROUND(JUNE24.TARIFA) != ROUND(MAY24.TARIFA))
ORDER BY JUNE24.ORIGEN, 
         JUNE24.DESTINO,
         JUNE24.SERVICE_PROVIDER_ID;
         
SELECT *
FROM RATESJUN2024;

RATESMAY2024