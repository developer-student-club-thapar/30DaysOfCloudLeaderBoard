from app import db
import models
from getData import completionDate, getScoreRefresh
import time
import schedule
import os
def refreshDb():
    # write refresh db to log.txt
    finisherData()
    print("Refreshing DB")
    with open("database/scraping_log.txt", "a+") as f:
        f.write("\n=============\nRefreshing DB at " + time.strftime("%H:%M:%S") + "\n")
    # get every row from the database
    data = db.query(models.Leaderboard).all()    
    # get the data from the database
    for user in data:
        print(user.name)
        # put name in the scraping_log
        with open("database/scraping_log.txt", "a+") as f:
            f.write(user.name + " " + "updated\n")
        # get the score
        score = getScoreRefresh(user.qwiklab_url)
        # update the score
        if score != None:
            user.track2_score = score['track2_score']
            user.track1_score = score['track1_score']
            user.total_score = score['total_score']
        #user.profile_image = profileImage(user.qwiklab_url)
        #commit the changes
            time.sleep(20)
            db.commit()
            print("updated")
        else:
            name = user.name 
            with open("database/scraping_log.txt", "a+") as f:
                f.write(user.name + " " + "error: Scrapping FAILED\n\n")
            # put this in a log file
            print("error")
            pass
    # get completition date of the people with total score 12
    # get the data from the database
    # get users with total score 12
    refreshDb()
def finisherData():
    data = db.query(models.Leaderboard).filter(models.Leaderboard.total_score == 12).all()
    for contestant in data:
        # get the date of completion
        date = completionDate(contestant.qwiklab_url)
        contestant.date = date
        # commit the changes
        db.commit()
        print(contestant.name + " updated")

isScraper = os.environ.get('SCRAPER_SWITCH')
if isScraper == "true":
    schedule.every(1).minutes.do(refreshDb)
    while True:
        schedule.run_pending()
        time.sleep(1)
else:
    print("Scraper is off")
