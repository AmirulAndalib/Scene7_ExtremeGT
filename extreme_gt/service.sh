#!/bin/sh
# SCENE7'ExtremeGT 3.0

t=29500
bat_t=29500
for tz in /sys/class/thermal/*
do
  if [[ -f $tz/temp ]]; then
    case $(cat $tz/type) in
      # pm8550_gpio03_usr|pm8550vs_g_tz|pm8550b_tz|pm8550vs_c_tz|pa-therm2-sys3)
      #   echo $tz/temp $(cat $tz/temp) '> 25000'
      #   echo 31000 > $tz/emul_temp
      # ;;
      # rear-tof-therm
      rear-tof-therm|cam-flash-therm)
        # echo $(cat $tz/type) $(cat $tz/temp)
        echo $t > $tz/emul_temp
      ;;
      batt-therm|usb-therm)
        echo $bat_t > $tz/emul_temp
      ;;
      wlan-therm|xo-therm|oplus_thermal_ipa)
        echo $t > $tz/emul_temp
      ;;
      shell*)
        echo $t > $tz/emul_temp
      ;;
    esac
  fi
done
stop horae

gu=/proc/oplus-votable/GAUGE_UPDATE
if [[ -d $gu ]]; then
 chmod 666 $gu/force_val
 echo '2000' > $gu/force_val
 chmod 666 $gu/force_active
 echo '1' > $gu/force_active
fi
