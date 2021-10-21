# !/bin/bash

#determine the /sys/ directory of the battery
BATDIR=`ls /sys/class/power_supply/ | grep BAT | cat`
echo $BATDIR

#for some un godly reason the current charge value name is different for some laptop brands, WHY WHY THE AJKDNAWKJDNKJAWDN
CHRG_NOW=`ls /sys/class/power_supply/$BATDIR | grep 'energy\|charge' | sed -n 3,1p`
CHRG_FULL=`ls /sys/class/power_supply/$BATDIR | grep 'energy\|charge' | sed -n 1,1p`

echo $CHRG_NOW
echo $CHRG_FULL

#get the current battery charge and compare it with old one
while :
	do
	#get last battery reading
	BAT_LAST=`cat /sys/class/power_supply/$BATDIR/$CHRG_NOW`

	sleep 5

	#get current battery reading
	BAT_CURRENT=`cat /sys/class/power_supply/$BATDIR/$CHRG_NOW`

	#print the last and current measurements (for debugging)
	echo $BAT_LAST
	echo $BAT_CURRENT

	#subtract BAT_LAST from BAT_CURRENT to get the battery usage
	#$BAT_LAST - 
done
