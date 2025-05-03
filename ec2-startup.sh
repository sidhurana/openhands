#!/bin/bash

# Update system
sudo apt-get update
sudo apt-get upgrade -y

# Install Node.js
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs

# Install MongoDB
wget -qO - https://www.mongodb.org/static/pgp/server-6.0.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/6.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list
sudo apt-get update
sudo apt-get install -y mongodb-org
sudo systemctl start mongod
sudo systemctl enable mongod

# Install PM2 globally
sudo npm install -y pm2 -g

# Install Nginx
sudo apt-get install -y nginx

# Create application directory
sudo mkdir -p /var/www/slickdeals-clone
sudo chown -R ubuntu:ubuntu /var/www/slickdeals-clone

# Clone the repository (replace with your actual repository URL)
cd /var/www/slickdeals-clone
git clone https://github.com/sidhurana/openhands.git .

# Install dependencies
npm install
cd client
npm install
npm run build
cd ..

# Create .env file
cat > .env << EOL
MONGODB_URI=mongodb://localhost:27017/slickdeals-clone
JWT_SECRET=your_jwt_secret_here
PORT=5000
NODE_ENV=production
EOL

# Configure Nginx
sudo tee /etc/nginx/sites-available/slickdeals-clone << EOL
server {
    listen 80;
    server_name _;

    location / {
        proxy_pass http://localhost:5000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host \$host;
        proxy_cache_bypass \$http_upgrade;
    }

    location /static {
        alias /var/www/slickdeals-clone/client/build/static;
    }
}
EOL

# Enable the Nginx site
sudo ln -s /etc/nginx/sites-available/slickdeals-clone /etc/nginx/sites-enabled/
sudo rm /etc/nginx/sites-enabled/default
sudo nginx -t
sudo systemctl restart nginx

# Start the application with PM2
pm2 start server.js --name "slickdeals-clone"
pm2 startup
pm2 save

# Install and configure UFW (firewall)
sudo ufw allow 'Nginx Full'
sudo ufw allow ssh
sudo ufw enable

echo "Setup completed successfully!" 