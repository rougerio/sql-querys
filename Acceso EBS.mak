Acceso EBS

DBLINK de PROD:
OTMRO.NIAGARAWATER.COM

Datos de conexión:

PROD
CONNECTION NAME: EBS PROD
USERNAME: apps_ro
PASSWORD: ebsInquiryUser72
HOSTNAME: ebsp1pd1.niagarawater.com
PORT: 1521
SERVICE NAME: PROD

UAT
CONNECTION NAME: EBS UAT
USERNAME: apps_ro
PASSWORD: ebsInquiryUser72
HOSTNAME: ebst1pd1.niagarawater.com
PORT: 1521
SERVICE NAME: UAT

DEV
CONNECTION NAME: EBS DEV
USERNAME: apps_ro
PASSWORD: ebsInquiryUser72
HOSTNAME: ebsd1pd1.niagarawater.com
PORT: 1521
SERVICE NAME: DEV

Datos del TNS:

NW_DEV =

  (DESCRIPTION =

    (ADDRESS_LIST =

      (ADDRESS = (PROTOCOL = TCP)(HOST = ebsd1pd1.niagarawater.com)(PORT = 1521))

    )

    (CONNECT_DATA =

      (SERVICE_NAME = DEV)

    )

  )

 

NW_UAT =

  (DESCRIPTION =

    (ADDRESS_LIST =

      (ADDRESS = (PROTOCOL = TCP)(HOST = ebst1pd1.niagarawater.com)(PORT = 1521))

    )

    (CONNECT_DATA =

      (SERVICE_NAME = UAT)

    )

  )

 

NW_PROD =

  (DESCRIPTION =

    (ADDRESS_LIST =

      (ADDRESS = (PROTOCOL = TCP)(HOST = ebsp1pd1.niagarawater.com)(PORT = 1521))

    )

    (CONNECT_DATA =

      (SERVICE_NAME = PROD)

    )

  )