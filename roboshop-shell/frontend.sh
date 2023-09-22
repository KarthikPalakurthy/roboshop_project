script_location=$(pwd)
LOG=/tmp/roboshop.log

echo -e "\e[1m Installing Nginx\e[0m"
dnf install nginx -y  &>>${LOG}
if [ $? -eq 0 ]; then
    echo -e "\e[32m Successful\e[0m"
    else
    echo -e "\e[31m Failure\e[0m"
    echo -e "Refer Log file for more info, Log: ${LOG}"
fi

echo -e "\e[1m Removing Old files\e[0m"
rm -rf /usr/share/nginx/html/* &>>${LOG}
if [ $? -eq 0 ]; then
    echo -e "\e[32m Successful\e[0m"
    else
    echo -e "\e[31m Failure\e[0m"
    echo -e "Refer Log file for more info, Log: ${LOG}"
fi

echo -e "\e[1m Downloading frontend Content\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>${LOG}
if [ $? -eq 0 ]; then
    echo -e "\e[32m Successful\e[0m"
    else
    echo -e "\e[31m Failure\e[0m"
    echo -e "Refer Log file for more info, Log: ${LOG}"
fi

cd /usr/share/nginx/html 

echo -e "\e[1m Extracting frontend content\e[0m"
unzip /tmp/frontend.zip  &>>${LOG}
if [ $? -eq 0 ]; then
    echo -e "\e[32m Successful\e[0m"
    else
    echo -e "\e[31m Failure\e[0m"
    echo -e "Refer Log file for more info, Log: ${LOG}"
fi

echo -e "\e[1m Copying config files\e[0m"
cp ${script_location}/files/nginx-roboshop.conf /etc/nginx/default.d/roboshop.conf &>>${LOG}
if [ $? -eq 0 ]; then
    echo -e "\e[32m Successful\e[0m"
    else
    echo -e "\e[31m Failure\e[0m"
    echo -e "Refer Log file for more info, Log: ${LOG}"
fi

echo -e "\e[1m Enabling and starting Nginx\e[0m"
systemctl enable nginx &>>${LOG}
if [ $? -eq 0 ]; then
    echo -e "\e[32m Successful\e[0m"
    else
    echo -e "\e[31m Failure\e[0m"
    echo -e "Refer Log file for more info, Log: ${LOG}"
fi

echo -e "\e[1m Starting Nginx\e[0m"
systemctl restart nginx &>>${LOG}
if [ $? -eq 0 ]; then
    echo -e "\e[32m Successful\e[0m"
    else
    echo -e "\e[31m Failure\e[0m"
    echo -e "Refer Log file for more info, Log: ${LOG}"
fi