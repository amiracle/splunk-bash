
# System-wide .bashrc file for interactive bash(1) shells.
if [ -z "$PS1" ]; then
   return
fi


##Splunk Commands
export BASE_DIR=/opt/splunk
export SPLUNK_HOME=/opt/splunk
export SPLUNK_LIC="~/Downloads"

#Stop, start, restart and upgrade individual instances of local Splunk Demos

startsplunk(){
 export SPLUNK_HOME=/opt/splunk/splunk_$1 | /opt/splunk/splunk_$1/bin/splunk start --accept-license
}

opensplunk(){
open http://localhost:8000
}

stopsplunk(){
 /opt/splunk/splunk_$1/bin/splunk stop
}

restartsplunk(){
 /opt/splunk/splunk_$1/bin/splunk restart
}

upgradesplunk(){
cp -R /opt/upgrade/splunk/* /opt/splunk/splunk_$1
}

splunkspace() {
du -h /opt/splunk/* | awk '$1 ~ "G" { print $1, $2 }'
}

cleansplunk() {
/opt/splunk/splunk_$1/bin/splunk clean eventdata -f
}

createsplunk() {
mkdir -p /opt/splunk/splunk_$1 && cp -R /opt/upgrade/splunk/* /opt/splunk/splunk_$1
}

addlic() {
export SPLUNK_HOME=/opt/splunk/splunk_$1 | /opt/splunk/splunk_$1/bin/splunk add licenses $SPLUNK_LIC/*.lic
}

listapps() {
ls $SPLUNK_HOME/splunk_$1/etc/apps
}

backupsplunk() {
tar czf $SPLUNK_HOME/splunk_$1_archive.tgz -C $SPLUNK_HOME/splunk_$1/etc/apps . -C $SPLUNK_HOME/etc/users | echo Splunk Archive can be found here: $SPLUNK_HOME/splunk_$1_arhive.tgz
}

restoresplunk() {
tar xzvf /opt/splunk/splunk_$1_archive.tgz -C /opt/splunk/splunk_$2/etc/apps
}

rmsplunk(){
rm -Rf $SPLUNK_HOME/splunk_$1 
}

cds(){
cd $SPLUNK_HOME/splunk_$1
}

fixperm(){
sudo chown -R `whoami`:wheel $SPLUNK_HOME/splunk_$1 | sudo chmod -R 755 $SPLUNK_HOME/splunk_$1
}

svm() {

  if [[ $1 == list ]]; then
    if [[ -z $2 || $2 == installed ]]; then
      \ls $BASE_DIR/*/bin/splunk | while read path; do
        printf "%-10s: %-40s\n" \
          "$(echo $path | sed "s|$BASE_DIR/\([^\/]*\)/bin/splunk|\1|")" \
          "$($path version 2>/dev/null | sed "s/Splunk \([^ ]*\) (build \([^)]*\))/splunk-\1-\2/")"
      done

    elif [[ $2 == sourced ]]; then
      basename $SPLUNK_HOME

    elif [[ $2 == space ]]; then
      du -h /opt/splunk/* | awk '$1 ~ "G" { print $1, $2 }'

    elif [[ $2 == running ]]; then
	lsof |grep "/bin/splunk" | awk '{print $9}' | sort -u | awk -F/ '{print $4}'
    elif [[ $2 == latest ]]; then
      curl http://www.splunk.com/page/release_rss 2>/dev/null | grep "<title>" | sed "s/.* (Build \([^)]*\)).*/\1/" | grep -v title | head -1
    fi

  elif [[ -n $1 && -d $BASE_DIR/$1 ]]; then
    stripped_path=$(echo $PATH | sed "s|$BASE_DIR/[^:]*:*||g")
    export SPLUNK_HOME=$BASE_DIR/$1
    export PATH=$SPLUNK_HOME/bin:$stripped_path
    export CDPATH=.:~:$BASE_DIR:$SPLUNK_HOME:$SPLUNK_HOME/etc:$SPLUNK_HOME/etc/apps
  fi
}

active_sids() {
  svm list running | sed -e :a -e '$!N; s/\n/,/; ta'
}

