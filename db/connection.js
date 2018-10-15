// const knex = require('knex')({
//     client: 'pg',
//     connection: {
//       host : 'localhost',
//       port: '5433',
//       user : 'postgres',
//       password : '1234',
//       database : 'saint_quntin',
//       charset   : 'utf8'
//     }
// });

// module.exports = knex;

// var pg = require('pg');
// var client  = new pg.Client({
//     host : 'localhost',
//     port: '5433',
//     user : 'postgres',
//     password : '1234',
//     database : 'saint_quntin'
//   });

// client.connect();
// module.exports.con = client;

const environment = process.env.NODE_ENV || 'development';
const config = require('../knexfile')[environment];
module.exports = require('knex')(config);