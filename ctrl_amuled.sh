#! /bin/bash

SERVICE='/usr/bin/amuled'

#Inserisci qui il valore ti tempo (in secondi) che andrà a determinare
#ogni quanto tempo deve avvenire il controllo...
control="300"

#Inserisci qui l'intervallo dopo il quale dovrà essere riavviato
#amule una volta ucciso il processo
reload="30"

function loop {
  echo $(date) >> ./log/ctrl_amuled.log
  echo " " >> ./log/ctrl_amuled.log

  if ps ax | grep -v grep | grep $SERVICE > /dev/null
  then
    echo "Amuled è in funzione" >> ./log/ctrl_amuled.log
    sleep $control
    loop
  else
    echo "Amuled non è in funzione" >> ./log/ctrl_amuled.log
    killall amuleweb
    sleep $reload
    service amule-daemon start
    sleep $control
    loop
  fi

}

loop

