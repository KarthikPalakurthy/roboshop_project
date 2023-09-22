script_location=$(pwd)

LOG=/tmp/roboshop.log

status_check(){
    if [ $? -eq 0 ]; then
        echo -e "\e[32m Successful\e[0m"
        else
        echo -e "\e[31m Failure\e[0m"
        echo -e "Refer Log file for more info, Log: ${LOG}"
        exit
    fi
}

print_steps(){
    echo -e "\e[1m $1 \e[0m"
}