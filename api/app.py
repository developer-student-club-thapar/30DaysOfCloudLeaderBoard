from flask import Flask, jsonify, request, redirect
from database import SessionLocal, engine
from getData import *
from database import *
from getDB import *
import models
from security import *

app = Flask(__name__)

db = SessionLocal()
models.Base.metadata.create_all(bind=engine)

@app.route('/')
def index():
    return jsonify(getJsonFromDB())


@app.route('/add', methods=['POST'])
def add():
    # get header
    header = request.headers.get('Authorization')
    if header is None:
        return jsonify({"error": "No authorization header"}), 401

    # pass token to verify
    if get_current_user(header) == None:
        return jsonify({"error": "Invalid token"}), 401
    
    # get data from the name email and qwiklabs from the request
    #print(request.json)
    
    name = request.json['name']
    email = request.json['email']
    qwiklabs = request.json['qwiklabs']
    score = getScore(qwiklabs)
    user = models.Leaderboard(name=name, email=email, qwiklab_url=qwiklabs, total_score=score["total_score"], track1_score=score["track1_score"], track2_score=score["track2_score"])
    try:
        db.add(user)
        db.commit()
        # refresh the db
        refreshDb()
        return jsonify({"success": "success"})
    except:
        return jsonify({"error": "Already exists"})

@app.route('/register', methods=['POST'])
def register():
    # get data from the name email and qwiklabs from the request
    #print(request.json)
    
    username = request.json['username']
    password = request.json['password']
    user = models.UserModel(username=username, password=hashMe(password))
    try:
        db.add(user)
        db.commit()
        return jsonify({"success": "success"})
    except:
        return jsonify({"error": "Already exists"})

@app.route('/login', methods=['POST'])
def login():
    username = request.json['username']
    password = request.json['password']
    user = db.query(models.UserModel).filter_by(username=username).first()
    if not user:
        return jsonify({"message": "user does not exist"})        

    if not verify_passwd(password, user.password):
        # return status code 401 and send message
        return jsonify({"message": "Invalid credentials"})

    access_token = create_access_token(user.username)
    return {"access_token": access_token, "type": "bearer"}


if __name__== "__main__":
    app.run(
        host='0.0.0.0', port="5000",
    )


