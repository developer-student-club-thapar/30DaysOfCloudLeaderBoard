from database import *
import models
from database import SessionLocal, engine
from app import db
from getData import getScore, getScoreRefresh, leaderboard, profileImage
import time

def getJsonFromDB():
    data = db.query(models.Leaderboard).all()
    data_result = []
    count = 0
    for user in data:
        print(user.name)
        json = {"name": user.name, "email": user.email, "qwikLabURL": user.qwiklab_url, "track2_score": user.track2_score, "track1_score": user.track1_score, "total_score": user.total_score, "profile_image": user.profile_image}
        data_result.append(json)
    return leaderboard(data_result)
