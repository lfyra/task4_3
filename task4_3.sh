#!bin/bash

#verify the quantity of arguments

if [[ $# -ne 2 ]]
then
echo "error: There must be exactly 2 arguments"; exit 1;
fi

#verify directory
if ! [[ -d $1 ]] 
then 
echo "error:Not path" >&2; exit 2;
fi



#verify number of backup

verify='^[0-9]+$'
if ! [[ $2 =~ $verify ]] ; then
echo "error: Not a number" >&2; exit 3;
fi


if ! [ -d /tmp/backups/ ]; then
mkdir /tmp/backups
fi

name="${1:1}"
chname="${name//'/'/-}"
chname="${chname//' '/_}"
nd=$(date +"%Y:%m:%H:%M:%S:%N")
q=$(( $2 + 1 ))

tar -czvf /tmp/backups/$chname${nd}.tar.gz  $1 2> /dev/null
cd /tmp/backups
ls -t /tmp/backups | grep ${chname} | tail -n +${q} | xargs rm 2> /dev/null

