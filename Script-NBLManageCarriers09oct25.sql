--ShipMethod extraction for ERPCloud
Select c.carrier_name, --c.active, c.manifesting_enabled_flag,   
       s.service_level, s.mode_of_transport, c.currency_code, c.freight_code Short_Name, c.scac_code, c.carrier_id --s.enabled_flag, s.ship_method_meaning, s.ship_method_code 
  from wsh_carriers_v c, wsh_carrier_services_v s
 where c.carrier_id = s.carrier_id 
   and c.active = 'A'
   and (s.enabled_flag = 'Y' or s.web_enabled = 'Y')
   and c.currency_code = 'MXN'
  /* and c.freight_code IN 
(
'ALLIA',
'EDGEL',
'FFLLC',
'JPLO',
'JBHUNT',
'NLOGI',
'UBERF',
'KAGLI',
'TRAEN',
'CPICKUP'
) */
and s.service_level IN
(
'2DA',
'DF_NBL-SERVICE',
'INTERNATIONAL',
'LTL',
'MEXICO_TEST_RATE_SERVICE',
'NBL-SERVICE',
'NBL_DSD_SERVICE',
'NBL_DTS_SERVICE',
'NBL_MXN_SERVICE',
'NBL_HERE_SERVICE',
'NBL_SPOT_SERVICE',
'NBL_TEAM_SERVICE',
'RATE_SERVICE_10HRS',
'RATE_SERVICE_11HRS',
'RATE_SERVICE_12HRS',
'RATE_SERVICE_13HRS',
'RATE_SERVICE_14HRS',
'RATE_SERVICE_15DAYS',
'RATE_SERVICE_15HRS',
'RATE_SERVICE_16HRS',
'RATE_SERVICE_17HRS',
'RATE_SERVICE_18HRS',
'RATE_SERVICE_1HRS',
'RATE_SERVICE_2.5HRS',
'RATE_SERVICE_20HRS',
'RATE_SERVICE_21HRS',
'RATE_SERVICE_22HRS',
'RATE_SERVICE_23HRS',
'RATE_SERVICE_24HRS',
'RATE_SERVICE_26HRS',
'RATE_SERVICE_28HRS',
'RATE_SERVICE_2HRS',
'RATE_SERVICE_30HRS',
'RATE_SERVICE_32HRS',
'RATE_SERVICE_34HRS',
'RATE_SERVICE_35HRS',
'RATE_SERVICE_36HRS',
'RATE_SERVICE_38HRS',
'RATE_SERVICE_3HRS',
'RATE_SERVICE_40HRS',
'RATE_SERVICE_42HRS',
'RATE_SERVICE_48HRS',
'RATE_SERVICE_4HRS',
'RATE_SERVICE_52HRS',
'RATE_SERVICE_54HRS',
'RATE_SERVICE_5HRS',
'RATE_SERVICE_60HRS',
'RATE_SERVICE_6HRS',
'RATE_SERVICE_72HRS',
'RATE_SERVICE_7HRS',
'RATE_SERVICE_84HRS',
'RATE_SERVICE_8HRS',
'RATE_SERVICE_96HRS',
'RATE_SERVICE_9HRS'
)
order by 1,2,3;