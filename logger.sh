n=`date`
for i in /var/log/*.log
do
  lines=`wc -l "$i" | awk '{print $1}'`
  printf "%s|%s|%s\n" "$n" "$i" "$lines" >> /root/counts.log
done
