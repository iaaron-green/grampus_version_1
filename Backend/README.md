# FirstApp

Database steps
1. https://dev.mysql.com/downloads/windows/installer/
2. creare db

 - login: root
 - pass: admin
  
3. Switch from from administrator to Schemas
   in white field write next command:
   CREATE DATABASE grampus_db;

Instance steps
1. install java
2. open console
3. cd /...path to downloaded archive
4. java -jar first-app-artifact-grampus-profile-update.war

Postman steps
1. POST Register new User:  http://localhost:8080/api/users/register
2. POST Login User:  http://localhost:8080/api/users/login  (Generates user token if user was already created)

3. GET All Profiles: http://localhost:8080/api/profiles/all  (you shoud input user token to header)
   or Search Profiles http://localhost:8080/api/profiles/all?fullname="" (you should input value in double quotes "" for search)
4. GET Profile by Id: http://localhost:8080/api/profiles/1    ( 1 - is profile ID)   
5. POST Update fields in profile: "http://localhost:8080/api/profiles/" (you shoud input user token to header for this request)

 -- You need to change Profile Id to Profile that you want to give Rating ( 1 - is profile ID)
 
 -- "ratingType" is a variable that represent Like: "like_best_looker", "like_super_worker", "like_extrovert"
    or Dislike type: "dislike_untidy", "dislike_deadliner", "like_introvert".
    
6. POST LikeProfile  http://localhost:8080/api/profiles/1/like (you shoud input user token to header and "ratingType" to JSON for this request)

7. POST DislikeProfile http://localhost:8080/api/profiles/1/dislike (you shoud input user token to header and "ratingType" to JSON for this request)









