#!/bin/bash
exec python getNewCSV.py & # check email and get csv file 
#exec gunicorn --certfile=origin.pem --keyfile=key.pem --worker-class gevent --bind 0.0.0.0:6363 app:app
exec gunicorn --worker-class gevent --bind 0.0.0.0:80 app:app