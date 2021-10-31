from bs4 import BeautifulSoup
from urllib.request import urlopen
import time
from models import Leaderboard
from database import SessionLocal, engine
import models
import os

#from database import db
compYear = os.environ.get('YEAR')
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

def getAvatar(qwikLabURL):
    url = qwikLabURL
    try:
        html = urlopen(url)
        soup = BeautifulSoup(html, "html.parser")
        profile_image_link_list = soup.find_all('ql-avatar', class_="l-mbl")
        profile_image_link = str(profile_image_link_list[0]).split("src=")[1].split('"')[1]
        return profile_image_link
    except:
        return "https://gcloud.servatom.com/image"

def getScoreRefresh(qwikLabURL):
    """Returns the score of the uer by scraping data from the qwiklabURL"""
    # get the users data
    url = qwikLabURL
    # open url and find class ql-subhead1 l-mts 
    tries = 0
    while (tries < 5):
        try:
            html = urlopen(url)
            soup = BeautifulSoup(html, "html.parser")
            
            # get the class
            badges_bs4 = soup.find_all('span', class_='ql-subhead-1 l-mts')
            badges = []
            for badge_bs4 in badges_bs4:
                year = badge_bs4.find_next_sibling("span").text.split(" ")[-1].strip()
                if year == compYear:
                    badges.append(badge_bs4.text.strip())
            track1_Score = 0
            track2_Score = 0
            
            for badge in badges:
                if badge in track1:
                    track1_Score += 1
            for badge in badges:
                if badge in track2:
                    track2_Score += 1
            return {'track1_score': track1_Score, 'track2_score': track2_Score, "total_score": track1_Score + track2_Score}
        except:
            time.sleep(20)
            tries += 1
            continue
    return None

def completionDate(url):
    # get the users data
    url = url
    # open url and find class ql-subhead1 l-mts 
    try:
        html = urlopen(url)
        soup = BeautifulSoup(html, "html.parser")
        # get the class
        badges = soup.find_all('span', class_='ql-subhead-1 l-mts')
        completion_date = ""
        for badge in badges:
            print(badge.text.strip())
            if badge.text.strip() in track1:
                date = badge.find_next_sibling("span").text.split()
                day = date[2].split(",")[0].strip()
                month = date[1].strip()
                year = date[3].strip()
                if year == compYear:
                    completion_date = day + "-" + month + "-" + year
                    return completion_date
                else:
                    continue
            elif badge.text.strip() in track2:
                date = badge.find_next_sibling("span").text.split()
                day = date[2].split(",")[0].strip()
                month = date[1].strip()
                year = date[3].strip()
                if year == compYear:
                    completion_date = day + "-" + month + "-" + year
                    return completion_date
                else:
                    continue
            else:
                continue
    except:
        time.sleep(20)
        return completionDate(url)