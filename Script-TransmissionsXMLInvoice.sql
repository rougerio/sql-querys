ALTER SESSION SET NLS_DATE_FORMAT = 'dd/mm/yyyy hh24:mi:ss';

SELECT ITRAC.*, EXTRACTVALUE(XMLTYPE(REPLACE(REPLACE(ITRAC.XML_BLOB, 'otm:', ''), ' xmlns:otm="http://xmlns.oracle.com/apps/otm/transmission/v6.4"','')),
		'/Invoice/Payment/PaymentHeader/InvoiceNum') InvoiceNum
FROM I_TRANSMISSION ITMS INNER JOIN
I_TRANSACTION ITRAC ON ITMS.I_TRANSMISSION_NO = ITRAC.I_TRANSMISSION_NO
WHERE ITMS.I_TRANSMISSION_NO IN ('226189948','226189950','226335858','226389074')
AND TRANSACTION_CODE = 'I';


SELECT I_TRANSMISSION_NO, I_TRANSACTION_NO, InvoiceNum, XML_BLOB, I.INVOICE_GID, I.INVOICE_NUMBER  
FROM (
        SELECT ITRAC.*, EXTRACTVALUE(XMLTYPE(REPLACE(REPLACE(ITRAC.XML_BLOB, 'otm:', ''), ' xmlns:otm="http://xmlns.oracle.com/apps/otm/transmission/v6.4"','')), '/Invoice/Payment/PaymentHeader/InvoiceNum') InvoiceNum
        FROM I_TRANSMISSION ITMS INNER JOIN
        I_TRANSACTION ITRAC ON ITMS.I_TRANSMISSION_NO = ITRAC.I_TRANSMISSION_NO
        WHERE ITMS.I_TRANSMISSION_NO IN ('226189948','226189950','226335858','226389074')
        AND TRANSACTION_CODE = 'I'
        AND ELEMENT_NAME = 'Invoice'
        AND OBJECT_GID LIKE 'NBL/MX%'
        --AND TO_CHAR(ITMS.INSERT_DATE, 'YYYY') = '2024'
        --AND TO_CHAR(ITMS.INSERT_DATE, 'MM') = '08'
    ) T INNER JOIN
INVOICE I ON T.InvoiceNum = I.INVOICE_NUMBER
WHERE InvoiceNum IN ('1204','9473','3683','4225','7981','1185684','7980','1185670','7974')
AND I.SERVPROV_GID IN ('NBL.CAR-4703769','NBL.CAR-2354403','NBL.CAR-2679275','NBL.CAR-4703769','NBL.CAR-4751807','NBL.CAR-2198423','NBL.CAR-4751807','NBL.CAR-2198423','NBL.CAR-4751807')
AND TO_CHAR(I.INVOICE_DATE, 'YYYY') = '2024'
AND TO_CHAR(I.INVOICE_DATE, 'MM') = '08'
ORDER BY InvoiceNum DESC;



SELECT I_TRANSMISSION_NO, I_TRANSACTION_NO, InvoiceNum, XML_BLOB
FROM (
        SELECT ITRAC.*, EXTRACTVALUE(XMLTYPE(REPLACE(REPLACE(ITRAC.XML_BLOB, 'otm:', ''), ' xmlns:otm="http://xmlns.oracle.com/apps/otm/transmission/v6.4"','')),
		'/Invoice/Payment/PaymentHeader/InvoiceNum') InvoiceNum
        FROM I_TRANSMISSION ITMS INNER JOIN
        I_TRANSACTION ITRAC ON ITMS.I_TRANSMISSION_NO = ITRAC.I_TRANSMISSION_NO
        WHERE ITMS.I_TRANSMISSION_NO IN ('226189948','226189950','226335858')
        AND TRANSACTION_CODE = 'I'
        AND ELEMENT_NAME = 'Invoice'
    ) T;
    
    
        SELECT ITRAC.*, EXTRACTVALUE(XMLTYPE(REPLACE(REPLACE(ITRAC.XML_BLOB, 'otm:', ''), ' xmlns:otm="http://xmlns.oracle.com/apps/otm/transmission/v6.4"','')),
		'/Invoice/Payment/PaymentHeader/InvoiceNum') InvoiceNum
        FROM I_TRANSMISSION ITMS INNER JOIN
        I_TRANSACTION ITRAC ON ITMS.I_TRANSMISSION_NO = ITRAC.I_TRANSMISSION_NO
        WHERE /*ITMS.I_TRANSMISSION_NO IN ('226189948','226189950','226335858')
        AND*/ TRANSACTION_CODE = 'I'
        AND ELEMENT_NAME = 'Invoice'
        AND OBJECT_GID LIKE 'NBL/MX%'
        AND TO_CHAR(ITMS.INSERT_DATE, 'YYYY') = '2024'
        AND TO_CHAR(ITMS.INSERT_DATE, 'MM') = '08';

SELECT *
FROM INVOICE
WHERE INVOICE_NUMBER = '3683';

SELECT ITRAC.*
FROM I_TRANSMISSION ITMS INNER JOIN
I_TRANSACTION ITRAC ON ITMS.I_TRANSMISSION_NO = ITRAC.I_TRANSMISSION_NO
WHERE OBJECT_GID LIKE '%NBL/MX.20220829-0043%';


SELECT I_TRANSMISSION_NO, I_TRANSACTION_NO, InvoiceNum, XML_BLOB
FROM (
        SELECT ITRAC.*, EXTRACTVALUE(XMLTYPE(REPLACE(REPLACE(ITRAC.XML_BLOB, 'otm:', ''), ' xmlns:otm="http://xmlns.oracle.com/apps/otm"','')), 
        '/AllocationBase/Invoice/Payment/PaymentHeader/InvoiceNum') InvoiceNum
        FROM I_TRANSMISSION ITMS INNER JOIN
        I_TRANSACTION ITRAC ON ITMS.I_TRANSMISSION_NO = ITRAC.I_TRANSMISSION_NO
        WHERE ELEMENT_NAME = 'AllocationBase'
        AND TO_CHAR(ITMS.INSERT_DATE, 'DD/MM/YYYY') >= '01/06/205'
        AND ITMS.DOMAIN_NAME = 'NBL/MX'
    ) T
WHERE InvoiceNum IN ('1204','9473','3683','4225','7981','1185684','7980','1185670','7974');



SELECT I_TRANSMISSION_NO, I_TRANSACTION_NO, InvoiceNum, OBJECT_GID, Description, SpecialChargeCode, XML_BLOB
FROM (
        SELECT ITRAC.I_TRANSACTION_NO, ITRAC.I_TRANSMISSION_NO, ITRAC.XML_BLOB, ITRAC.OBJECT_GID,
               EXTRACTVALUE(XMLTYPE(REPLACE(REPLACE(ITRAC.XML_BLOB, 'otm:', ''), ' xmlns:otm="http://xmlns.oracle.com/apps/otm"','')),
               '/Invoice/Payment/PaymentHeader/InvoiceNum') InvoiceNum
            ,
               EXTRACTVALUE(XMLTYPE(REPLACE(REPLACE(ITRAC.XML_BLOB, 'otm:', ''), ' xmlns:otm="http://xmlns.oracle.com/apps/otm"','')),
               '/Invoice/Payment/PaymentModeDetail/GenericDetail/GenericLineItem[1]/CommonInvoiceLineElements[1]/Commodity/Description') Description
            ,
                EXTRACTVALUE(XMLTYPE(REPLACE(REPLACE(ITRAC.XML_BLOB, 'otm:', ''), ' xmlns:otm="http://xmlns.oracle.com/apps/otm"','')),
               '/Invoice/Payment/PaymentModeDetail/GenericDetail/GenericLineItem[1]/CommonInvoiceLineElements[1]/FreightRate/SpecialCharge/SpecialChargeCode') SpecialChargeCode

        FROM I_TRANSMISSION ITMS INNER JOIN
        I_TRANSACTION ITRAC ON ITMS.I_TRANSMISSION_NO = ITRAC.I_TRANSMISSION_NO
        WHERE ELEMENT_NAME = 'Invoice'
        AND TO_CHAR(ITMS.INSERT_DATE, 'DD/MM/YYYY') >= '01/08/2024'
        AND OBJECT_GID LIKE 'NBL/MX%'
    ) T
WHERE Description = 'A';


/*
/Invoice/Payment/PaymentModeDetail/GenericDetail/GenericLineItem/CommonInvoiceLineElements/Commodity/Description
/Invoice/Payment/PaymentModeDetail/GenericDetail/GenericLineItem/CommonInvoiceLineElements/FreightRate/SpecialCharge/SpecialChargeCode
*/


SELECT I_TRANSMISSION_NO, I_TRANSACTION_NO, InvoiceNum, XML_BLOB
FROM (
        SELECT ITRAC.*, EXTRACTVALUE(XMLTYPE(REPLACE(REPLACE(ITRAC.XML_BLOB, 'otm:', ''), ' xmlns:otm="http://xmlns.oracle.com/apps/otm"','')), '/AllocationBase/Invoice/Payment/PaymentHeader/InvoiceNum') InvoiceNum
        /*,
        EXTRACTVALUE(XMLTYPE(REPLACE(REPLACE(ITRAC.XML_BLOB, 'otm:', ''), ' xmlns:otm="http://xmlns.oracle.com/apps/otm"','')), 
        '/AllocationBase/Invoice/Payment/PaymentHeader/InvoiceNum') VoucherGID*/
        FROM I_TRANSMISSION ITMS INNER JOIN
        I_TRANSACTION ITRAC ON ITMS.I_TRANSMISSION_NO = ITRAC.I_TRANSMISSION_NO
        WHERE ELEMENT_NAME = 'AllocationBase'
        AND TO_CHAR(ITMS.INSERT_DATE, 'DD/MM/YYYY') >= '20/05/2025'
        AND ITMS.DOMAIN_NAME = 'NBL/MX'
    ) T
WHERE InvoiceNum IN ('1204','9473','3683','4225','7981','1185684','7980','1185670','7974');
