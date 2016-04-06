# purpose: execute multiple SELECT count(*) on 1 database

(( n=0 ))
while (( n<$1 ));do
(( n=n+1 ))
./3_fts.sh &
done


