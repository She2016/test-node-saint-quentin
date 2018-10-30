exports.up = function (knex, Promise) {
  return knex.schema.createTable('messages', table => {
    table.increments('id')
    table.string('title').notNullable()
    table.string('message').notNullable()

    table.bigInteger('sender_id').unsigned().index().references('id').inTable('users')
    table.bigInteger('receiver_id').unsigned().index().references('id').inTable('users')

    table.timestamps()
  });
};

exports.down = function (knex, Promise) {
  return knex.schema.dropTable('messages')
};