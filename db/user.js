const knex = require('./connection');

module.exports = {
  getOne: function (id) {
    return knex('users').where('id', id).first();
  },
  getOneByEmail : function(email) {
    return knex('users').where('email', email).first()
  },
  create: function(user) {
    return knex('users').insert(user, 'id').then(ids => {
      return ids[0]
    })
  },
  edit: function (id, user) {
    return knex('users').where('id', id)
    .update(user)
  },
  delete(id) {
    return knex('users').where('id', id).del();
  },
  getAllUsers: function() {
    return knex.select().table('users')
  },
  getAllUsersTypes: function() {
    return knex.select().table('user_types')
  }
}
