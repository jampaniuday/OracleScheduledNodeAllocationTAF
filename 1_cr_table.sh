# This script creates the user karlarao and the table iosaturationtoolkit.
sqlplus /nolog<<EOF
connect / as sysdba
--drop user karlarao cascade;

create bigfile tablespace ts_iosaturationtoolkit;

create user karlarao identified by karlarao;
grant dba to karlarao;
alter user karlarao default tablespace ts_iosaturationtoolkit;
alter user karlarao temporary tablespace temp;

connect karlarao/karlarao
create table iosaturationtoolkit tablespace ts_iosaturationtoolkit parallel nologging as select * from sys.dba_objects where rownum <= 10000;
commit;
exit
EOF


