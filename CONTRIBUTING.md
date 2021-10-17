# Welcome to the contributions of DSC-TIET 30DaysOfCloudLeaderBoard

We follow a systematic Git Workflow -

- Create a fork of this repo.
- Clone your fork of your repo on your pc.
- [Add Upstream to your clone](https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/configuring-a-remote-for-a-fork)
- **Every change** that you do, it has to be on a branch. Commits on master would directly be closed.
- Make sure that before you create a new branch for new changes,[syncing with upstream](https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/syncing-a-fork) is neccesary.

## Setup and running of project (Backend) 🧮
- Fork the repo and clone it.
- Go in the repo and go into the ```api``` folder <br>
- Edit the docker-compose.yml file
    - For the ```SECRET_KEY``` run ```openssl rand -hex 32``` in your terminal and put the output in the variable
    - For ```EMAIL_USER``` and ```EMAIL_PASS``` put in the credentials of your gmail email id.
    - Forward the relevant port for the API server
- For https server put the  ```origin.pem``` and ```key.pem``` certificates in the api folder
- To run the server run: ```docker-compose up --build```
- Server will now run at: ```https://<hostname>:<port_exposed>```
- To run via http:
    - Comment the ssl_context line in the ```api/api/app.py```
    - In ```api/api/run.sh``` comment line 3 and uncomment line 4 and make the necessary changes to the port

## Setup and running of project (Frontend)
- Make sure you have nodejs installed on your machine.
- Move into the client directory by doing `cd client` in the root directory of this repository
- After getting into the client directory, run `npm install` to install all the dependencies
- Start react server with ```npm start```

Runs the app on your localhost.<br />
Open [http://localhost:3000](http://localhost:3000) to view it in the browser.

### Note

After adding dependencies use ```pip freeze > requirements.txt``` to update the ```requirements.txt``` file.

- Use only `yarn add package_name` to add new packages to the frontend part.
