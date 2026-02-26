CREATE DATABASE LINK MA_DB_LINK
CONNECT TO wms_ro_mx IDENTIFIED BY nblRead0nlyMx2026#
USING 'manp1pd1.niagarawater.com:1521/MAPROD.niagarawater.com';

--manp1pd1.niagarawater.com:1521/MAPROD.niagarawater.com

ROLLBACK;

ALTER SESSION CLOSE DATABASE LINK MA_DB_LINK;   

CONN wms_ro_mx@MA_DB_LINK;