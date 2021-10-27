# !/bin/bash
BATDIR=`ls /sys/class/power_supply/ | grep BAT | cat`
CHRG_FULL=`ls /sys/class/power_supply/$BATDIR | grep 'energy_full\|charge_full'| sed -n 1,1p`
while :
	do
	CHRG_NOW=`ls /sys/class/power_supply/$BATDIR | grep 'energy_now\|charge_now'`
	BAT_LAST=`cat /sys/class/power_supply/$BATDIR/$CHRG_NOW`
	sleep 5s
	BAT_CURRENT=`cat /sys/class/power_supply/$BATDIR/$CHRG_NOW`
	BAT_DIFF=`expr $BAT_LAST - $BAT_CURRENT`
	BATMAX=`cat /sys/class/power_supply/$BATDIR/$CHRG_FULL`	
	if [  $BAT_DIFF -gt 0 ];
	then
		SEG_REMAINING=`echo $BATMAX '/' $BAT_DIFF | bc`
	else
		SEG_REMAINING=`echo $BAT_DIFF '/' $BATMAX | bc`
	fi
	if [  $SEG_REMAINING -gt 0 ];
	then
		SEC_REMAINING=`echo $SEG_REMAINING '/' 5 | bc`
	else
		SEC_REMAINING=`echo 5 '/' $SEG_REMAINING | bc`
	fi
	if [ "$1" == "-m" ];
	then
		MIN_REMAINING=`echo $SEC_REMAINING '/' 60 | bc`
		echo $MIN_REMAINING
	else
		echo $SEC_REMAINING
	fi
done

