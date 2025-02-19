echo $1 $2 $3

if [[ -z $1 && -z $2 && -z $3 ]] ; then
  echo hi
else
  echo bye
fi
