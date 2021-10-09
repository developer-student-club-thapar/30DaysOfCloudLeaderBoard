from bs4 import BeautifulSoup
from urllib.request import urlopen
import time
from models import Leaderboard
from database import SessionLocal, engine
import models
#from database import db

db = SessionLocal()

track1 = ["Create and Manage Cloud Resources", "Perform Foundational Infrastructure Tasks in Google Cloud", "Set Up and Configure a Cloud Environment in Google Cloud", "Deploy and Manage Cloud Environments with Google Cloud", "Build and Secure Networks in Google Cloud", "Deploy to Kubernetes in Google Cloud"]
track2 = ["Create and Manage Cloud Resources", "Perform Foundational Data, ML, and AI Tasks in Google Cloud", "Insights from Data with BigQuery", "Engineer Data in Google Cloud", "Integrate with Machine Learning APIs", "Explore Machine Learning Models with Explainable AI"]

# get data from the users.csv file
def addUser(name, email, qwikLabURL):
    # open the file
    json = {"name": name, "email": email, "qwikLabURL": qwikLabURL}
    # add this json file in the db if the table exists else create a table
    # get score
    score = getScore(qwikLabURL)
    json["track2_score"] = score['track2_score']
    json["track1_score"] = score['track1_score']
    json["total_score"] = score['total_score']
    return json

def getScore(qwikLabURL):
    # get the users data
    url = qwikLabURL
    # open url and find class ql-subhead1 l-mts 
    try:
        html = urlopen(url)
        soup = BeautifulSoup(html, "html.parser")
        # get the class
        badges_bs4 = soup.find_all('span', class_='ql-subhead-1 l-mts')
        badges = []
        for badge_bs4 in badges_bs4:
            badges.append(badge_bs4.text.strip())
        track1_Score = 0
        track2_Score = 0
        # track1_score
        for badge in badges:
            if badge in track1:
                track1_Score += 1
        for badge in badges:
            if badge in track2:
                track2_Score += 1
        return {'track1_score': track1_Score, 'track2_score': track2_Score, "total_score": track1_Score + track2_Score}
    except:
        time.sleep(20)
        getScore(qwikLabURL)

def leaderboard(data):
    # put the user dictionaries in descending order with the total score
    data.sort(key=lambda x: x['total_score'], reverse=True)
    return data

def profileImage(qwikLabURL):
    # get the users data
    url = qwikLabURL
    # open url and find class ql-subhead1 l-mts
    try:
        html = urlopen(url)
        soup = BeautifulSoup(html, "html.parser")
        # get the class
        profile_image_link_list = soup.find_all('ql-avatar', class_="l-mbl")
        profile_image_link = "https://assets.servatom.com/Shealth/avatars/Koala.png"
        try:
            profile_image_link = str(profile_image_link_list[0]).split("src=")[1].split('"')[1]
        except:
            pass
    except:
        time.sleep(20)
        profileImage(qwikLabURL)
    return profile_image_link