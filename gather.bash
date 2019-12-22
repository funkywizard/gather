echo -e "\nGathering server status in a loop.\nCtrl-C or kill process to exit.\n"

while : ; do

echo -e "Start of gather iteration: `date`\n"

echo -e "\n== Iteration Start ==\n" >> out.gather
date >> out.gather

echo -e "Gathering top...\n"

echo -e "\n-- top: --" >> out.gather
top -n 1 >> out.gather

echo -e "Gathering mysql status...\n" 

echo -e "\n-- mysql: --" >> out.gather
mysql -e 'show full processlist;' >> out.gather

echo -e "Gathering iostat...\n"

echo -e "\n-- iostat: --" >> out.gather
iostat -mxty 5 1 >> out.gather

echo -e "Gathering apache...\n"

echo -e "\n-- apache: --" >> out.gather

rm server-status -I
wget https://127.0.0.1/server-status --no-check-certificate -q
head -n 58 server-status >> out.gather
echo -e "\nFirst 50 slots:\n" >> out.gather
cat server-status | grep "http/1.1" | head -n 50 >> out.gather
echo -e "\n== Iteration End ==\n" >> out.gather

echo -e "Done with gather iteration.\nSleeping for 15 seconds.\n"

sleep 15

done
