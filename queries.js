var promise = require('bluebird');

var options = {
  // Initialization Options
  promiseLib: promise
};

var pgp = require('pg-promise')(options);
// Setup connection
var username = "postgres" // sandbox username
var password = "1234" // read only privileges on our table
var host = "localhost:5433"
var database = "saint_quntin" // database name
//var connectionString = "postgres://" + username + ":" + password + "@" + host + "/" + database; // Your Database Connection
var connectionString = "postgres://whtpqluhyozweu:8c5ba5e1c23879e5d644b0eb41e1439bfacbcc3ce9113f0e250d3130d30a9a0c@ec2-54-243-147-162.compute-1.amazonaws.com:5432/dd5brmmo1hjtsg"; // Your Database Connection

var db = pgp(connectionString);

// add query functions


const { Client, Query } = require('pg')

function index(req, res, next) {
  res.render('index', {
    title: "Home"
  })
}

function dynamic(req, res, next) {
  res.render('dynamic', {
    title: "Dynamic data"
  })
}

function model(req, res, next) {
  res.render('model', {
    title: "3D Model"
  })
}

function management(req, res, next) {
  res.render('management', {
    title: "Manage des halls"
  })
}

function getAllBuildings(req, res, next) {
  db.any('select * from building')
    .then(function (data) {
      res.render('buildings', {
        title: "All Buildings",
        jsonData: data
      })
    })
    .catch(function (err) {
      return next(err);
    });
}

function create(req, res, next) {
      res.render('createBuilding', {
        title: "Create a Building"
      })
}

function getData(req, res, next) {
  var building_query = "SELECT row_to_json(fc) FROM ( SELECT 'FeatureCollection' As type, array_to_json(array_agg(f)) As features FROM (SELECT 'Feature' As type, ST_AsGeoJSON(lg.geom)::json As geometry, row_to_json((id, nom, code_postal)) As properties FROM building As lg) As f) As fc";
  var client = new Client(connectionString);
  client.connect();
  var query = client.query(new Query(building_query)); // Run our Query
  query.on("row", function (row, result) {
    result.addRow(row);
  });
  query.on("end", function (result) {
    res.send(result.rows[0].row_to_json);
    res.end();
  });
}


function getGeoJSON(req, res, next) {
  var building_query = "SELECT row_to_json(fc) FROM ( SELECT 'FeatureCollection' As type, array_to_json(array_agg(f)) As features FROM (SELECT 'Feature' As type, ST_AsGeoJSON(lg.geom)::json As geometry, row_to_json((id, nom, code_postal)) As properties FROM building As lg) As f) As fc";
  var client = new Client(connectionString);
  client.connect();
  var query = client.query(new Query(building_query)); // Run our Query
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
}

function getSingleBuilding(req, res, next) {
  var BuildingID = parseInt(req.params.id);
  db.one('select * from building where id = $1', BuildingID)
    .then(function (data) {
      res.status(200)
        .json({
          status: 'success',
          data: data,
          message: 'Retrieved ONE Building'
        });
    })
    .catch(function (err) {
      return next(err);
    });
}

function createBuilding(req, res, next) {
  console.log("herer")
  console.log(req.body)
  // db.none('insert into building(name, breed, age, sex)' +
  //   'values(${name}, ${breed}, ${age}, ${sex})',
  //   req.body)
  //   .then(function () {
  //     res.status(200)
  //       .json({
  //         status: 'success',
  //         message: 'Inserted one Building'
  //       });
  //   })
  //   .catch(function (err) {
  //     return next(err);
  //   });
}

function updateBuilding(req, res, next) {
  db.none('update building set name=$1, breed=$2, age=$3, sex=$4 where id=$5',
    [req.body.name, req.body.breed, parseInt(req.body.age),
    req.body.sex, parseInt(req.params.id)])
    .then(function () {
      res.status(200)
        .json({
          status: 'success',
          message: 'Updated Building'
        });
    })
    .catch(function (err) {
      return next(err);
    });
}

function removeBuilding(req, res, next) {
  var BuildingID = parseInt(req.params.id);
  db.result('delete from building where id = $1', BuildingID)
    .then(function (result) {
      /* jshint ignore:start */
      res.status(200)
        .json({
          status: 'success',
          message: `Removed ${result.rowCount} Building`
        });
      /* jshint ignore:end */
    })
    .catch(function (err) {
      return next(err);
    });
}
module.exports = {
  index: index,
  dynamic: dynamic,
  model: model,
  management: management,
  getData: getData,
  getAllBuildings: getAllBuildings,
  getGeoJSON: getGeoJSON,
  getSingleBuilding: getSingleBuilding,
  create: create,
  createBuilding: createBuilding,
  updateBuilding: updateBuilding,
  removeBuilding: removeBuilding
};