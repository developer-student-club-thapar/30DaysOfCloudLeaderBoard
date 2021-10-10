import csv
import os
import sys
import time
from database import SessionLocal, engine
import models
from getData import *
import requests
import random
from getData import getAvatar

avatars = "https://assets.servatom.com/Shealth/avatars"
images = []
url = "https://assets.servatom.com/notefy/avatars"
response = requests.request("GET", url)
for i in response.json():
    if i['isFolder'] == False:
        images.append(i['url'])

def getImage():
    return "http://20.204.137.6/image"


db = SessionLocal()

# get arguments
if len(sys.argv) != 2:
    print("Usage: python3 fillDB.py <csv file>")
    sys.exit(1)

filename = sys.argv[1]

with open(filename, 'r') as csvfile:
    # read the file
    reader = csv.DictReader(csvfile)
    # loop through the file
    for row in reader:
    # get data from the name email and qwiklabs from the file
        if not row["Enrolment Status"] == "All Good":
            continue
        name = row['Student Name']
        print(name)
        email = row['Student Email']
        track1_score = row["# of Skill Badges Completed in Track 1"]
        track2_score = row["# of Skill Badges Completed in Track 2"]
        try:
            total_score = int(track1_score) + int(track2_score)
        except:
            total_score = int(float(track1_score)) + int(float(track2_score))
        print(total_score)
        
    # check if email exists in the database
        qwiklabs = row['Qwiklabs Profile URL']
        if db.query(models.Leaderboard).filter_by(email=email).first() and db.query(models.Leaderboard).filter_by(qwiklab_url=qwiklabs).first():
            # update the score of the user
            # total_score
            user = db.query(models.Leaderboard).filter_by(email=email).first()
            user.total_score = total_score
            user.track1_score = track1_score
            user.track2_score = track2_score
            user.profile_image = getAvatar(qwiklabs)
            db.commit()
            continue
        # check if qwiklabs exists in the database
        # if email and qwiklabs do not exist in the database, add them
        #profile_image = profileImage(qwiklabs)
        else:
            profile_image = getAvatar(qwiklabs)
            user = models.Leaderboard(name=name, email=email, qwiklab_url=qwiklabs, total_score=total_score, track1_score=track1_score, track2_score=track2_score, profile_image=profile_image)
        
        try:
            db.add(user)
            db.commit()
        except:
            db.rollback()
            continue
time.sleep(1)
os.system("rm " + filename)

# update profile image of top 10 users
top10 = db.query(models.Leaderboard).order_by(models.Leaderboard.total_score.desc()).limit(10).all()
for user in top10:
    user.profile_image = profileImage(user.qwiklab_url)
    db.commit()
    time.sleep(1)