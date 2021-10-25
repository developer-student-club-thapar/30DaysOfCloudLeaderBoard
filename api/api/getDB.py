from database import *
import models
from database import SessionLocal, engine
from app import db
from getData import leaderboard
import time
from datetime import datetime
def getJsonFromDB():
    # get users with user.date NULL
    topers = db.query(models.Leaderboard).filter(models.Leaderboard.date != None).all()
    print(len(topers))
    others = db.query(models.Leaderboard).filter(models.Leaderboard.date == None).all()
    data_result = []
    # sort data by completion date
    for user in topers:
        json = {"name": user.name, "email": user.email, "qwikLabURL": user.qwiklab_url, "track2_score": user.track2_score, "track1_score": user.track1_score, "total_score": user.total_score, "profile_image": user.profile_image, "date": user.date}
        data_result.append(json)
    # sort data by completion date
        data_result = sorted(data_result, key=lambda x: datetime.strptime(x["date"], "%d-%b-%Y"))
    #data.sort(key=lambda x: x['total_score'], reverse=True)
    for user in others:
        print(user.name)
        json = {"name": user.name, "email": user.email, "qwikLabURL": user.qwiklab_url, "track2_score": user.track2_score, "track1_score": user.track1_score, "total_score": user.total_score, "profile_image": user.profile_image, "date": ""}
        data_result.append(json)
    return leaderboard(data_result)
    