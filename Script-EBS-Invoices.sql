--Pegaso - AP
 
 
select * from XXNBL_AP_HDR_PEGASO_STG
where creation_date > sysdate-6
and invoice_num in 
(
'1020525',
'12225'
);
 
--Staging Table hacia OTM
 
select *
from xxnig_invoice_headers
where creation_date > sysdate-6
and invoice_number in 
(
'1020525',
'12225'
)
;