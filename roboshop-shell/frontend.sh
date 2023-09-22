source common.sh

print_steps "Install Nginx"
dnf install nginx -y  &>>${LOG}
status_check

print_steps "Removing Old files"
rm -rf /usr/share/nginx/html/* &>>${LOG}
status_check

print_steps "Downloading frontend Content"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>${LOG}
status_check

cd /usr/share/nginx/html 

print_steps "Extracting frontend content"
unzip /tmp/frontend.zip  &>>${LOG}
status_check

print_steps "Copying config files"
cp ${script_location}/files/nginx-roboshop.conf /etc/nginx/default.d/roboshop.conf &>>${LOG}
status_check

print_steps "Enabling Nginx "
systemctl enable nginx &>>${LOG}
status_check

print_steps "Starting Nginx"
systemctl restart nginx &>>${LOG}
status_check
