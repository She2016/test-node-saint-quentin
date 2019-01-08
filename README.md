# How to Run the project

1. You need [node.js](https://nodejs.org/en/) and [postgresql](https://www.postgresql.org/) to be installed on your machine.
2. Download or clone the project from : `https://github.com/She2016/test-node-saint-quentin`
3. Import backup.sql file which existes in the root of the project to postgresql.
4. From the command line enter the directory of the project and run

> npm install

to install all the project dependencies.

5. From the terminal run

> node start

6. Open the browser on `http://localhost:3000/` thats it! The port number can be modified from the file `bin/www`.

## Technologies used

1. [Node.js](https://nodejs.org/en/)
2. [Pug](https://pugjs.org/api/getting-started.html)
3. [PostgreSQL](https://www.postgresql.org/)
4. [leaflet.js](https://leafletjs.com/)
5. [JQuery](https://jquery.com/)
6. [knex.js](https://knexjs.org/)

## Folders structur

1. auth folder contains two files:

   - `index.js` contains forms routes:
    	- SignUp, Login, Logout, Newsletter, Suggestions.
   - `middleware.js` contains three functions:
    	- ensureLogin : to ensure that a user logged in.
    	- allowAccess : verify if a user has a permission to access.
    	- allowAdmins : verify if the user has admin permissions.

2. db folder contains three files:

   - `connection.js`which setup the connection with the database.
   - `building.js` and `user.js` contains functions to retrive data from the database.

3. public folder contains all the front-end assets which are used in the application such as images, css, js, etc.
   in javascripts folder there is:

   - `login.js` file, contains the submission of login, signup and setting session variables.
   - `mapConfiguration.js` file is embedded in the index page (home page) in views folder contains all the map settings such as adding layers, configuring zoom level, etc.

4. routes folder contains all the application routers:

   - `index.js` contains all basic routes. Ex: http://localhost:3000/
   - `buildings.js` contains all the routes concerning the buildings. Ex: http://localhost:3000/building/
   - `users.js` contains all the routes concerning the users. Ex: http://localhost:3000/users/

5. views folder contains all view pages
   - `templates` folder contains `layout.pug` which is the master page for the tha admin panel, and `layoutt.pug` which is the master page for the user interface.
   - `buildings` folders contains all the pages which are realted to the buildings, and so on.


6. `app.js` is the heart of the application, here we do the following things:
	- Import all used packages in the application.
	- Import and set the routes for the app.
	- Set the view file for the app.
	- Set the public folder as the container of the front-end files such as css, js, etc.

7. `knexfile.js` set the connection with the postgreSQL database.

8. `package.json` contias all the dependencies which are used in this application.

9. Migrations allow to define sets of schema changes so upgrading a database is a breeze for details [Migrations](https://knexjs.org/#Migrations).

