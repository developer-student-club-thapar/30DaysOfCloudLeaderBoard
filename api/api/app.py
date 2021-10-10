from flask import Flask, jsonify, request, redirect, Response, send_file
from database import SessionLocal, engine
from getData import *
from database import *
from getDB import *
import models
from security import *
from werkzeug.utils import secure_filename
from flask_cors import CORS, cross_origin
import csv
import threading

app = Flask(__name__)

db = SessionLocal()
models.Base.metadata.create_all(bind=engine)

def readCSVFile(filename):
    print("here")
    os.system("python fillDB.py " + filename + " &")

@app.route('/')
@cross_origin()
def index():
    response = jsonify(getJsonFromDB())
    return response


@app.route('/add', methods=['POST'])
def add():
    # get header
    header = request.headers.get('Authorization')
    if header is None:
        return jsonify({"error": "No authorization header"}), 401

    # pass token to verify
    if verify_token(header) == None:
        return jsonify({"error": "Invalid token"}), 401
    
    # get data from the name email and qwiklabs from the request
    #print(request.json)
    
    name = request.json['name']
    email = request.json['email']
    qwiklabs = request.json['qwikLabURL']
    profile_image = profileImage(qwiklabs)
    score = getScore(qwiklabs)
    user = models.Leaderboard(name=name, email=email, qwiklab_url=qwiklabs, total_score=score["total_score"], track1_score=score["track1_score"], track2_score=score["track2_score"], profile_image=profile_image)
    try:
        db.add(user)
        db.commit()
        # refresh the db
        return jsonify({"success": "success"})
    except:
        return jsonify({"error": "Already exists"})

# upload csv file and put data in the database
@app.route('/upload', methods=['POST'])
def upload():
    # get header
    header = request.headers.get('Authorization')
    if header is None:
        return jsonify({"error": "No authorization header"}), 401

    # pass token to verify
    if verify_token(header) == None:
        return jsonify({"error": "Invalid token"}), 401
    
    # get name email and qwiklabs from the file uploaded
    file = request.files['file']
    # saving the file
    filename = "/app/database/" + secure_filename(file.filename) + "code"
    file.save(filename)
    with open(filename, 'r') as csvfile:
        # read the file
        reader = csv.DictReader(csvfile)
        for row in reader:
            try:
                name = row['Student Name']
                email = row['Student Email']
                qwiklabs = row['Qwiklabs Profile URL']
                # call the function in a different thread
                thread = threading.Thread(target=readCSVFile, args=(filename,))
                thread.start()
                return jsonify({"success": "success"})
            except:
                return Response(jsonify({"error": "Invalid csv file"}), status=400)

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

@app.route('/update', methods=['POST'])
def update():
    email = request.json['email']
    # find email in database
    user = db.query(models.Leaderboard).filter_by(email=email).first()
    score = getScore(user.qwiklab_url)
    user.total_score = score["total_score"]
    user.track1_score = score["track1_score"]
    user.track2_score = score["track2_score"]
    db.commit()
    return jsonify({"success": "success"})

@app.route('/image')
def image():
    # return default.png
    return send_file('default.png', mimetype='image/png')

if __name__== "__main__":
    app.run(
        host='0.0.0.0', port="80",
        #ssl_context=('origin.pem', 'origin.pem'),
    )
