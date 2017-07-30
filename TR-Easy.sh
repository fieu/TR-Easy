#!/bin/bash
# Application Name: TR-Easy
# Description: One liner install for the Transmission BitTorrent client as well as the web UI addon and a few helpful functions.
# Author('s): Sheldon Rupp (https://shel.io)
# Last time edited: Mon May 11 21:02:57 CEST 2015

# Copyright (c) 2010, Sheldon Rupp, https://shel.io
# All rights reserved.
# 
# Redistribution and use in source and binary forms, with or without modification, are permitted provided 
# that the following conditions are met:
# 
#     * Redistributions of source code must retain the above copyright notice, this list of conditions 
#       and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the
#       following disclaimer in the documentation and/or other materials provided with the distribution.
#     * Neither the name of Huy Nguyen nor the names of contributors
#       may be used to endorse or promote products derived from this software without 
#       specific prior written permission.
#       
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED 
# WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
# PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR 
# ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
# TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) 
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING 
# NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
# POSSIBILITY OF SUCH DAMAGE.

# Settings

# Username for the Transmission Web Client
USERNAME="admin"
# Password for the Transmission Web Client
PASSWORD="password"
# Either .bashrc or .zshrc : This is where the functions will be stored. DO NOT REMOVE $HOME !!!
RC_FILE="$HOME/.bashrc"

# USAGE: 
# tsm-daemon - Start the daemon
# tsm-quit - Stop the daemon
# tsm-altspeedenable - Enable the alternate speed
# tsm-altspeeddisablee - Disable the alternate speed
# tsm-add "[Torrent URL or Magnet URI]" - Adds torrent to list and starts downloading it. - Example: tsm-add "example.com/furious7.torrent"
# tsm-askmorepeers - Ask the tracker('s) for more peers
# tsm-pause [TorrentName] - Pause a specific torrent or all - Example('s): tsm-pause Furious.7 || tsm-pause all
# tsm-start [TorrentName] - Start a specific torrent or all - Example('s): tsm-start Furious.7 || tsm-start all
# tsm-purge [TorrentName] - Purge data and listing of a specific torrent or all - Example('s): tsm-purge Furious.7 || tsm-purge all
# tsm-remove [TorrentName] - Remove the listing of a specific torrent or all (Doesn't delete the file('s)) - Example('s): tsm-remove Furious.7 || tsm-remove all
# tsm-info [TorrentName] - Info about a specific torrent
# tsm-speed [TorrentName] - Get the speed of a specific torrent
# tsm-watch – Watch the listing of the torrents as well as some important data (DL Speed, UL Speed, Peers, etc.)
# tsm-ncurse – Use the ncurse interface to manage all your torrents.

  # COLORS {{{
    Bold=$(tput bold)
    Underline=$(tput sgr 0 1)
    Reset=$(tput sgr0)
    # Regular Colors
    Red=$(tput setaf 1)
    Green=$(tput setaf 2)
    Yellow=$(tput setaf 3)
    Blue=$(tput setaf 4)
    Purple=$(tput setaf 5)
    Cyan=$(tput setaf 6)
    White=$(tput setaf 7)
    # Bold
    BRed=${Bold}$(tput setaf 1)
    BGreen=${Bold}$(tput setaf 2)
    BYellow=${Bold}$(tput setaf 3)
    BBlue=${Bold}$(tput setaf 4)
    BPurple=${Bold}$(tput setaf 5)
    BCyan=${Bold}$(tput setaf 6)
    BWhite=${Bold}$(tput setaf 7)
  #}}}

sudo apt-get update --fix-missing

sudo apt-get install --fix-missing -y transmission transmission-cli transmission-common transmission-daemon transmission-remote-cli

echo "${White}${Bold}┏━━━━━━━━━━━━━━━━━━━━━━━━┓"
echo "${White}${Bold}┃ ${BGreen}Transmission Installed${Reset} ${White}${Bold}┃"
echo "${White}${Bold}┗━━━━━━━━━━━━━━━━━━━━━━━━┛"

sleep 1.0

printf "function tsm-daemon() { transmission-daemon -t -u $USERNAME -v $PASSWORD -p 9091 -a '*' -c '~/Downloads' ;} \nfunction tsm-quit() { sudo killall -9 transmission-daemon ;} \nfunction tsm-altspeedenable() { transmission-remote --auth admin:password --alt-speed ;} \nfunction tsm-altspeeddisable() {   transmission-remote --auth $USERNAME:$PASSWORD --no-alt-speed ;} \nfunction tsm-add() { transmission-remote --auth $USERNAME:$PASSWORD --add "'$1'" ;} \nfunction tsm-askmorepeers() { transmission-remote -t "'$1'" --reannounce --auth $USERNAME:$PASSWORD ;} \nfunction tsm-pause() { transmission-remote -t "'$1'" --stop --auth $USERNAME:$PASSWORD ;} \nfunction tsm-start() { transmission-remote -t "'$1'" --start --auth $USERNAME:$PASSWORD ;} \nfunction tsm-purge() { transmission-remote -t "'$1'" --remove-and-delete --auth $USERNAME:$PASSWORD ;} \nfunction tsm-remove() { transmission-remote -t "'$1'" --remove --auth $USERNAME:$PASSWORD ;} \nfunction tsm-info() { transmission-remote -t "'$1'" --info --auth $USERNAME:$PASSWORD ;} \nfunction tsm-speed() { while true;do clear; transmission-remote -t active -i --auth $USERNAME:$PASSWORD | grep Speed;sleep 1;done ;} \nfunction tsm-watch() { watch -t -n 1 'transmission-remote --auth $USERNAME:$PASSWORD --list' ;} \nfunction tsm-ncurse() { transmission-remote-cli --connect=$ADMIN:$PASSWORD@localhost:9091 ;}" > trs-functions-temp
# function tsm-daemon() { transmission-daemon -t -u admin -v password -p 9091 -a '*' -c "~/Downloads" ;}
# function tsm-quit() { sudo killall -9 transmission-daemon ;}
# function tsm-altspeedenable() { transmission-remote --auth admin:password --alt-speed ;}
# function tsm-altspeeddisable() {	transmission-remote --auth admin:password --no-alt-speed ;}
# function tsm-add() { transmission-remote --auth admin:password --add "$1" ;}
# function tsm-askmorepeers() { transmission-remote -t "$1" --reannounce --auth admin:password ;}
# function tsm-pause() { transmission-remote -t "$1" --stop --auth admin:password ;}
# function tsm-start() { transmission-remote -t "$1" --start --auth admin:password ;}
# function tsm-purge() { transmission-remote -t "$1" --remove-and-delete --auth admin:password ;}
# function tsm-remove() { transmission-remote -t "$1" --remove --auth admin:password ;}
# function tsm-info() { transmission-remote -t "$1" --info --auth admin:password ;}
# function tsm-speed() { while true;do clear; transmission-remote -t "$1" -i --auth admin:password | grep Speed;sleep 1;done ;}
# function tsm-watch() { watch -t -n 1 "transmission-remote --auth admin:password --list" ;}
# function tsm-ncurse() { transmission-remote-cli --connect=admin:password@$1:9091 ;}

echo "$(cat trs-functions-temp)" >> "${RC_FILE}"

rm -Rf trs-functions-temp

echo "${White}${Bold}┏━━━━━━━━━━━━━━━━━━━┓"
echo "${White}${Bold}┃${BGreen}Functions Installed${Reset}${White}${Bold}┃"
echo "${White}${Bold}┗━━━━━━━━━━━━━━━━━━━┛"

sleep 0.2
echo "${BYellow}Grabbing IP...${Reset}"

IP="$(curl -s https://shel.io)"

sleep 0.5

source "${RC_FILE}"

echo "${White}${Bold}┏━━━━━━━━━━━━━━━━━━━━━━━┓"
echo "${White}${Bold}┃ ${BGreen}Everything Installed!${Reset}${White}${Bold} ┃"
echo "${White}${Bold}┗━━━━━━━━━━━━━━━━━━━━━━━┛"
echo "${Reset}"
echo "${Reset}${BRed}BEFORE YOU DO ANYTHING, RUN: ${Reset}${BPurple}source ${RC_FILE}"
echo "${Reset}"
echo "${White}${Bold}Things to note:"
echo "${White}${Bold}WebUI URL: ${BYellow}http://${IP}:9091${Reset}${White}${Bold}"
echo "${White}${Bold}If you're on the network:"
echo "${White}${Bold}LAN WebUI URL: ${BYellow}http://192.168.1.xxx:9091${Reset}${White}${Bold}"
echo "${White}${Bold}Functions installed to ${BYellow}${RC_FILE}${Reset}${White}${Bold}"
echo "${White}${Bold}Start the daemon: ${BPurple}tsm-daemon${Reset}${White}${Bold}"
echo "${White}${Bold}Stop the daemon: ${BPurple}tsm-quit${Reset}${White}${Bold}"
echo "${Reset}${Reset}${Reset}${Reset}${Reset}${Reset}${Reset}${Reset}${Reset}${Reset}${Reset}${Reset}"

for (( i = 0; i < 50; i++ )); do
    killall -9 transmission-daemon 2> trs-ck
done

rm -Rf trs-ck
