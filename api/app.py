from flask import Flask, jsonify, request, redirect
from getData import *
from werkzeug.utils import secure_filename
import os

app = Flask(__name__)

@app.route('/')
def index():
    try:
        return jsonify(getFromDB())
    except:
        return jsonify({"error": "Error"})


@app.route('/add', methods=['POST'])
def add():
    # get data from the name email and qwiklabs from the request
    #print(request.json)
    
    name = request.json['name']
    email = request.json['email']
    qwiklabs = request.json['qwiklabs']
    # add the data to the database
    addUser(name, email, qwiklabs)
    
    return jsonify({"success": "success"})


if __name__== "__main__":
    app.run(
        host='0.0.0.0', port="5000",
    )


