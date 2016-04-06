#!/bin/sh

PATH=/usr/local/bin:$PATH
export PATH

ORACLE_SID=$1
ORAENV_ASK=NO

. /usr/local/bin/oraenv

export ORACLE_SID
export ORACLE_HOME

PATH=$ORACLE_HOME/bin:$PATH
export PATH

/u01/app/oracle/product/11.2.0.3/dbhome_1/bin/srvctl modify service -d oltp -s oltp_srvc -n -i oltp1,oltp2
/u01/app/oracle/product/11.2.0.3/dbhome_1/bin/srvctl start service -d oltp -s oltp_srvc

