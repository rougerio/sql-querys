SELECT DISTINCT hca.account_number customer_number,
            hp.party_name customer_name,
            hps.party_site_number site_number, 
            --hl.address1 address1,
            --hl.address2 address2, 
            --hl.address3 address3,
            --hl.address4 address4, 
            hl.city city,
            --hl.postal_code postal_code, 
            hl.state state,
            --length(hl.state) lengthState, 
            ftt.territory_short_name country--,
            --hcsua1.LOCATION bill_to_location,
            --hcsua2.LOCATION ship_to_location
FROM hz_parties hp,
            hz_party_sites hps,
            hz_cust_accounts hca,
            hz_cust_acct_sites_all hcasa1,
            hz_cust_site_uses_all hcsua1,
            hz_locations hl,
            fnd_territories_tl ftt,
            hz_cust_acct_sites_all hcasa2,
            hz_cust_site_uses_all hcsua2
WHERE hp.party_id = hps.party_id(+)
AND hp.party_id = hca.party_id(+)
AND hcasa1.party_site_id(+) = hps.party_site_id
AND hcasa2.party_site_id(+) = hps.party_site_id
AND hcsua1.cust_acct_site_id(+) = hcasa1.cust_acct_site_id
AND hcsua2.cust_acct_site_id(+) = hcasa2.cust_acct_site_id
AND hcsua1.site_use_code(+) = 'bill_to'
AND hcsua2.site_use_code(+) = 'ship_to'
AND hcasa1.org_id(+) = fnd_profile.VALUE ('org_id')
AND hcasa2.org_id(+) = fnd_profile.VALUE ('org_id')
AND hps.location_id = hl.location_id
AND hl.country = ftt.territory_code
--AND ftt.LANGUAGE = USERENV ('lang')
AND hcsua1.site_use_code(+) = 'bill_to'
AND hcsua2.site_use_code(+) = 'ship_to' 
AND hcasa1.org_id(+) = fnd_profile.VALUE ('org_id')
AND hcasa2.org_id(+) = fnd_profile.VALUE ('org_id')
AND ftt.territory_short_name = 'Mexico'
AND length(hl.state) > 2
AND hca.account_number IS NOT NULL
ORDER BY customer_number;

/*
59847071
MX51081360
*/


SELECT *
FROM hz_locations hl;



SELECT LENGTH('Blvd. Río Sonora Nte. No. 188 esq. Con Blvd. Solidaridad. Col. Proyecto Río Sonora') FROM DUAL;

SELECT LENGTH('Blvd Río Sonora Nte 188 esq Blvd Solidaridad Col Proyecto Río Sonora') FROM DUAL;


SELECT LENGTH('PERIFÉRICO LUIS ECHEVERRÍA NO. 6385 ENTRE 26 DE MARZO Y PROLONG. PÉREZ TREVIÑO') from dual;


SELECT LENGTH('PERIFÉRICO LUIS ECHEVERRÍA 6385, 26 DE MARZO Y PROLONG PÉREZ TREVIÑO') from dual;

SELECT LENGTH('PERIFÉRICO LUIS ECHEVERRÍA 6385, 26 DE MARZO Y PROLONG PÉREZ TREVIÑO') FROM DUAL;


SELECT * FROM OE_ORDER_HEADERS_V;

-------Final--------------
SELECT ooha.order_number, 
ooha.cust_po_number, 
hp.PARTY_NAME Customer,
hca.account_number Customer_number, 
ooha.request_date,
hou.location_id AS SHIP_FROM,
hps.party_site_number as SITE_NUMBER,
hcsua.location AS SHIP_TO_LOCATION,
hl.address1 AS SHIP_TO_ADDRESS1, 
hl.address2 AS SHIP_TO_ADDRESS2,
hl.state,
LENGTH(hl.address1) AS LENGTH_ADDRESS1,
LENGTH(hl.state) AS LENGTH_STATE,
hcsua.site_use_code
FROM OE_ORDER_HEADERS_ALL ooha INNER JOIN
hr_all_organization_units hou ON ooha.SHIP_FROM_ORG_ID = hou.organization_id INNER JOIN
hz_cust_site_uses_all hcsua ON ooha.ship_to_org_id = hcsua.site_use_id --AND hcsua.site_use_code = 'SHIP_TO' 
INNER JOIN
hz_cust_acct_sites_all hcasa ON hcsua.cust_acct_site_id= hcasa.cust_acct_site_id AND hcsua.cust_acct_site_id = hcasa.cust_acct_site_id INNER JOIN
hz_party_sites hps ON hcasa.party_site_id = hps.party_site_id INNER JOIN
hz_parties hp ON hp.party_id = hps.party_id INNER JOIN
hz_locations hl ON hps.location_id = hl.location_id INNER JOIN 
hz_cust_accounts hca ON hca.party_id = hp.party_id 
--WHERE TO_CHAR(ooha.request_date, 'DD/MM/YYYY') = '15/09/2025'
WHERE ooha.request_date >= sysdate-1
AND hou.organization_id = 2024
AND (LENGTH(hl.address1) > 50 OR LENGTH(hl.state) > 2)
GROUP BY ooha.order_number, 
ooha.cust_po_number, 
hp.PARTY_NAME,
hca.account_number, 
ooha.request_date,
hou.location_id,
hps.party_site_number,
hcsua.location,
hl.address1, 
hl.address2,
hl.state,
hcsua.site_use_code
ORDER BY ooha.request_date, ooha.order_number;

select * from hr_all_organization_units
where name like '%Monte%';

select * from hz_locations;
--where name like '%Monte%';


SELECT
ooha.order_number, 
ooha.cust_po_number, 
hp.PARTY_NAME Customer,
hca.account_number Customer_number, 
hou.location_code AS SHIP_FROM,
hps.party_site_number as SITE_NUMBER,
hcsua.location AS SHIP_TO_LOCATION,
hl.address1 AS SHIP_TO_ADDRESS1, 
hl.address2 AS SHIP_TO_ADDRESS2
FROM oe_order_headers_all ooha
--,oe_order_lines_all oola
,hz_cust_site_uses_all hcsua
,hz_cust_acct_sites_all hcasa
,hz_parties hp
,hz_cust_accounts hca
,hz_party_sites hps
,hz_locations hl
,hr_organization_units_v hou
WHERE 1=1
AND hcsua.cust_acct_site_id = hcasa.cust_acct_site_id
AND ooha.ship_to_org_id = hcsua.site_use_id(+)

AND hcsua.cust_acct_site_id= hcasa.cust_acct_site_id(+)

AND ooha.sold_to_org_id = hca.cust_account_id(+)
AND hca.party_id = hp.party_id(+)
AND hcasa.party_site_id = hps.party_site_id(+)
AND hps.location_id = hl.location_id(+)
AND ooha.SHIP_FROM_ORG_ID = hou.organization_id
--AND ooha.cust_po_number in ()
AND TO_CHAR(ooha.REQUEST_DATE, 'DD/MM/YYYY') = '15/09/2025'
;