# This is the main script 
export DATE=$(date +%Y%m%d%H%M%S%N)

sqlplus -s /NOLOG <<! &
connect / as sysdba

col txt format a30
select inst_id, count(*),txt, username, sql_id, failover_type, failover_method, failed_over
 from (
select  
	s.inst_id, 
	s.username, 
	s.sql_id, 		
	substr(sa.sql_text,1,30) txt,
	s.failover_type, 
	s.failover_method, 
	s.failed_over
from gv\$session s, gv\$sqlarea sa
where 
s.username is not null
and   s.sql_address=sa.address(+)
and   s.sql_hash_value=sa.hash_value(+)
and   sa.sql_text NOT LIKE '%usercheck%'
and  s.username NOT IN ('SYS')
)
group by inst_id, username, sql_id, txt, failover_type, failover_method, failed_over
order by 1 asc
/

exit;
!
