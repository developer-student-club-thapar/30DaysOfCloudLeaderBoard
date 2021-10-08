#from app import db
from sqlalchemy import Column, Integer, String
from database import Base

class Leaderboard(Base):
    __tablename__ = 'leaderboard'
    id = Column(Integer, primary_key=True)
    name = Column(String(50), unique=False)
    email = Column(String(120), unique=True)
    qwiklab_url = Column(String(120), unique=True)
    total_score = Column(Integer)
    track1_score = Column(Integer)
    track2_score = Column(Integer)

    def __init__(self, name, email, total_score, track1_score, track2_score, qwiklab_url):
        self.name = name
        self.email = email
        self.qwiklab_url = qwiklab_url
        self.total_score = total_score
        self.track1_score = track1_score
        self.track2_score = track2_score

class UserModel(Base):
    __tablename__ = 'users'
    id = Column(Integer, primary_key=True)
    username = Column(String(120), unique=True)
    # hashed passwd
    password = Column(String(120), unique=False)

    def __init__(self, username, password):
        self.username = username
        self.password = password
        