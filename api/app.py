from flask import Flask, jsonify, request, redirect
from database import SessionLocal, engine
from getData import *
from database import *
from getDB import *
import models

app = Flask(__name__)

db = SessionLocal()
models.Base.metadata.create_all(bind=engine)

@app.route('/')
def index():
    return jsonify(getJsonFromDB())


@app.route('/add', methods=['POST'])
def add():
    # get data from the name email and qwiklabs from the request
    #print(request.json)
    
    name = request.json['name']
    email = request.json['email']
    qwiklabs = request.json['qwiklabs']
    score = getScore(qwiklabs)
    user = models.Leaderboard(name=name, email=email, qwiklab_url=qwiklabs, total_score=score["total_score"], track1_score=score["track1_score"], track2_score=score["track2_score"])
    db.add(user)
    db.commit()
    # refresh the db
    refreshDb()
    return jsonify({"success": "success"})


if __name__== "__main__":
    app.run(
        host='0.0.0.0', port="5000",
    )


