import imaplib
import base64   
import email
import os
import pandas as pd
import schedule
import time
import os
sender_email = os.environ.get('SENDER_EMAIL')
if sender_email == None:
    sender_email = "email@email.com"
last_read_email = ""

def generateRandomString():
    return base64.b64encode(os.urandom(5)).decode('utf-8')

def convertToCSV(filePath):
    if "xlsx" in filePath:
        read_file = pd.read_excel (filePath)
        fileName = filePath+".csv"

        read_file.to_csv (fileName, index = None, header=True)
        os.system('rm "'+filePath + '"')
        # call function to fill db
        os.system('python3 fillDB.py "' + fileName + '"&')
    else:
        print("File not in xlsx format")
        os.system("rm "+filePath)

def checkEmail():
    global last_read_email
    with open("database/loop.txt", "a+") as myfile:
        myfile.write("\n")
        myfile.write(str(time.time()))
    email_user = os.environ.get('EMAIL_USER')
    email_password = os.environ.get('EMAIL_PASS')

    mail = imaplib.IMAP4_SSL('imap.gmail.com', 993)
    mail.login(email_user, email_password)
    mail.select('inbox')

    type, data = mail.search(None, 'FROM ' + sender_email)
    mail_ids = data[0]
    id_list = mail_ids.split()
    
    # check attachment for latest email
    latest_email_id = id_list[-1]
    typ, data = mail.fetch(latest_email_id, '(RFC822)')
    raw_email = data[0][1]
    raw_email_string = raw_email.decode('utf-8')
    email_message = email.message_from_string(raw_email_string)
    for part in email_message.walk():
        if part.get_content_maintype() == 'multipart':
            continue
        if part.get('Content-Disposition') is None:
            continue

        # get date of email
        date = email_message['Date']
        if date == last_read_email:
            return
        last_read_email = date
        fileName = part.get_filename()
        if bool(fileName):
            filePath = os.path.join(r"./", fileName)
            if not os.path.isfile(filePath) and "xlsx" in fileName:
                print("File not found")
                print("Downloading File")
                fp = open(filePath, 'wb')
                fp.write(part.get_payload(decode=True))
                fp.close()
                print("File Downloaded")
                convertToCSV(filePath)
            else:
                print("File already exists")

# before this loop first check email and then run web scraper in background
checkEmail()
os.system("python refreshDB.py &") # web scraper turned on
time.sleep(60*60)
while True:
    checkEmail()
    # append loop in txt file
    with open("database/loop.txt", "a+") as myfile:
        myfile.write("\n")
        myfile.write(str(time.time()))
    time.sleep(60*60)