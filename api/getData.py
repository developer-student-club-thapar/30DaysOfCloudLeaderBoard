import csv
from bs4 import BeautifulSoup
import requests
from urllib.request import urlopen
import sqlite3

track1 = ["Create and Manage Cloud Resources", "Perform Foundational Infrastructure Tasks in Google Cloud", "Set Up and Configure a Cloud Environment in Google Cloud", "Deploy and Manage Cloud Environments with Google Cloud", "Build and Secure Networks in Google Cloud", "Deploy to Kubernetes in Google Cloud"]
track2 = ["Create and Manage Cloud Resources", "Perform Foundational Data, ML, and AI Tasks in Google Cloud", "Insights from Data with BigQuery", "Engineer Data in Google Cloud", "Integrate with Machine Learning APIs", "Explore Machine Learning Models with Explainable AI"]

# get data from the users.csv file
def addUser(name, email, qwikLabURL):
    # open the file
    json = {"name": name, "email": email, "qwikLabURL": qwikLabURL}
    # add this json file in the db if the table exists else create a table
    conn = sqlite3.connect('database/leaderboard.db')
    c = conn.cursor()
    c.execute("CREATE TABLE IF NOT EXISTS leaderboard (name TEXT, email TEXT, qwikLabURL TEXT, track1_score INT, track2_score INT, total_score INT)")
    score = getScore(qwikLabURL)
    c.execute("INSERT INTO leaderboard VALUES (?,?,?,?,?,?)", (json['name'], json['email'], json['qwikLabURL'], score['track1_score'], score['track2_score'], score['total_score']))
    conn.commit()
    conn.close()
    json = getFromDB()
    storeJSONInDB(json)


def getScore(qwikLabURL):
    # get the users data
    url = qwikLabURL
    # open url and find class ql-subhead1 l-mts
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


def leaderboard(data):
    # put the user dictionaries in descending order with the total score
    data.sort(key=lambda x: x['total_score'], reverse=True)
    return data

def storeJSONInDB(json):
    data = leaderboard(json)
    # store it in a sqlite3 database
    conn = sqlite3.connect('database/leaderboard.db')
    c = conn.cursor()
    c.execute("DROP TABLE IF EXISTS leaderboard")
    c.execute("CREATE TABLE leaderboard (name TEXT, email TEXT, qwikLabURL TEXT, track1_score INT, track2_score INT, total_score INT)")
    for user in data:
        c.execute("INSERT INTO leaderboard VALUES (?,?,?,?,?,?)", (user['name'], user['email'], user['qwikLabURL'], user['track1_score'], user['track2_score'], user['total_score']))
    conn.commit()
    conn.close()

def getFromDB():
    # get data from sqlite3 database in json
    conn = sqlite3.connect('database/leaderboard.db')
    c = conn.cursor()
    c.execute("SELECT * FROM leaderboard")
    data = c.fetchall()
    result_json = []
    for row in data:
        result_json.append({"name": row[0], "email": row[1], "qwikLabURL": row[2], "track1_score": row[3], "track2_score": row[4], "total_score": row[5]})
    return result_json

def refreshScoreOfUser():
    json = getFromDB()
    for user in json:
        score = getScore(user['qwikLabURL'])
        conn = sqlite3.connect('database/leaderboard.db')
        c = conn.cursor()
        c.execute("UPDATE leaderboard SET track1_score = ?, track2_score = ?, total_score = ? WHERE qwikLabURL = ?", (score['track1_score'], score['track2_score'], score['total_score'], user['qwikLabURL']))
        conn.commit()
        conn.close()
    storeJSONInDB(json)