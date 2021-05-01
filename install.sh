#Find out if running Linux kernel (OS) is 32 or 64 bit
systemProcessorConfig=$(getconf LONG_BIT)

#loading
loadingAnimation() {
  echo "\n"
  while true; do for X in '-' '/' '|' '\'; do
    echo "\b$X"
    sleep 0.1
  done; done
}

#progress bar
progreSh() {
  LR='\033[1;31m'
  LG='\033[1;32m'
  LY='\033[1;33m'
  LC='\033[1;36m'
  LW='\033[1;37m'
  NC='\033[0m'
  if [ "${1}" = "0" ]; then TME=$(date +"%s"); fi
  SEC=$(printf "%04d\n" $(($(date +"%s") - ${TME})))
  SEC="$SEC sec"
  PRC=$(printf "%.0f" ${1})
  SHW=$(printf "%3d\n" ${PRC})
  LNE=$(printf "%.0f" $((${PRC} / 2)))
  LRR=$(printf "%.0f" $((${PRC} / 2 - 12)))
  if [ ${LRR} -le 0 ]; then LRR=0; fi
  LYY=$(printf "%.0f" $((${PRC} / 2 - 24)))
  if [ ${LYY} -le 0 ]; then LYY=0; fi
  LCC=$(printf "%.0f" $((${PRC} / 2 - 36)))
  if [ ${LCC} -le 0 ]; then LCC=0; fi
  LGG=$(printf "%.0f" $((${PRC} / 2 - 48)))
  if [ ${LGG} -le 0 ]; then LGG=0; fi
  LRR_=""
  LYY_=""
  LCC_=""
  LGG_=""
  for ((i = 1; i <= 13; i++)); do
    DOTS=""
    for ((ii = ${i}; ii < 13; ii++)); do DOTS="${DOTS}."; done
    if [ ${i} -le ${LNE} ]; then LRR_="${LRR_}#"; else LRR_="${LRR_}."; fi
    echo -ne "  ${LW}${SEC}  ${LR}${LRR_}${DOTS}${LY}............${LC}............${LG}............ ${SHW}%${NC}\r"
    if [ ${LNE} -ge 1 ]; then sleep .05; fi
  done
  for ((i = 14; i <= 25; i++)); do
    DOTS=""
    for ((ii = ${i}; ii < 25; ii++)); do DOTS="${DOTS}."; done
    if [ ${i} -le ${LNE} ]; then LYY_="${LYY_}#"; else LYY_="${LYY_}."; fi
    echo -ne "  ${LW}${SEC}  ${LR}${LRR_}${LY}${LYY_}${DOTS}${LC}............${LG}............ ${SHW}%${NC}\r"
    if [ ${LNE} -ge 14 ]; then sleep .05; fi
  done
  for ((i = 26; i <= 37; i++)); do
    DOTS=""
    for ((ii = ${i}; ii < 37; ii++)); do DOTS="${DOTS}."; done
    if [ ${i} -le ${LNE} ]; then LCC_="${LCC_}#"; else LCC_="${LCC_}."; fi
    echo -ne "  ${LW}${SEC}  ${LR}${LRR_}${LY}${LYY_}${LC}${LCC_}${DOTS}${LG}............ ${SHW}%${NC}\r"
    if [ ${LNE} -ge 26 ]; then sleep .05; fi
  done
  for ((i = 38; i <= 49; i++)); do
    DOTS=""
    for ((ii = ${i}; ii < 49; ii++)); do DOTS="${DOTS}."; done
    if [ ${i} -le ${LNE} ]; then LGG_="${LGG_}#"; else LGG_="${LGG_}."; fi
    echo -ne "  ${LW}${SEC}  ${LR}${LRR_}${LY}${LYY_}${LC}${LCC_}${LG}${LGG_}${DOTS} ${SHW}%${NC}\r"
    if [ ${LNE} -ge 38 ]; then sleep .05; fi
  done
}

#Check Internet connection with DL Host
if ping -q -c 1 -W 1 mohuva.parsaspace.com >/dev/null; then
  loadingAnimation &
  sleep 1
  selfID=$!
  kill $selfID >/dev/null 2>&1
else
  echo "Please check your internet connection and try again."
  exit
fi

#create folder for tor files

path_file=~/.torsh/
if [[ -d "$path_file" ]]; then
  rm -rf ~/.torsh/
  mkdir ~/.torsh/
  cd ~/.torsh/
else
  mkdir ~/.torsh/
  cd ~/.torsh/
fi

#Select package

PS3="Choose which to install : "
select torpackage in Tor Tor-Browser 'Tor and Tor-Browser'; do
  choose=$torpackage
  break
done

#Install functions

#Install tor function
function tor-installer() {
  printf "\n\n\n\n\n\n\n\n\n\n"
  progreSh 0
  progreSh 10
  progreSh 20
  progreSh 30
  curl --request GET -sL \
    --url 'http://mohuva.parsaspace.com/source/tor.tar.gz' \
    --output './tor.tar.gz'
  progreSh 40
  progreSh 50
  progreSh 60
  tar xzf tor.tar.gz
  cd tor-0.4.5.7
  progreSh 70
  ./configure && make
  progreSh 85
}

#Install tor-browser function
function tor-browser-installer() {
  printf "\n\n\n\n\n\n\n\n\n\n"
  progreSh 0
  progreSh 10
  progreSh 20
  progreSh 30
  PS3="Choose which to install : "
  select tor_browserpackage in 'Tor-Browser English' 'Tor-Browser Farsi'; do
    choose_browser=$tor_browserpackage
    break
  done
  if [[ "$choose_browser" == "Tor-Browser Farsi" ]]; then
    if [[ "$systemProcessorConfig" == "64" ]]; then
        loadingAnimation &
        sleep 1
        selfId=$!
        echo 'Downloading data...'
        curl --request GET -sL \
          --url 'http://mohuva.parsaspace.com/browser/tor-browser-linux64-fa.tar.xz' \
          --output './tor-browser-linux64-fa.tar.xz'
        tar -xf tor-browser-linux32-fa.tar.xz
        cd tor-browser_fa
        ./start-tor-browser.desktop --register-app
        kill $selfId >/dev/null 2>&1
    else
      loadingAnimation &
      sleep 1
      selfID=d!
      echo 'Downloading data...'
      curl --request GET -sL \
        --url 'http://mohuva.parsaspace.com/browser/tor-browser-linux32-fa.tar.xz' \
        --output './tor-browser-linux32-fa.tar.xz'
      tar -xf tor-browser-linux32-fa.tar.xz
      cd tor-browser_fa
      ./start-tor-browser.desktop --register-app
      kill $selfId >/dev/null 2>&1
    fi
  else
    if [[ "$systemProcessorConfig" == "64" ]]; then
        loadingAnimation &
        sleep 1
        selfId=$!
        echo 'Downloading data...'
        curl --request GET -sL \
          --url 'http://mohuva.parsaspace.com/browser/tor-browser-linux64-en-US.tar.xz' \
          --output './tor-browser-linux64-en-US.tar.xz'
        tar -xf tor-browser-linux64-en-US.tar.xz
        cd tor-browser_en-US
        ./start-tor-browser.desktop --register-app
        kill $selfId >/dev/null 2>&1
    else
      loadingAnimation &
      sleep 1
      selfId=$!
      echo 'Downloading data...'
      curl --request GET -sL \
        --url 'http://mohuva.parsaspace.com/browser/tor-browser-linux32-en-US.tar.xz' \
        --output './tor-browser-linux32-en-US.tar.xz'
      tar -xf tor-browser-linux32-en-US.tar.xz
      cd tor-browser_en-US
      ./start-tor-browser.desktop --register-app
      kill $selfId >/dev/null 2>&1
    fi
  fi
  progreSh 40
  progreSh 50
  progreSh 60
  tar -xf tor.tar.gz
  cd tor-0.4.5.7
  progreSh 70
  ./configure && make
  progreSh 85
}

function tor_starter() {
    sudo systemctl enable tor.service
    sudo systemctl start tor.service
    journalctl -exfu tor
}

function torstarter_case() {
    PS3="Do you want to start tor? : "
    select torEnable in 'Yes' 'No'; do
        if [[ "$torEnable" == "Yes" ]]; then
            tor_starter
        else
          break
        fi
        break
    done
}

if [[ "$torpackage" == "Tor" ]]; then
  tor-installer
  progreSh 92
  progreSh 100
  echo 'Tor was successfully installed'
  torstarter_case
fi

if [[ "$torpackage" == "Tor-Browser" ]]; then
  tor-browser-installer
  progreSh 92
  progreSh 100
  echo 'Tor-Browser was successfully installed'
fi

if [[ "$torpackage" == "Tor and Tor-Browser" ]]; then
  tor-installer
  progreSh 87
  progreSh 89
  tor-browser-installer
  progreSh 92
  progreSh 100
  echo 'Tor and Tor-Browser were successfully installed :)'
  torstarter_case
fi

echo "\n Finished"
