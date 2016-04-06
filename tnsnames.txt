oltp_srvc =
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = enkx3-scan)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = oltp_srvc.NULL)
      (FAILOVER_MODE=(TYPE=SELECT)(METHOD=BASIC))
    )
  )
