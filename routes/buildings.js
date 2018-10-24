const express = require('express');
const router = express.Router();
const Building = require('../db/building');

var building_query = "SELECT jsonb_build_object('type', 'FeatureCollection','features', jsonb_agg(features.feature)) FROM ( SELECT jsonb_build_object('type', 'Feature','id', id,'geometry', ST_AsGeoJSON(geom)::jsonb,'properties', to_jsonb(inputs) - 'id' - 'geom') AS feature FROM (SELECT * FROM building) inputs) features";


router.get('/', (req, res, next) => {
  Building.getAllBuildings().then(function (data) {
      res.render('buildings', {
        title: "All Buildings",
        jsonData: data
      })
    })
    .catch(function (err) {
      return next(err);
    });
});

router.get('/management', (req, res) => {
  res.render('management', {
    title: "Manage des halls"
  })
});

router.get('/schedule', (req, res) => {
  res.render('schedule', {
    title: "Schedule"
  })
});

router.get('/create', (req, res) => {
  res.render('create', {
    title: "Create a Building"
  })
});

router.post('/create', (req, res) => {
  db.none('insert into building(name, breed, age, sex)' +
      'values(${name}, ${breed}, ${age}, ${sex})',
      req.body)
    .then(function () {
      res.status(200)
        .json({
          status: 'success',
          message: 'Inserted one Building'
        });
    })
    .catch(function (err) {
      return next(err);
    });
});

router.get('/getdata', (req, res) => {
  Building.getRawQuery(building_query).then(function (result) {
    res.send(result);
    res.end();
  })
})

router.get('/geojson', (req, res) => {
  Building.getRawQuery(building_query).then(function (data) {
    res.render('map', {
      title: "Express API", // Give a title to our page
      jsonData: data // Pass data to the View
    })
  })
})


router.get('/:id', (req, res, next) => {
  if (!isNaN(req.params.id)) {
    Building.getOne(req.params.id).then(function (data) {
        res.status(200)
          .json({
            status: 'success',
            data: data,
            message: 'Retrieved ONE Building'
          });
      })
      .catch(function (err) {
        return next(err)
      })
  } else {
    res.Error(res, 404, "User Not Found");
  }
})


router.put('/:id', (req, res, next) => {
  if (!isNaN(req.params.id)) {
    Building.updateBuilding(req.params.id).then(function () {
        res.status(200)
          .json({
            status: 'success',
            message: 'Updated Building'
          })
      })
      .catch(function (err) {
        return next(err);
      })
  } else {
    res.Error(res, 404, "User Not Found");
  }
});



router.delete('/:id', (req, res, next) => {
  if (!isNaN(req.params.id)) {
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
      })
  } else {
    res.Error(res, 404, "User Not Found");
  }
})


module.exports = router;