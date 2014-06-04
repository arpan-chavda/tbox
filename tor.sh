cd upload/
#rm -rf *
for i in `cat /home/action/magnet.txt`;
do
     #echo "forever start -l forever.log -o out.log -e err.log /home/action/.parts/lib/node_modules/tget/tget.js $i"
     tget $i 
done
cd ~