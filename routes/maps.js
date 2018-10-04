var express = require('express');
var fs = require('fs');
var geobing = require('geobing');
var csv = require("fast-csv");
var router = express.Router();

// var pgp = require('pg-promise')(options);
// // Setup connection
var username = "postgres" // sandbox username
var password = "1234" // read only privileges on our table
var host = "localhost:5433"
var database = "saint_quntin" // database name
var conString = "postgres://" + username + ":" + password + "@" + host + "/" + database; // Your Database Connection

//var db = pgp(connectionString);
/* PostgreSQL and PostGIS module and connection setup */
const { Client, Query } = require('pg')

geobing.setKey("AnDzjy0uPm1-k3hkW2P6so-OBH4lerjGw9CuT7eCN6zos-weYUf2Her8eaoeMh8E");

// Set up your database query to display GeoJSON
var coffee_query = "SELECT row_to_json(fc) FROM ( SELECT 'FeatureCollection' As type, array_to_json(array_agg(f)) As features FROM (SELECT 'Feature' As type, ST_AsGeoJSON(lg.geom)::json As geometry, row_to_json((id, nom, street_name)) As properties FROM building As lg) As f) As fc";

/* GET home page. */
router.get('/', function (req, res, next) {
  res.render('index', { title: 'Express' });
});

/* GET Postgres JSON data */
router.get('/data', function (req, res) {
  var client = new Client(conString);
  client.connect();
  var query = client.query(new Query(coffee_query));
  query.on("row", function (row, result) {
    result.addRow(row);
  });
  query.on("end", function (result) {
    res.send(result.rows[0].row_to_json);
    res.end();
  });
});

router.get('/geocoder', function (req, res) {

      var item = {};
      geobing.getInfoFromCoordinates({ lat: 49.848450637924, lng: 3.29963207244873 }, function (err, result) {
        item.address = result.address.formattedAddress;
        item.city = result.address.locality;
        item.country = result.address.countryRegion;
        item.zip = result.address.postalCode;
        item.street = result.address.addressLine;
        item.district = result.address.adminDistrict;
    
        res.send(result)
    })
});

/* GET the map page */
router.get('/map', function (req, res) {
  var client = new Client(conString); // Setup our Postgres Client
  client.connect(); // connect to the client
  var query = client.query(new Query(coffee_query)); // Run our Query
  query.on("row", function (row, result) {
    result.addRow(row);
  });
  // Pass the result to the map page
  query.on("end", function (result) {
    var data = result.rows[0].row_to_json // Save the JSON as variable data
    res.render('map', {
      title: "Express API", // Give a title to our page
      jsonData: data // Pass data to the View
    });
  });
});

/* GET the filtered page */
router.get('/filter*', function (req, res) {
  var name = req.query.name;
  if (name.indexOf("--") > -1 || name.indexOf("'") > -1 || name.indexOf(";") > -1 || name.indexOf("/*") > -1 || name.indexOf("xp_") > -1) {
    console.log("Bad request detected");
    res.redirect('/map');
    return;
  } else {
    console.log("Request passed")
    var filter_query = "SELECT row_to_json(fc) FROM ( SELECT 'FeatureCollection' As type, array_to_json(array_agg(f)) As features FROM (SELECT 'Feature' As type, ST_AsGeoJSON(lg.geom)::json As geometry, row_to_json((id, name)) As properties FROM coffee_shops As lg WHERE lg.name = \'" + name + "\') As f) As fc";
    var client = new Client(conString);
    client.connect();
    var query = client.query(new Query(filter_query));
    query.on("row", function (row, result) {
      result.addRow(row);
    });
    query.on("end", function (result) {
      var data = result.rows[0].row_to_json
      res.render('map', {
        title: "Express API",
        jsonData: data
      });
    });
  };
});

module.exports = router;
