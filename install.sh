#Find out if running Linux kernel (OS) is 32 or 64 bit
systemProcessorConfig=`getconf LONG_BIT`

#loading
loadingAnimation()
{
    #local variables? / state
    duration=0
    c=0
    toggle=true
    s=""

    while [ true ]
    do
        clear
        if [ "$toggle" = true ]
        then
            ((c++))
            s+="."
            if [ "$c" -gt 50 ]
            then
                #switching
                toggle=false
            fi

        else
            c=$((c-1))
            s=${s: : -1}
            if [ "$c" -lt 1 ]
            then
                #switching
                toggle=true
            fi
        fi

        ((duration++))
        if [ "$duration" -eq 400 ]
        then
            # exit status 0
            return
        fi

        echo "loading"
        echo "$s"
        sleep 0.0003
    done
}

#progress bar
progress-bar() {
  local duration=${1}


    already_done() { for ((done=0; done<$elapsed; done++)); do printf "▇"; done }
    remaining() { for ((remain=$elapsed; remain<$duration; remain++)); do printf " "; done }
    percentage() { printf "| %s%%" $(( (($elapsed)*100)/($duration)*100/100 )); }
    clean_line() { printf "\r"; }

  for (( elapsed=1; elapsed<=$duration; elapsed++ )); do
      already_done; remaining; percentage
      sleep 1
      clean_line
  done
  clean_line
}

#Check Internet connection with DL Host
if ping -q -c 1 -W 1 mohuva.parsaspace.com >/dev/null; then
  loadingAnimation
else
  echo "Please check your internet connection and try again."
  exit
fi

