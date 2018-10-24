const knex = require('./connection');

module.exports = {
  getOne: function (id) {
    return knex('building').where('id', id).first();
  },
  create: function(building) {
    return knex('building').insert(building, 'id').then(ids => {
      return ids[0]
    })
  },
  getAllBuildings: function() {
    return knex.select().table('building')
  },
  getRawQuery: function(query) {
    return knex.raw(query).then(function (result) {
      return result.rows[0].jsonb_build_object      
    })
  },
  updateBuilding: function(id) {
    return knex('building').where('id', id).update({ nom : 'La Manufacture update'})
  }

}