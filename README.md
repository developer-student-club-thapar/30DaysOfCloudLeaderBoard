<p align="center">
  <a href="https://github.com/developer-student-club-thapar/30DaysOfCloudLeaderBoard">
    <img src="https://assets.servatom.com/DSC/gcp/cloud-icon.png" alt="cloud" width="80" height="80">
  </a>
  <h1 align="center">30 Days of Cloud Leaderboard</h1>
</p>

<div align="center">
  <h4>
    <a href="https://github.com/developer-student-club-thapar/30DaysOfCloudLeaderBoard/stargazers"><img src="https://img.shields.io/github/stars/developer-student-club-thapar/30DaysOfCloudLeaderBoard.svg?style=plasticr"/></a>
    <a href="https://github.com/developer-student-club-thapar/30DaysOfCloudLeaderBoard/network/"><img src="https://badgen.net/github/forks/developer-student-club-thapar/30DaysOfCloudLeaderBoard"/></a>
    <a href="https://github.com/developer-student-club-thapar/30DaysOfCloudLeaderBoard/commits/master"><img src="https://img.shields.io/github/last-commit/developer-student-club-thapar/30DaysOfCloudLeaderBoard.svg?style=plasticr"/></a>
    <a href="https://github.com/developer-student-club-thapar/30DaysOfCloudLeaderBoard/commits/master"><img src="https://img.shields.io/github/commit-activity/y/developer-student-club-thapar/30DaysOfCloudLeaderBoard.svg?style=plasticr"/></a>
    <a href="https://github.com/developer-student-club-thapar/30DaysOfCloudLeaderBoard/blob/main/LICENSE"><img src="https://img.shields.io/badge/License-MIT-blue.svg"/></a>
  </h4>
</div>

<table  align="center">
  <tr>
    <td>
      This is a leaderboard for the students of Thapar, Patiala who are participating in the 2021 30 days of Google Cloud Platform Challenge
     </td>
   </tr>
</table>

<h2 align='left'>Overview</h2>
Here is the website :  https://30daysofgcp.dsctiet.tech/


The project consists of a single page site and an app having a leaderboard table with search functionality to easily find a particular participant by name, and a couple of graphs showing the general point trends. The graphs have been made using `react-chartjs-2` npm package in the web version and `syncfusion_flutter_charts` in the app. The leaderboard encourages the participants to proceed with their challenge by giving the top scorer(s) a crown <img src="https://assets.servatom.com/DSC/gcp/crown.jpeg" height="16px"> against their ranks. This has been done to promote healthy competition among the participants and appreciate the enthusiasm of those who finished the challenge before time! 

<hr>

## We follow a systematic Git Workflow -
- Create a fork of this repo.
- Clone your fork of your repo on your pc.
- [Add Upstream to your clone](https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/configuring-a-remote-for-a-fork)
- **Every change** that you do, it has to be on a branch. Commits on master would directly be closed.
- Make sure that before you create a new branch for new changes,[syncing with upstream](https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/syncing-a-fork) is neccesary.


### Setup and running of project (Backend) 🧮
- Fork the repo and clone it.
- Go in the repo and go into the ```api``` folder <br>
- Edit the docker-compose.yml file
    - For the ```SECRET_KEY``` run ```openssl rand -hex 32``` in your terminal and put the output in the variable
    - For ```EMAIL_USER``` and ```EMAIL_PASS``` put in the credentials of your gmail email id.
    - Forward the relevant port for the API server
- For https server put the  ```origin.pem``` and ```key.pem``` certificates in the api folder
- To run the server run: ```docker-compose up --build```

 
### Setup and running of project (Frontend) 🔮

- Make sure you have nodejs installed on your machine.
- Move into the client directory by doing `cd client` in the root directory of this repository
- After getting into the client directory, run `npm install` to install all the dependencies
- Start react server with ```npm start```

Runs the app on your localhost.<br />
Open [http://localhost:3000](http://localhost:3000) to view it in the browser.

### Setup and running of project (App) 📱

- Make sure you have Flutter installed on your machine
- Move into the `gcloud_leaderboard` by doing `cd app/gcloud_leaderboard` in the root directory of this repository
- After getting into the gcloud_leaderboard directory, run `flutter pub get` to install all the dependencies
- Run the app on an emulator


## Built With ⚒
### Backend 📡
<!-- * [Django 3.0](https://www.djangoproject.com) - The web framework used in the project.
* [Django Graphene ( Django Graphene )](https://docs.graphene-python.org/projects/django/en/latest/) - Used to generate GraphQL API -->
* [Flask](https://flask.palletsprojects.com/en/2.0.x/) - Does the magic of making REST API endpoints 
* [SQLAlchemy](https://www.sqlalchemy.org/) - Storing the scores and user data in a database
* [Docker](https://www.docker.com/) - Running the server in a containerised way

### Web Application 🖥
* [React](https://reactjs.org) - Do you Even Need an introduction to this ? 😂
    * [react-chartjs-2](https://www.npmjs.com/package/react-chartjs-2) - Simple yet flexible JavaScript charting for designers & developers
    
### Mobile Application 📲
* [Flutter](https://flutter.dev/)- Better to write one codebase instead of two 😉
    * `syncfusion_flutter_charts` - for creating graphs
    * `provider` - for state management
    * `http` - for working with REST APIs


## Authors ✍🏻

* **Raghav Sharma** - *Backend Flask, API and Deployment* - [raghavTinker](https://github.com/raghavTinker)
* **Yashvardhan Arora** - *UI and React Web Application* - [yash22arora](https://github.com/yash22arora)
* **Sidharth Bahl** - *Flutter Mobile Application* - [sidB67](https://github.com/sidB67)
