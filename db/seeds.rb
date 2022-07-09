# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Item.destroy_all
Section.destroy_all 

phillys = Section.create!(name: 'Phillys', vegan_options: false, labor_intensity: 4)
vegan_phillys = Section.create!(name: 'Vegan Phillys', vegan_options: true, labor_intensity: 5)
sides = Section.create!(name: 'Sides', vegan_options: true, labor_intensity: 3)
drinks = Section.create!(name: 'Drinks', vegan_options: true, labor_intensity: 1)
kids = Section.create!(name: 'Kids', vegan_options: true, labor_intensity: 2)

phillys.items.create!(name: 'Steak Philly', need_restock: false, price: 10)
phillys.items.create!(name: 'Chicken Philly', need_restock: true, price: 10)

vegan_phillys.items.create!(name: 'Vegan Far East', need_restock: true, price: 15)
vegan_phillys.items.create!(name: 'Vegan Philly', need_restock: true, price: 12)
vegan_phillys.items.create!(name: 'Vegan Chicken Philly', need_restock: true, price: 12)

sides.items.create!(name: 'Pickle Fries', need_restock: false, price: 6)
sides.items.create!(name: 'Vegan Poutine', need_restock: true, price: 10)
sides.items.create!(name: 'Fries', need_restock: false, price: 4)
sides.items.create!(name: 'Cheese Fries', need_restock: false, price: 7)

drinks.items.create!(name: 'Soda', need_restock: false, price: 3)
drinks.items.create!(name: 'Beer', need_restock: false, price: 5)

kids.items.create!(name: 'Grilled Cheese', need_restock: false, price: 6)
kids.items.create!(name: 'Vegan Grilled Cheese', need_restock: false, price: 8)






