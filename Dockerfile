# For more information, please refer to https://aka.ms/vscode-docker-python
FROM python:3.8-slim-buster

# Keeps Python from generating .pyc files in the container
ENV PYTHONDONTWRITEBYTECODE=1

# Turns off buffering for easier container logging
ENV PYTHONUNBUFFERED=1

RUN apt-get update
RUN apt-get install -y cron

# Install pip requirements
COPY requirements.txt .
RUN pip install gunicorn[gevent]
RUN python -m pip install -r requirements.txt

WORKDIR /app
COPY ./api /app
RUN mkdir /app/database/
COPY ./cronFile /etc/cron.d/container_cronjob

# Creates a non-root user with an explicit UID and adds permission to access the /app folder
# For more info, please refer to https://aka.ms/vscode-docker-python-configure-containers
RUN adduser -u 5678 --disabled-password --gecos "" appuser && chown -R appuser /app
USER root

RUN chmod 644 /etc/cron.d/container_cronjob
RUN cron

# During debugging, this entry point will be overridden. For more information, please refer to https://aka.ms/vscode-docker-python-debug
# CMD ["python", "fillDB.py"]
CMD ["python", "run.py"]
CMD gunicorn --certfile=origin.pem --keyfile=key.pem --worker-class gevent --bind 0.0.0.0:6363 app:app