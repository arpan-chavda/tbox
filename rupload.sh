#uploading to google drive via grive(nodejs app)
#for f in 
#do
#echo '$f'
#grive upload "$f"
#done
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")



for f in $(find /home/action/upload -name '*.*'); 
do
   grive upload "$f"
done
IFS=$SAVEIFS


#SAVEIFS=$IFS
#IFS=$(echo -en "\n\b")
#for f in $(find /home/action/upload -name '*.*'); 
#do
#  grive upload "$f"
#done
#IFS=$SAVEIFS