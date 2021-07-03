#!/bin/bash

        function start() {
email=$(cat /home/email)
if [[ "$email" = "" ]]; then
echo "Please enter your email"
read -rp "Email: " -e email
cat <<EOF>>/home/email
$email
EOF
fi
cat << EOF >> /etc/crontab
# BEGIN_Backup
5 0 * * * root bckp
# END_Backup
EOF
service cron restart
sleep 1
echo " Please Wait"
clear
echo " Autobackup Has Been Started"
echo " Data Will Be Backed Up Automatically at 00:05 GMT +7"
exit 0
}
       function stop() {
email=$(cat /home/email)
sed -i "/^$email/d" /home/email
sed -i "/^# BEGIN_Backup/,/^# END_Backup/d" /etc/crontab
service cron restart
sleep 1
echo " Please Wait"
clear
echo " Autobackup Has Been Stopped"
exit 0
}
clear
echo -e " =============================="
echo -e "         Autobackup Data       "
echo -e " =============================="
echo -e " Status $sts"
echo -e "  1. Start Autobackup"
echo -e "  2. Stop Autobackup"
echo -e " Press CTRL+C to return"
read -rp " Please Enter The Correct Number : " -e num
if [[ "$num" = "1" ]]; then
start
elif [[ "$num" = "2" ]]; then
stop
else
clear
echo " You Entered The Wrong Number"
menu
fi
