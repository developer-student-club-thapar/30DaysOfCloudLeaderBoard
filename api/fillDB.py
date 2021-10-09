import csv
import os
import sys
import time
from database import SessionLocal, engine
import models
from getData import *
import requests
import random

avatars = "https://assets.servatom.com/Shealth/avatars"
images = []
url = "https://assets.servatom.com/notefy/avatars"
response = requests.request("GET", url)
for i in response.json():
    if i['isFolder'] == False:
        images.append(i['url'])

def getImage():
    choice = random.choice(images)
    return choice


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
        name = row['Student Name']
        print(name)
        email = row['Student Email']
        track1_score = row["# of Skill Badges Completed in Track 1"]
        track2_score = row["# of Skill Badges Completed in Track 2"]
        if not row["Enrolment Status"] == "All Good":
            continue
        total_score = int(track1_score) + int(track2_score)
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
            user.avatar = getImage()
            db.commit()
            continue
        # check if qwiklabs exists in the database
        # if email and qwiklabs do not exist in the database, add them
        #profile_image = profileImage(qwiklabs)
        profile_image = getImage()
        user = models.Leaderboard(name=name, email=email, qwiklab_url=qwiklabs, total_score=total_score, track1_score=track1_score, track2_score=track2_score, profile_image=profile_image)
        
        try:
            db.add(user)
            db.commit()
        except:
            db.rollback()
            continue
        time.sleep(1)
        #os.system("rm -f " + filename)
