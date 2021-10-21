# !/bin/bash

#determine the /sys/ directory of the battery
BATDIR=`ls /sys/class/power_supply/ | grep BAT | cat`
echo $BATDIR

#get the current battery charge and compare it with old one
while :
	do
	#get last battery reading
	BAT_LAST=`cat /sys/class/power_supply/$BATDIR/charge_now`

	sleep 5

	#get current battery reading
	BAT_CURRENT=`cat /sys/class/power_supply/$BATDIR/charge_now`

	#print the last and current measurements (for debugging)
	echo $BAT_LAST
	echo $BAT_CURRENT

	#subtract BAT_LAST from BAT_CURRENT to get the battery usage
	$BAT_LAST - 
done


