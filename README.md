
# cellmetricstoolkit
- Karl Arao, Oracle ACE (bit.ly/karlarao), OCP-DBA, RHCE
- http://karlarao.wordpress.com
---

# The general workflow

#### Prepare environment
* execute 1_cr_table.sh, 2_datagrow.sh to create the table/tablespace
* execute 3_fts.sh one time to avoid delayed block cleanout

#### Execute test case
* adjust the homes and instance names accordingly
* implement the crontab entry for expand and reduce
* execute mon_services.sh and mon_session.sh on separate windows
* execute the workload driver run_oltp.sh and run_dw.sh
