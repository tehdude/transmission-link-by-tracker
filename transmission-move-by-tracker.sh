REMOTE="transmission-remote localhost"
DESTDIR="/mnt/sda1/download/music"
TRACKER="ubuntu\.com"
IDLIST="$($REMOTE -l | tail -n +2 | grep 100% | grep -v Stopped | awk '{ print $1; }')"


for ID in $IDLIST; do
  TRACKER="$($REMOTE --torrent $ID -it | grep $TRACKER)"
  if [ $? -eq 0 ]; then
    MOVED="$($REMOTE --torrent $ID -i | grep $DESTDIR)"
    if [ $? -eq 1 ]; then
      RESULT="$($REMOTE --torrent $ID --move $DESTDIR)"
      echo "Moved $ID"
    fi
  fi
done