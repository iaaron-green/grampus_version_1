# FirstApp

Database steps
1. https://dev.mysql.com/downloads/windows/installer/
2.creare db
  login: root
  pass: admin
  
3. Switch from from administrator to Schemas
   in white field write next command:
   CREATE DATABASE grampus_db;

Instance steps
1. install java
2. open console
3. cd /...path to downloaded archive
4. java -jar first-app-artifact-1.0-SNAPSHOT.war

Postman steps
1. POST  register: http://localhost:8080/api/users/register
2. POST  login:    http://localhost:8080/api/users/login
3. GET   all profiles: http://localhost:8080/api/profiles/all  (you shoud input user tocken to header)
4. GET   profile by id: http://localhost:8080/api/profiles/1   (you shoud input user tocken to header)
5. POST input smth for change: http://localhost:8080/api/profile (you should take json for this request from one of previous get)









