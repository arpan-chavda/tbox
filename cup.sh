#
# Copyright (c) 2014 Arpan Chavda.
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
# OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
# OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
# SUCH DAMAGE.


#Downloading torrents from magnet.txt
#cd upload/

#for i in `cat /home/action/magnet.txt`;
 # do
  #   tget $i #get this nodejs app via npm install -g tget
 # done

#cd ~

SAVEIFS=$IFS #storing internal field separator 
IFS=$(echo -en "\n\b") #handle space in file names

#compressing downloaded files
cd upload
for f in $(find -maxdepth 1 -type d); 
do
if [[ "$f" != "." ]] ; then
  echo "$f"
  tar -zcvf "$f".tar.gz "$f"
  rm -rf "$f"
fi
done
cd ~
#file splitting if it exceedes from 2GB because google drive wont allow you to export more than 2GB at a single shot

for file in $(find /home/action/upload -name '*' -type f); do 
  size=$(ls -l $file | awk '{print $5}')              #get the size of file
  if [[ $size -gt $((2000*1024*1024)) ]] ; then        #file bigger than 2000M
  
      split -b 2000M -d -a1 $file ${file%.tar.gz}_        #do the spliting, -d: numeric suffix, -a1: use only one digit
      for i in ${file%.tar.gz}_[0-9] ; do                #add .tar.gz suffix:
           mv $i ${i}.tar.gz
      done
      rm $file #remove original file
  fi
  
done
#How to join file splitted like file_0.tar.gz,file_1.tar.gz
#go to terminal an run `cat file* > file.tar.gz`(without `)
#use git bash on windows pc if you dont have cygwin or linux on your pc.
#uploading to google drive
for f in $(find /home/action/upload -name '*.*'); 
do
  grive upload "$f" #get this nodejs app via npm install -g grive
done

#after uploading remove downloaded torrents to free space
rm -rf /home/action/upload/*

#restore internal field separator($ifs)
IFS=$SAVEIFS
