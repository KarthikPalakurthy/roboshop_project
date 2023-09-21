script_location=$(pwd)
cp ${script_location}/files/mongo.repo /etc/yum.repos.d/mongodb.repo
dnf install mongodb-org -y 
systemctl enable mongod 

sed -i -e 's/127.0.0.1/0.0.0.0' /etc/mongod.conf
systemctl restart mongod