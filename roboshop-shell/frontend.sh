script_location=$(pwd)
LOG=/tmp/roboshop.log

echo -e "\e[32m Installing Nginx\e[0m"
dnf install nginx -y  &>>${LOG}

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