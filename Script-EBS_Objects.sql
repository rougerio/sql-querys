SELECT * FROM all_objects
where object_name like '%OTM%'
and object_type in ('TABLE', 'VIEW');


SELECT * FROM XXNBL_PEGASO_ERROR_LOG
WHERE creation_date >= to_date('2023/09/06', 'yyyy/mm/dd');

SELECT * FROM XXNBL_AP_PEGASO_PAYMENTS_STG
WHERE creation_date >= to_date('2023/09/07', 'yyyy/mm/dd');

"Error Occured  Binding Error  com.oracle.bpel.client.BPELFault: faultName: {{http://schemas.oracle.com/bpel/extension}bindingFault}
messageType: {{http://schemas.oracle.com/bpel/extension}RuntimeFaultMessage}
parts: {{
summary=<summary>Exception occurred when binding was invoked.
Exception occurred during invocation of JCA binding: "JCA Binding execute of Reference operation 'PegasoAPInvoice_DataLoad' failed due to: Set object error.
Error binding the value of parameter P_INV_DET_TAB.
An error occurred when binding the value of parameter P_INV_DET_TAB in the APPS.XXNBL_AP_PEGASO_INV_INT_PKG.LOAD_DATA API. Cause: java.sql.SQLException: Inserted value too large for column: "Caja, Seg�n la clasi"
Check to ensure that the parameter is a valid IN or IN/OUT parameter of the API.  This exception is considered not retriable, likely due to a modelling mistake.  To classify it as retriable instead add property nonRetriableErrorCodes with value "-17072" to your deployment descriptor (i.e. weblogic-ra.xml).  To auto retry a retriable fault set these composite.xml properties for this invoke: jca.retry.interval, jca.retry.count, and jca.retry.backoff.  All properties are integers.
". 
The invoked JCA adapter raised a resource exception.
Please examine the above error message carefully to determine a resolution.
</summary>
,code=<code>17072</code>
,detail=<detail>Inserted value too large for column: "Caja, Seg�n la clasi"</detail>}
"
