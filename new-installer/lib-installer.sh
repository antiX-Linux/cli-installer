#!/bin/bash
#lib-installer
#This is the installer library. The backend for the gui and the cli interface.
#All the main work will be done here.

##### Load Libraries #####
. /usr/local/lib/main/lib-logging.sh
. /usr/local/lib/installer/installer-file-locations.sh


##### Load Configuration Settings #####
load_settings() {
main_config='/etc/installer/options.conf';
test -r $config || continue
if ! /bin/bash -n $config; then
    shout "Errors in $config, cannot load $config."
    shout "desktop-session may crash"
    shout "Copy default config from /usr/local/share/desktop-session/desktop-session.conf"
    continue
fi
. $config


}
