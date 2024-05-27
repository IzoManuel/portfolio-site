#!/bin/bash
sudo cp -r /home/ec2-user/portfolio-site/israel-ibrahim/* /usr/share/nginx/html/
sudo systemctl restart nginx
