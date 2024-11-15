#!/bin/bash
cd /opt/www/MGweb/data/cert-dev
openssl req -x509 -nodes -newkey rsa:2048 -keyout cert.key -out cert.crt -days 365
