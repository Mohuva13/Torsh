#Find out if running Linux kernel (OS) is 32 or 64 bit
systemProcessorConfig=`getconf LONG_BIT`

#Check Internet connection with DL Host
if ping -q -c 1 -W 1 mohuva.parsaspace.com >/dev/null; then
  echo "Connected..."
else
  echo "Please check your internet connection and try again."
  exit
fi