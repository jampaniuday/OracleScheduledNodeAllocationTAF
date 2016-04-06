
# OracleScheduledNodeAllocationTAF
- Karl Arao, OakTable, Oracle ACE, OCP-DBA, RHCE
- http://karlarao.wordpress.com

# The general workflow

#### Prepare environment
* execute 1_cr_table.sh, 2_datagrow.sh to create the table/tablespace
* execute 3_fts.sh one time to avoid delayed block cleanout

#### Execute test case
* adjust the homes and instance names accordingly
* implement the crontab entry for expand and reduce
* execute mon_services.sh and mon_session.sh on separate windows
* execute the workload driver run_oltp.sh and run_dw.sh

# Results

#### 2 nodes (Expand scenario)
```
Preferred instances: oltp1,oltp2
Available instances:

	   INST_ID   COUNT(*) TXT                            USERNAME                       SQL_ID        FAILOVER_TYPE FAILOVER_M FAI
	---------- ---------- ------------------------------ ------------------------------ ------------- ------------- ---------- ---
	         1          5 SELECT /*+ cputoolkit ordered  KARLARAO                       9fx889bgz15h3 SELECT        BASIC      NO
	         1        192 select count(*) from iosaturat KARLARAO                       csbsw569ddtxd NONE          NONE       NO
	         1          1 select count(*) from iosaturat KARLARAO                       csbsw569ddtxd SELECT        BASIC      NO
	         2          5 SELECT /*+ cputoolkit ordered  KARLARAO                       9fx889bgz15h3 SELECT        BASIC      NO
	         2        192 select count(*) from iosaturat KARLARAO                       csbsw569ddtxd NONE          NONE       NO
	         2          3 select count(*) from iosaturat KARLARAO                       csbsw569ddtxd SELECT        BASIC      NO
```


#### 1 node (Shrink scenario)
```
Preferred instances: oltp1
Available instances: oltp2

	start of switch to Preferred node
	   INST_ID   COUNT(*) TXT                            USERNAME                       SQL_ID        FAILOVER_TYPE FAILOVER_M FAI
	---------- ---------- ------------------------------ ------------------------------ ------------- ------------- ---------- ---
	         1         13 SELECT /*+ cputoolkit ordered  KARLARAO                       9fx889bgz15h3 SELECT        BASIC      NO
	         1        199 select count(*) from iosaturat KARLARAO                       csbsw569ddtxd NONE          NONE       NO
	         1          6 select count(*) from iosaturat KARLARAO                       csbsw569ddtxd SELECT        BASIC      NO
	         2         28 select count(*) from iosaturat KARLARAO                       csbsw569ddtxd NONE          NONE       NO
	         2          1 select count(*) from iosaturat KARLARAO                       csbsw569ddtxd SELECT        BASIC      NO

	end of switch to Preferred node
	   INST_ID   COUNT(*) TXT                            USERNAME                       SQL_ID        FAILOVER_TYPE FAILOVER_M FAI
	---------- ---------- ------------------------------ ------------------------------ ------------- ------------- ---------- ---
	         1         13 SELECT /*+ cputoolkit ordered  KARLARAO                       9fx889bgz15h3 SELECT        BASIC      NO
	         1        216 select count(*) from iosaturat KARLARAO                       csbsw569ddtxd NONE          NONE       NO
	         1          7 select count(*) from iosaturat KARLARAO                       csbsw569ddtxd SELECT        BASIC      NO
```

#### Two nodes then kill -9 on node2 (sudden shutdown scenario)
```
running on 2 nodes
   INST_ID   COUNT(*) TXT                            USERNAME                       SQL_ID        FAILOVER_TYPE FAILOVER_M FAI
---------- ---------- ------------------------------ ------------------------------ ------------- ------------- ---------- ---
         1          2 SELECT /*+ cputoolkit ordered  KARLARAO                       9fx889bgz15h3 SELECT        BASIC      NO
         1        253 select count(*) from iosaturat KARLARAO                       csbsw569ddtxd NONE          NONE       NO
         1          5 select count(*) from iosaturat KARLARAO                       csbsw569ddtxd SELECT        BASIC      NO
         2         10 SELECT /*+ cputoolkit ordered  KARLARAO                       9fx889bgz15h3 SELECT        BASIC      NO
         2        224 select count(*) from iosaturat KARLARAO                       csbsw569ddtxd NONE          NONE       NO
         2          4 select count(*) from iosaturat KARLARAO                       csbsw569ddtxd SELECT        BASIC      NO

after kill -9 on node2
   INST_ID   COUNT(*) TXT                            USERNAME                       SQL_ID        FAILOVER_TYPE FAILOVER_M FAI
---------- ---------- ------------------------------ ------------------------------ ------------- ------------- ---------- ---
         1          3 SELECT /*+ cputoolkit ordered  KARLARAO                       9fx889bgz15h3 SELECT        BASIC      NO
         1        415 select count(*) from iosaturat KARLARAO                       csbsw569ddtxd NONE          NONE       NO
         1          2 select count(*) from iosaturat KARLARAO                       csbsw569ddtxd SELECT        BASIC      NO
         1          4 select count(*) from iosaturat KARLARAO                       csbsw569ddtxd SELECT        BASIC      YES

after node2 restarts and everything gets rebalanced again
   INST_ID   COUNT(*) TXT                            USERNAME                       SQL_ID        FAILOVER_TYPE FAILOVER_M FAI
---------- ---------- ------------------------------ ------------------------------ ------------- ------------- ---------- ---
         1         11 SELECT /*+ cputoolkit ordered  KARLARAO                       9fx889bgz15h3 SELECT        BASIC      NO
         1         80 select count(*) from iosaturat KARLARAO                       csbsw569ddtxd NONE          NONE       NO
         1          2 select count(*) from iosaturat KARLARAO                       csbsw569ddtxd SELECT        BASIC      NO
         2          1 SELECT /*+ cputoolkit ordered  KARLARAO                       9fx889bgz15h3 SELECT        BASIC      NO
         2         64 select count(*) from iosaturat KARLARAO                       csbsw569ddtxd NONE          NONE       NO
         2          1 select count(*) from iosaturat KARLARAO                       csbsw569ddtxd SELECT        BASIC      NO
```
