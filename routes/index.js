var express = require('express');
var router = express.Router();

var db = require('../db/queries');


router.get('/', db.index);
router.get('/dynamic', db.dynamic);
router.get('/model', db.model);
router.get('/management', db.management);
router.get('/schedule', db.schedule);

router.get('/buildings', db.getAllBuildings);
router.get('/getdata', db.getData);
router.get('/geojson', db.getGeoJSON);
router.get('/buildings/:id', db.getSingleBuilding);
router.get('/create', db.create);
router.post('/buildings', db.createBuilding);
router.put('/buildings/:id', db.updateBuilding);
router.delete('/buildings/:id', db.removeBuilding);


module.exports = router;