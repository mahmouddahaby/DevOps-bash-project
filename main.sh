#! /bin/bash
val=$(printenv DBMS_INSTALLED)

if [[ $val == 'TRUE' ]]
then
    . ./dbms/helpers/functions.sh
    . ./dbms/progress-bar.sh
else
    # using sourcing
    . ./helpers/functions.sh
    . ./progress-bar.sh
fi

echo -e "${RED}Loading.."
progress-bar 5
resetColor
clear

# Draw Our Logo (DevOps DBMS)
drawLogo
sleep 2

# show our main menu
mainMenu