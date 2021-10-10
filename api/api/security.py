from jose import JWTError, jwt
from passlib.context import CryptContext
import os
from pydantic import BaseModel


# run openssl rand -hex 32
# get key from dotenv
SECRET_KEY = os.getenv("SECRET_KEY")
ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_MINUTES = 30

pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

class Token(BaseModel):
    access_token: str
    token_type: str


class TokenData(BaseModel):
    username: str = None
    
def verify_passwd(plain_passwd, hashed_passwd):
    return pwd_context.verify(plain_passwd, hashed_passwd)

def hashMe(password):
    return pwd_context.hash(password)

def create_access_token(user_id):
    """
    Create a new access token
    :param user_id:
    :return:
    """
    payload = {
        "sub": user_id
        #"exp": datetime.datetime.utcnow() + datetime.timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES)
    }
    return jwt.encode(payload, SECRET_KEY, algorithm=ALGORITHM)

def get_current_user(token):
    user = ""
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        username: str = payload.get("sub")
        if username is None:
            user = None
            return {"message": "error"}
        user = username
        token_data = TokenData(username=username)
    except JWTError:
        return {"message": "error"}
    if user is None:
        return {"message": "error"}
    return user

def verify_token(token):
    """
    Verify the token
    :param token:
    :return:
    """
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
    except JWTError:
        return None
    return payload.get("sub")