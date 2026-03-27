DECLARE
    cols VARCHAR2(12000);
    sql_query VARCHAR2(12000);
BEGIN
    -- Get the list of years dynamically
    SELECT LISTAGG('' || ACCESSORIAL_CODE_U || '', ',') 
    INTO cols
    FROM (
            SELECT SHIPMENT_XID, SCAC_XID, DELIVERIES, STATUS_VALUE_XID, SOU_CITY, DEST_CITY, DEST_STATE, MILEAGE,
            RATE_OFFERING_GID, RATE_GEO_GID, TOTAL_BASE_COST, FSC_NIAGARA, ACCESSORIAL_CODE, ACCESORIAL_COST, ACCESSORIAL_CODE_U
            FROM OTM_DATA_UBER_UNIQUE
    );
    sql_query := '
    DROP TABLE OTM_DATA_FINAL';

    
    EXECUTE IMMEDIATE sql_query;

    -- Construct the dynamic SQL query
    sql_query := '
    CREATE TABLE OTM_DATA_FINAL AS (
                SELECT * 
                FROM ( 
                    SELECT SHIPMENT_XID, SCAC_XID, DELIVERIES, STATUS_VALUE_XID, SOU_CITY, DEST_CITY, DEST_STATE, MILEAGE,
                    RATE_OFFERING_GID, RATE_GEO_GID, TOTAL_BASE_COST, FSC_NIAGARA, ACCESORIAL_COST, ACCESSORIAL_CODE_U
                    FROM OTM_DATA_UBER_UNIQUE
                ) 
                PIVOT ( 
                    MIN(ACCESORIAL_COST) 
                    FOR ACCESSORIAL_CODE_U IN ('|| cols ||') 
                ) 
                )';
    -- Execute the dynamic SQL query
    EXECUTE IMMEDIATE sql_query;
    COMMIT;
END;