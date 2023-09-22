source common.sh

print_steps "Copying MongoDB repo file"
cp ${script_location}/files/mongo.repo /etc/yum.repos.d/mongodb.repo
status_check

print_steps "Installing MongoDB"
dnf install mongodb-org -y 
status_check

print_steps "Enabling MongoDB"
systemctl enable mongod 
status_check

print_steps "Changing MongoDB listen address"
sed -i -e 's/127.0.0.1/0.0.0.0' /etc/mongod.conf
status_check

print_steps "Starting MongoDB"
systemctl restart mongod
status_check