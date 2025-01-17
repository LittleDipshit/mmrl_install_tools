# This API is only for module install scripts

# Systemless Mkshrc could affect this
TMPDIR="/data/local/tmp"
cd $TMPDIR

function getconf {
  /system/bin/getprop "$1" "$2" | sed 's/^"\(.*\)"$/\1/'
}

SCOPE="mmrlini_v4"

CURL=$(getconf "persist.$SCOPE.curl" "$MODULES/mmrl_install_tools/system/usr/share/mmrl/bin/curl")
ZIP=$(getconf "persist.$SCOPE.zip" "$MODULES/mmrl_install_tools/system/usr/share/mmrl/bin/zip")
UNZIP=$(getconf "persist.$SCOPE.unzip" "/system/bin/unzip")

EXTRA_CURL_ARGS=$(getconf "persist.$SCOPE.curl.args" " -L")
EXTRA_ZIP_ARGS=$(getconf "persist.$SCOPE.zip.args" " -r")
EXTRA_UNZIP_ARGS=$(getconf "persist.$SCOPE.unzip.args" " -qq")

GREEN="\x1b[32m"
RED="\x1b[31m"
CYAN="\x1b[96m"
YELLOW="\x1b[93m"
UNDERLINE="\x1b[4m"
RESET="\x1b[0m"

echo "$GREEN    __  _____  _______  __ $RESET"
echo "$GREEN   /  |/  /  |/  / __ \/ / $RESET"
echo "$GREEN  / /|_/ / /|_/ / /_/ / /  $RESET"
echo "$GREEN / /  / / /  / / _, _/ /___$RESET"
echo "$GREEN/_/  /_/_/  /_/_/ |_/_____/$RESET"
echo ""
echo "Using version $CYAN$MMRL_VER$RESET"


install_cli() {
   case "$ROOTMANAGER" in
      "Magisk")
         exec $MSUCLI --install-module "$FILENAME.zip"
         ;;
     "KernelSU")
         exec $KSUCLI module install "$FILENAME.zip"
         ;;
     "APatchSU")
         exec $ASUCLI module install "$FILENAME.zip"
         ;;
      "Unknown")
         echo "! Unable to find root manager"
         exit 1
         ;;
     *)
         echo "! Install error"
         exit 1
         ;;
   esac
}