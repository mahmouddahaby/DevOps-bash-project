#! /bin/bash
val=val=$(printenv DBMS_INSTALLED)

if [[ $val == 'TRUE' ]]
then
    . ./dbms/helpers/functions.sh
    . ./dbms/progress-bar.sh
else
    # using sourcing
    . ./helpers/functions.sh
    . ./progress-bar.sh
fi

if [ $# -eq 0 ]
then
    echo -e "${RED}Loading.."
    progress-bar 5
    resetColor
    clear

    # Draw Our Logo (DevOps DBMS)
    drawLogo
    sleep 2

    # show our main menu
    mainMenu
else
    if [[ $1 == "--version" ]]
    then
        echo 'DBMS Version 1.0, build on 2022'
    fi
    if [[ $1 == "--contributors" ]]
    then
        echo 'DBMS Contributors: <Abdelaziz Omar> . <Mahmoud Dahby>'
    fi
    if [[ $1 == "--help" ]]
    then
        echo 'To start the project, please run <dbms-run> command'
    fi
fi

