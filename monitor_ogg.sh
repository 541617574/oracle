#*/5 * * * * /home/oracle/monitor/zabbix.sh

#!/bin/bash
#for ogg monitor
. /home/oracle/.bash_profile
echo info all|/ogg/ggsci |grep -i -e abend -e stop  |wc -l > /tmp/oggstatus.txt

lagtime=(`echo info all|/ogg/ggsci |sed -n '13,$p' |awk '{print $4,$5}'`)
timecalc=0
timemax=0
length=${#lagtime[*]}
#echo $length

for((no=0;no<$length;no++))
do
timecalc=`echo ${lagtime[$no]} |sed 's/://g'`
#echo $timecalc
#echo $no
if [ $timecalc -gt $timemax ];then
timemax=$timecalc
continue
fi
done

#echo $timemax
echo $timemax > /tmp/ogglagtime.txt
