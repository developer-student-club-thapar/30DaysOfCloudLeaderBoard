from database import *
import models
from database import SessionLocal, engine
from app import db
from getData import getScore, leaderboard, profileImage

def refreshDb():
    # get every row from the database
    data = db.query(models.Leaderboard).all()    
    # get the data from the database
    for user in data:
        print(user.name)
        # get the score
        score = getScore(user.qwiklab_url)
        # update the score
        user.track2_score = score['track2_score']
        user.track1_score = score['track1_score']
        user.total_score = score['total_score']
        user.profile_image = profileImage(user.qwiklab_url)
        # commit the changes
        db.commit()
    
def getJsonFromDB():
    data = db.query(models.Leaderboard).all()
    data_result = []
    for user in data:
        print(user.name)
        json = {"name": user.name, "email": user.email, "qwikLabURL": user.qwiklab_url, "track2_score": user.track2_score, "track1_score": user.track1_score, "total_score": user.total_score, "profile_image": user.profile_image}
        data_result.append(json)
    return leaderboard(data_result)
