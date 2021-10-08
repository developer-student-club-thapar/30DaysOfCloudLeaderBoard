from getDB import refreshDb
import schedule
import time

def job():
    print("herE")
    refreshDb()

schedule.every(60).minutes.do(job)

while True:
    schedule.run_pending()
    time.sleep(1)