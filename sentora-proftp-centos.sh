echo "############################################################"
echo "############################################################"
echo "#  Proftp-fix for Sentora 1.0.0 or 1.0.3  #"
echo "############################################################"

echo -e "\nChecking that minimal requirements are ok"

# Ensure the OS is compatible with the launcher
if [ -f /etc/centos-release ]; then
   OS="CentOs"
   VERFULL=$(sed 's/^.*release //;s/ (Fin.*$//' /etc/centos-release)
   VER=${VERFULL:0:1} # return 6 or 7
elif [ -f /etc/lsb-release ]; then
   OS=$(grep DISTRIB_ID /etc/lsb-release | sed 's/^.*=//')
   VER=$(grep DISTRIB_RELEASE /etc/lsb-release | sed 's/^.*=//')
else
   OS=$(uname -s)
   VER=$(uname -r)
fi
ARCH=$(uname -m)

echo "Detected : $OS  $VER  $ARCH"

if [[ "$OS" = "CentOs" && ("$VER" = "6" || "$VER" = "7" ) ]] ; then
   echo "Ok."
else
   echo "Sorry, this OS is not supported."
   exit 1
fi

## download and install Proftp and needed files and services 
yum install proftpd proftpd-utils proftpd-mysql


## Enable and start Proftp service
systemctl enable proftpd
systemctl start proftpd
