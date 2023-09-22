source common.sh

print_steps "Copying MongoDB repo file"
cp ${script_location}/files/mongo.repo /etc/yum.repos.d/mongodb.repo &>>${LOG}
status_check

print_steps "Installing MongoDB"
dnf install mongodb-org -y &>>${LOG}
status_check

print_steps "Enabling MongoDB"
systemctl enable mongod &>>${LOG}
status_check

print_steps "Changing MongoDB listen address"
sed -i -e "s/127.0.0.1/0.0.0.0/" /etc/mongod.conf &>>${LOG}
status_check

print_steps "Starting MongoDB"
systemctl restart mongod &>>${LOG}
status_check