# How to Run the project

1. You need [node.js](https://nodejs.org/en/) and [postgresql](https://www.postgresql.org/) to be installed on your machine.
2. Download or clone the project from : `https://github.com/She2016/test-node-saint-quentin`
3. Import backup.sql file which existes in the root of the project to postgresql.
4. From the command line enter the directory of the project and run

  > npm install 
  
  to install all the project dependencies.
5. Open the browser on `http://localhost:3000/` thats it!

## Technologies used
1. [Node.js](https://nodejs.org/en/)
2. [Pug](https://pugjs.org/api/getting-started.html)
3. [PostgreSQL](https://www.postgresql.org/)
4. [leaflet.js](https://leafletjs.com/)
5. [JQuery](https://jquery.com/)
6. [knex.js](https://knexjs.org/)


## Folders structur
 1. auth folder contains two files
    - `index.js` contains forms routes:
      - SignUp, Login, Logout, Newsletter, Suggestions
    - `middleware.js` contains three functions:
      - ensureLogin
      - allowAccess
      - allowAdmins