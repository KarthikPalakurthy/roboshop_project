dnf install https://rpm.nodesource.com/pub_20.x/nodistro/repo/nodesource-release-nodistro-1.noarch.rpm -y
dnf install nodejs -y
useradd roboshop
mkdir /app 
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip 
cd /app 
unzip /tmp/catalogue.zip
cd /app 
npm install 
systemctl daemon-reload
systemctl enable catalogue 
systemctl start catalogue
dnf install mongodb-org-shell -y
mongo --host localhost </app/schema/catalogue.js