#!/bin/bash
    apt-get update
    apt-get install -y nginx

    cat > /var/www/html/index.html <<'HTML'
    <!doctype html>
    <html>
    <head><title>EI Terraform Lab</title></head>
    <body>
      <h1>EI Technologies - Terraform Change Demonstration!</h1>
      <p>This Ubuntu EC2 server was provisioned with Terraform.</p>
      <p>Week 8 real-world Infrastructure as Code practical.</p>
    </body>
    </html>
    HTML

    systemctl enable nginx
    systemctl restart nginx
