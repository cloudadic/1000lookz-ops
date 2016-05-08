#!/bin/bash
sed -i "s/{{SECRET_KEY}}/${SECRET_KEY:-secretkey}/g;s/{DB_USER}}/${DB_USER:-root}/g;s/{{DB_PASSWORD}}/${DB_PASSWORD:-rootsecret}/g;s/{{DB_HOST}}/${DB_HOST:-thousandlookz.crvcwjaximta.us-west-2.rds.amazonaws.com}/g;s/{{DB_NAME}}/${DB_NAME:-api3d}/g;s~{{FRONT_END_URL}}~${FRONT_END_URL:-http://api3d-1000lookz-17819276.us-west-2.elb.amazonaws.com}~g" ./config.json
sed -i "s~http://localhost:5000~${FRONT_END_URL:-http://api3d-1000lookz-17819276.us-west-2.elb.amazonaws.com}~g" ./db_access/templates/upload.html
mkdir -p logs
python manage.py db upgrade
exec python runserver.py
