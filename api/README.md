# 30DaysOfCloudLeaderBoard

API based on flask for showing the leaderboard of participants in 30 days of google cloud

## Documentation of API
https://documenter.getpostman.com/view/16462223/UUy7aPBK

### Uploading CSV file of data
If you upload the CSV file data of the contestants once from then on out the system will automatically periodically keep scraping for updated scores of the contestants.<br>

### Emailing Contestant Data to Backend
If you plan to mail the API the new excel sheet that is sent to you by Google then you just need to send the email of the system (that you created) and attach the excel sheet. 
Mention the senders email id the ```SENDER_EMAIL``` in the ```SENDER_EMAIL``` field in the docker-compose file
Put in the credentials of the receiver emails in the ```EMAIL_USER``` and ```EMAIL_PASS``` fields. 

Now whenever you send the excel sheet from the ```SENDER_EMAIL``` to ```EMAIL_USER``` the backend system will convert the excel file to a CSV file and get the relevant data out of it and make the necessary changes to the database.

### Note: 
After sending the email to the bot or uploading the CSV file or adding users explicitly the backend system will periodically fetch scores from the user public qwikLab profile URLs automatically and will update the leaderboard accordingly


The database of the entire leaderboard will be stored in ```leaderboard.sqlite``` in ```api/api/database/```
