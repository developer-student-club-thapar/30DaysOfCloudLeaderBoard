from app import db
import models
from getData import getScoreRefresh
import time
import os
def refreshDb():
    # get every row from the database
    data = db.query(models.Leaderboard).all()    
    # get the data from the database
    for user in data:
        print(user.name)
        # get the score
        score = getScoreRefresh(user.qwiklab_url)
        # update the score
        if score != None:
            user.track2_score = score['track2_score']
            user.track1_score = score['track1_score']
            user.total_score = score['total_score']
        #user.profile_image = profileImage(user.qwiklab_url)
        #commit the changes
            time.sleep(40)
            db.commit()
            print("updated")
        else:
            name = user.name 
            print("no score")
            # put this in a log file
            os.system("echo '" + name + "' >> database/scraper_log.txt")
            print("error")
            pass
    
while True:
    refreshDb()
    time.sleep(60)