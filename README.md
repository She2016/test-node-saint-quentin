# How to Run the project

1. You need [node.js](https://nodejs.org/en/) and [postgresql](https://www.postgresql.org/) to be installed on your machine.
2. Download or clone the project from : `https://github.com/She2016/test-node-saint-quentin`
3. Import backup.sql file which existes in the root of the project to postgresql.
4. From the command line enter the directory of the project and run

  > npm install 
  
  to install all the project dependencies.
5. Open the browser on `http://localhost:3000/` thats it!

## Folders structur
 1. auth folder contains two files
    - `index.js` contains forms routes:
      - SignUp : verify if the user name and email are valid, verify the email is unique, then hash the password and create the user in the database, and save its information in the cookies.
      - Login : verify if the user name and email are valid, verify the credentials correct , then save its information in the cookies. 