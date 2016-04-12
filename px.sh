while :; do
sqlplus "/ as sysdba" <<! &
spool px.txt append
@px.sql
exit
!
sleep 2
echo
done
