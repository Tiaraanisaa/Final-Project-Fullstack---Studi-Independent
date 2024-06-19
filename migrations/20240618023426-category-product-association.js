'use strict';

/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up (queryInterface, Sequelize) {
    queryInterface.addConstraint('products', {
      fields: ['categoryId'],
      type: 'foreign key',
      name: 'category_product_association',
      references: {
        table: 'categories',
        field: 'id'
      }
    })
  },

  async down (queryInterface, Sequelize) {
    queryInterface.removeConstraint('products', {
      fields: ['categoryId'],
      type: 'foreign key',
      name: 'category_product_association',
      references: {
        table: 'categories',
        field: 'id'
      }
    })
  }
};
