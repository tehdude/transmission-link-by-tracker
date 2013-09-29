#!/bin/sh
#replace the values with yours

REMOTE="transmission-remote localhost"
TRACKER="trackername"
DESTDIR="/desiredpath/$TRACKER"
IDLIST="$($REMOTE -l | tail -n +2 | grep 100% | grep -v Stopped | awk '{ print $1; }')"

for ID in $IDLIST; do
  TRACK="$($REMOTE --torrent $ID -it | grep $TRACKER)"
  if [ $? -eq 0 ]; then
    LOCATION="$($REMOTE --torrent $ID -i | grep "Location" | cut -d' ' -f4)"
    FILEN="$($REMOTE --torrent $ID -if | head -n 1 | cut -d'(' -f1)"
    LEN=${#FILEN}
    let LEN--
    echo $LEN
    FILEN="$(echo $FILEN | cut -c1-$LEN)"
    ln -s "$LOCATION$FILEN" "$DESTDIR/$FILEN"
  fi
done

