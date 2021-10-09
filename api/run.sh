#!/bin/bash
exec python getNewCSV.py &
exec gunicorn --certfile=origin.pem --keyfile=key.pem --worker-class gevent --bind 0.0.0.0:6363 app:app
