script_location=$(pwd)

echo -e "\e[32m Installing Nginx\e[0m"
dnf install nginx -y 

echo -e "\e[32m Removing Old files\e[0m"
rm -rf /usr/share/nginx/html/* 

echo -e "\e[32m Downloading frontend Content\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip 

cd /usr/share/nginx/html 

echo -e "\e[32m Extracting frontend content\e[0m"
unzip /tmp/frontend.zip

echo -e "\e[32m Copying config files\e[0m"
cp ${script_location}/files/nginx-roboshop.conf /etc/nginx/default.d/roboshop.conf 

echo -e "\e[32m Enabling and starting Nginx\e[0m"
systemctl enable nginx 
systemctl restart nginx