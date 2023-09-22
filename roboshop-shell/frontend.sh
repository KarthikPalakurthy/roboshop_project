script_location=$(pwd)
LOG=/tmp/roboshop.log

echo -e "\e[1m Installing Nginx\e[0m"
dnf install nginx -y  &>>${LOG}
if [ $? -eq 0]; then
    echo -e "\e[32m Successful\e[0m"
    else
    echo -e "\e[32m Failure, refer to the log. log path: ${LOG}\e[0m"
fi

echo -e "\e[32m Removing Old files\e[0m"
rm -rf /usr/share/nginx/html/* &>>${LOG}

echo -e "\e[32m Downloading frontend Content\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>${LOG}

cd /usr/share/nginx/html 

echo -e "\e[32m Extracting frontend content\e[0m"
unzip /tmp/frontend.zip  &>>${LOG}

echo -e "\e[32m Copying config files\e[0m"
cp ${script_location}/files/nginx-roboshop.conf /etc/nginx/default.d/roboshop.conf &>>${LOG}

echo -e "\e[32m Enabling and starting Nginx\e[0m"
systemctl enable nginx &>>${LOG}
systemctl restart nginx &>>${LOG}