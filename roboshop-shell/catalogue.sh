source common.sh

print_steps "Downloading Node JS"
dnf install https://rpm.nodesource.com/pub_20.x/nodistro/repo/nodesource-release-nodistro-1.noarch.rpm -y &>>${LOG}
status_check

print_steps "Installing NodeJS"
dnf install nodejs -y &>>${LOG}
status_check

print_steps "Adding roboshop user"
if [ $? -ne 0 ]; then
    useradd roboshop &>>${LOG}
fi
status_check

print_steps "Making app directory"
mkdir -p /app &>>${LOG}
status_check

print_steps "Downloading Catalogue content files"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>${LOG}
status_check

print_steps "Removing Old files, if any"
rm -rf /app/* &>>${LOG}
status_check

cd /app 

print_steps "Extracting Catalogue content"
unzip /tmp/catalogue.zip &>>${LOG}
status_check

cd /app 

print_steps "Installing NPM"
npm install &>>${LOG}
status_check

print_steps "Copying service file"
cp ${script_location}/files/catalogue.service /etc/systemd/system/catalogue.service &>>${LOG}
status_check

print_steps "Daemon reload"
systemctl daemon-reload &>>${LOG}
status_check

print_steps "Enabling Catalogue"
systemctl enable catalogue &>>${LOG}
status_check

print_steps "Starting Catalogue"
systemctl start catalogue &>>${LOG}
status_check

print_steps "Copying Mongo repo file"
cp ${script_location}/files/mongo.repo /etc/yum.repos.d/mongo.repo &>>${LOG}
status_check

print_steps "Installing Mongo"
dnf install mongodb-org-shell -y &>>${LOG}
status_check

print_steps "Updating mongo host address"
mongo --host mongodb-dev.devpractice.online </app/schema/catalogue.js &>>${LOG}
status_check